#import "FMIdentityProviderTwitter.h"

#import "UIColor+FMColors.h"

#import "FMTwitterAuthenticator.h"

@implementation FMIdentityProviderTwitter

- (NSString *)name {
  return @"Twitter";
}

- (UIColor *)loginButtonColor {
  return [UIColor fm_twitterColor];
}

- (id<FMAuthenticator>)authenticator {
  return nil;
}

@end
