#import <Foundation/Foundation.h>

@protocol FMAuthenticator;

@protocol FMIdentityProvider <NSObject>
- (NSString *)name;
- (UIColor *)loginButtonColor;
- (id<FMAuthenticator>)authenticator;
@end
