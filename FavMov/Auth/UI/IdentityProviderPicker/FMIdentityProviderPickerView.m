#import "FMIdentityProviderPickerView.h"

#import "FMView_Protected.h"

#import "UIColor+FMColors.h"
#import "UIView+FLKAutoLayout.h"

#import "FMIdentityProvider.h"

UIButton * newLoginButton(id<FMIdentityProvider> identityProvider){
  UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
  NSString *title = [NSString stringWithFormat:@"Login with %@", [identityProvider name]];
  [button setTitle:title forState:UIControlStateNormal];
  [button setTintColor:[identityProvider loginButtonColor]];
  return button;
}

@interface FMIdentityProviderPickerView ()<UINavigationBarDelegate>
@property(nonatomic, copy) NSArray *loginButtons;
@end

@implementation FMIdentityProviderPickerView

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    self.backgroundColor = [UIColor whiteColor];
    _loginButtons = @[];
  }
  return self;
}

- (void)updateWithIdentityProviders:(NSArray *)identityProviders {
  if (identityProviders == nil || [identityProviders count] == 0) {
    return;
  }
  
  NSMutableArray *loginButtons = [NSMutableArray arrayWithCapacity:[identityProviders count]];
  for (id<FMIdentityProvider> identityProvider in identityProviders) {
    UIButton *loginButton = newLoginButton(identityProvider);
    [loginButton addTarget:self
                    action:@selector(didPressLoginButton:)
          forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:loginButton];
    [loginButtons addObject:loginButton];
  }
  self.loginButtons = loginButtons;
 
  [self.loginButtons[0] alignTopEdgeWithView:self predicate:@"100"];
  for (UIView *button in self.loginButtons) {
    [button alignCenterXWithView:self predicate:@"0"];
  }
  
  if ([self.loginButtons count] > 1) {
    [UIView spaceOutViewsVertically:self.loginButtons predicate:@"20"];
  }
}

- (void)didPressLoginButton:(UIButton *)sender {
  if (self.pickedBlock) {
    self.pickedBlock([self.loginButtons indexOfObject:sender]);
  }
}

@end
