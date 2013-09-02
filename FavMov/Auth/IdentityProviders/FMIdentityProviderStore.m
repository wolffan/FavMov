#import "FMIdentityProviderStore.h"

#import "FMIdentityProviderFacebook.h"
#import "FMIdentityProviderTwitter.h"

@implementation FMIdentityProviderStore

+ (NSArray *)allIdentityProviders {
  static NSArray *identityProviders;
  if (identityProviders == nil) {
    identityProviders = @[[FMIdentityProviderFacebook new], [FMIdentityProviderTwitter new]];
  }
  return [identityProviders copy];
}

@end
