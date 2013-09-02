#import <Foundation/Foundation.h>

@class FMUser;

typedef void(^FMAuthenticatorCompletionBlock)(FMUser *user, NSError *error);

@protocol FMAuthenticator <NSObject>
- (FMUser *)authenticatedUser;
- (BOOL)isSilentLoginAvailable;
- (void)loginSilentlyWithCompletion:(FMAuthenticatorCompletionBlock)onCompletion;
- (void)launchLoginFlowWithCompletion:(FMAuthenticatorCompletionBlock)onCompletion;
- (void)logoutAuthenticatedUser;
@end
