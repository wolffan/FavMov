#import "FMIdentityProviderFacebook.h"

#import "UIColor+FMColors.h"

#import "FMFacebookAuthenticator.h"

@implementation FMIdentityProviderFacebook

- (NSString *)name {
  return @"Facebook";
}

- (UIColor *)loginButtonColor {
  return [UIColor fm_facebookColor];
}

- (id<FMAuthenticator>)authenticator {
  return [FMFacebookAuthenticator sharedInstance];
}

@end
