#import <Foundation/Foundation.h>

@class FMUser;

typedef void(^FMLoginFlowPresentationBlock)(UIViewController *presentingViewController,
                                            UIViewController *loginFlowViewController);
typedef void(^FMLoginFlowDismissalBlock)(FMUser *user,
                                         UIViewController *presentingViewController,
                                         NSError *error);
typedef void(^FMUserRetrievalCompletionBlock)(FMUser *user, NSError *error);

@interface FMUserRetriever : NSObject
@property(nonatomic, weak) UIViewController *loginPresentingViewController;
@property(nonatomic, copy) FMLoginFlowPresentationBlock presentationBlock;
@property(nonatomic, copy) FMLoginFlowDismissalBlock dismissalBlock;

- (void)retrieveUserAllowLogin:(BOOL)allowLogin
                    completion:(FMUserRetrievalCompletionBlock)onCompletion;
@end
