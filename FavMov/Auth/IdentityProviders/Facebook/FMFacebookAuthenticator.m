#import "FMFacebookAuthenticator.h"

#import <FacebookSDK/FacebookSDK.h>

#import "FMFacebookUser.h"

@interface FMFacebookAuthenticator ()
@property(nonatomic, strong) NSMutableArray *completionBlocks;
@property(nonatomic, assign) BOOL isAuthenticating;
@property(nonatomic, strong) FMUser *authenticatedUser;
@end

@implementation FMFacebookAuthenticator

+ (instancetype)sharedInstance {
  static FMFacebookAuthenticator *sharedInstance = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    sharedInstance = [self new];
  });
  return sharedInstance;
}

- (instancetype)init {
  self = [super init];
  if (self) {
    _completionBlocks = [NSMutableArray array];
    _isAuthenticating = NO;
  }
  return self;
}

- (BOOL)isSilentLoginAvailable {
  if (FBSession.activeSession.state == FBSessionStateCreatedTokenLoaded) {
    return YES;
  }
  return NO;
}

- (void)loginSilentlyWithCompletion:(FMAuthenticatorCompletionBlock)onCompletion {
  if (![self isSilentLoginAvailable]) {
    // TODO: Add Error.
    onCompletion? onCompletion(nil, nil) : NULL;
    return;
  }
  
  if (onCompletion != nil) {
    [self.completionBlocks addObject:[onCompletion copy]];
  }
  
  if (self.isAuthenticating) {
    return;
  }
  self.isAuthenticating = YES;
  [FBSession openActiveSessionWithReadPermissions:nil
                                     allowLoginUI:NO
                                completionHandler:[self newStateHandler]];
}

- (void)launchLoginFlowWithCompletion:(FMAuthenticatorCompletionBlock)onCompletion {
  if (FBSession.activeSession.state == FBSessionStateOpen) {
    if (self.authenticatedUser != nil) {
      onCompletion? onCompletion(nil, nil) : NULL;
    } else if (self.isAuthenticating) {
      if (onCompletion != nil) {
        [self.completionBlocks addObject:[onCompletion copy]];
      }
    } else {
      NSAssert(NO, @"Facebook session is open and graph user was not fetched, there may have"
                   @" been an error fetching the authenticated graph user.");
    }
    return;
  }
  
  if (onCompletion != nil) {
    [self.completionBlocks addObject:[onCompletion copy]];
  }
  
  if (self.isAuthenticating) {
    return;
  }
  self.isAuthenticating = YES;
  [FBSession openActiveSessionWithReadPermissions:nil
                                     allowLoginUI:YES
                                completionHandler:[self newStateHandler]];
}

- (FBSessionStateHandler)newStateHandler {
  FMBlockWeakSelf weakSelf = self;
  FBSessionStateHandler stateHandler = ^(FBSession *session,
                                         FBSessionState state,
                                         NSError *error) {
    [weakSelf sessionStateChanged:session state:state error:error];
  };
  return stateHandler;
}

- (void)logoutAuthenticatedUser {
  [FBSession.activeSession closeAndClearTokenInformation];
}

- (void)sessionStateChanged:(FBSession *)session
                      state:(FBSessionState) state
                      error:(NSError *)error {
  switch (state) {
    case FBSessionStateOpen:
      [self fetchGraphUser];
      break;
      
    case FBSessionStateClosedLoginFailed:
      self.isAuthenticating = NO;
      self.authenticatedUser = nil;
      if ([self.completionBlocks count] > 0) {
        for (FMAuthenticatorCompletionBlock completionBlock in self.completionBlocks) {
          // TODO: Make sure error is populated for this state.
          completionBlock? completionBlock(nil, error) : NULL;
        }
      }
      break;
      
    case FBSessionStateClosed:
      self.authenticatedUser = nil;
      break;
      
    default:
      break;
  }
}

- (void)fetchGraphUser {
  FMBlockWeakSelf weakSelf = self;
  [[FBRequest requestForMe] startWithCompletionHandler:^(FBRequestConnection *connection,
                                                         NSDictionary<FBGraphUser> *graphUser,
                                                         NSError *error) {
    if (error == nil) {
      weakSelf.authenticatedUser = [[FMFacebookUser alloc] initWithGraphUser:graphUser];
      for (FMAuthenticatorCompletionBlock completionBlock in self.completionBlocks) {
        completionBlock? completionBlock(weakSelf.authenticatedUser, nil) : NULL;
      }
      [weakSelf.completionBlocks removeAllObjects];
    }
    self.isAuthenticating = NO;
  }];
}

@end
