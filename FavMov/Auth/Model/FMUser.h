#import <Foundation/Foundation.h>

@protocol FMIdentityProvider;

@interface FMUser : NSObject
@property(nonatomic, copy, readonly) NSString *name;
@property(nonatomic, strong, readonly) id<FMIdentityProvider> identityProvider;

- (UIView *)newProfilePictureView;
- (void)logout;
@end
