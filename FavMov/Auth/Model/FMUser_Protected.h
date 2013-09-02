#import "FMUser.h"

@interface FMUser ()
@property(nonatomic, copy, readwrite) NSString *name;
@property(nonatomic, strong, readwrite) id<FMIdentityProvider> identityProvider;
@end
