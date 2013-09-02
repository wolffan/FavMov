#import "FMUser.h"
#import "FMUser_Protected.h"

#import "FMAuthenticator.h"
#import "FMIdentityProvider.h"

@implementation FMUser

- (UIView *)newProfilePictureView {
  // Abstract Method.
  return nil;
}

- (void)logout {
  [self.identityProvider.authenticator logoutAuthenticatedUser];
}

@end
