#import "FMFacebookUser.h"
#import "FMUser_Protected.h"

#import <FacebookSDK/FacebookSDK.h>

#import "FMIdentityProviderFacebook.h"

@interface FMFacebookUser ()
@property(nonatomic, copy) NSString *userID;
@end

@implementation FMFacebookUser

- (instancetype)initWithGraphUser:(NSDictionary<FBGraphUser> *)graphUser {
  self = [super init];
  if (self) {
    self.name = [graphUser.name copy];
    self.identityProvider = [FMIdentityProviderFacebook new];
    _userID = [graphUser.id copy];
  }
  return self;
}

- (UIView *)newProfilePictureView {
  FBProfilePictureView *profilePictureView =
      [[FBProfilePictureView alloc] initWithProfileID:self.userID
                                      pictureCropping:FBProfilePictureCroppingSquare];
  return profilePictureView;
}

@end
