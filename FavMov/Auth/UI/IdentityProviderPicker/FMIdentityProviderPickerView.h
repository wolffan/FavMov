#import "FMView.h"

typedef void(^FMIdentityProviderPickedBlock)(NSUInteger identityProviderIndex);

@interface FMIdentityProviderPickerView : FMView
@property(nonatomic, copy) FMIdentityProviderPickedBlock pickedBlock;

- (void)updateWithIdentityProviders:(NSArray *)identityProviders;
@end
