#import "FMUserRetriever.h"

#import "FMAuthenticator.h"
#import "FMIdentityProviderPickerViewController.h"
#import "FMIdentityProviderStore.h"
#import "FMIdentityProvider.h"

@implementation FMUserRetriever

- (void)retrieveUserAllowLogin:(BOOL)allowLogin
                    completion:(FMUserRetrievalCompletionBlock)onCompletion {
  NSArray *identityProviders = [FMIdentityProviderStore allIdentityProviders];
  
  FMUser *authenticatedUser = [self authenticatedUserWithIdentityProviders:identityProviders];
  if (authenticatedUser != nil) {
    onCompletion? onCompletion(authenticatedUser, nil) : NULL;
    return;
  }
  
  id<FMIdentityProvider> identityProviderAllowingSilientLogIn =
      [self identityProviderAllowingSilentLogInFromIdentityProviders:[FMIdentityProviderStore allIdentityProviders]];
  if (identityProviderAllowingSilientLogIn != nil) {
    [identityProviderAllowingSilientLogIn.authenticator loginSilentlyWithCompletion:^(FMUser *user, NSError *error) {
      onCompletion? onCompletion(user, nil) : NULL;
    }];
    return;
  }
  
  if (!allowLogin) {
    onCompletion? onCompletion(nil, nil) : NULL;
    return;
  }

  NSAssert(self.loginPresentingViewController != nil,
           @"Login flow presenting view controller must be set in the user "
           @"retriever, %@ ,in order to launch a login flow.", self);
  
  FMIdentityProviderPickerViewController *identityProviderPicker =
      [[FMIdentityProviderPickerViewController alloc] initWithNibName:nil
                                                               bundle:nil
                                                    identityProviders:identityProviders];
  identityProviderPicker.completionBlock = ^(id<FMIdentityProvider> identityProvider, NSError *error){
    if (!identityProvider && !error) {
      // User cancelled.
      onCompletion? onCompletion(nil, nil) : NULL;
      [self.loginPresentingViewController dismissViewControllerAnimated:YES completion:nil];
    }
    
    if (identityProvider != nil) {
      [identityProvider.authenticator
       launchLoginFlowWithCompletion:^(FMUser *user,
                                       NSError *error){
         onCompletion? onCompletion(user, nil) : NULL;
         [self.loginPresentingViewController dismissViewControllerAnimated:YES completion:nil];
      }];
    }
    
    
  };
  UINavigationController *loginFlowViewController = [UINavigationController new];
  [loginFlowViewController setViewControllers:@[identityProviderPicker] animated:NO];
  [self presentLoginFlow:loginFlowViewController];
}

- (id<FMIdentityProvider>)identityProviderAllowingSilentLogInFromIdentityProviders:(NSArray *)identityProviders {
  for (id<FMIdentityProvider> identityProvider in identityProviders) {
    if ([identityProvider.authenticator isSilentLoginAvailable]) {
      return identityProvider;
    }
  }
  return nil;
}

- (FMUser *)authenticatedUserWithIdentityProviders:(NSArray *)identityProviders {
  for (id<FMIdentityProvider> identityProvider in identityProviders) {
    FMUser *authenticatedUser = [identityProvider.authenticator authenticatedUser];
    if (authenticatedUser != nil) {
      return authenticatedUser;
    }
  }
  return nil;
}

- (void)presentLoginFlow:(UIViewController *)loginFlowViewController {
  if (self.presentationBlock != nil) {
    self.presentationBlock(self.loginPresentingViewController, loginFlowViewController);
  } else {
    [self.loginPresentingViewController presentViewController:loginFlowViewController
                                                     animated:YES
                                                   completion:nil];
  }
}

@end
