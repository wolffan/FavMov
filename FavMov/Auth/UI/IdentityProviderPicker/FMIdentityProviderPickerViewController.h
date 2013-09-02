#import <UIKit/UIKit.h>

@protocol FMIdentityProvider;

typedef void(^FMIdentityProviderPickerCompletionBlock)(id<FMIdentityProvider> identityProvider,
                                                       NSError *error);

@interface FMIdentityProviderPickerViewController : UIViewController
@property(nonatomic, copy) FMIdentityProviderPickerCompletionBlock completionBlock;

- (instancetype)initWithNibName:(NSString *)nibNameOrNil
                         bundle:(NSBundle *)nibBundleOrNil
              identityProviders:(NSArray *)identityProviders;
@end
