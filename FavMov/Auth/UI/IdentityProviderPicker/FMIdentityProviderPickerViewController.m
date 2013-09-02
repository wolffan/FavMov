#import "FMIdentityProviderPickerViewController.h"

#import "FMIdentityProviderPickerView.h"

UIBarButtonItem * newLoginCancelBarButtonItem(){
  return [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                       target:nil
                                                       action:NULL];
}

@interface FMIdentityProviderPickerViewController ()
@property(nonatomic, strong, readonly) FMIdentityProviderPickerView *identityProviderPickerView;
@property(nonatomic, copy) NSArray *identityProviders;
@end

@implementation FMIdentityProviderPickerViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil
                         bundle:(NSBundle *)nibBundleOrNil
              identityProviders:(NSArray *)identityProviders  {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    self.title = @"Login";
    self.navigationItem.leftBarButtonItem = newLoginCancelBarButtonItem();
    NSAssert(identityProviders != nil,
             @"Identity provider picker cannot function without an array of identity providers.");
    _identityProviders = [identityProviders copy];
  }
  return self;
}

- (void)loadView {
  self.view = [FMIdentityProviderPickerView new];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  UIBarButtonItem *cancelBarButtonItem = [self cancelBarButtonItem];
	cancelBarButtonItem.target = self;
  cancelBarButtonItem.action = @selector(cancel);
  
  FMBlockWeakSelf weakSelf = self;
  self.identityProviderPickerView.pickedBlock = ^(NSUInteger identityProviderIndex) {
    id<FMIdentityProvider> identityProvider =
        [weakSelf.identityProviders objectAtIndex:identityProviderIndex];
    weakSelf.completionBlock? weakSelf.completionBlock(identityProvider, nil) : NULL;
  };
  [self.identityProviderPickerView updateWithIdentityProviders:self.identityProviders];
}


- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)cancel {
  self.completionBlock? self.completionBlock(nil, nil) : NULL;
}

- (UIBarButtonItem *)cancelBarButtonItem {
  return self.navigationItem.leftBarButtonItem;
}

- (FMIdentityProviderPickerView *)identityProviderPickerView {
  return (FMIdentityProviderPickerView *)self.view;
}

@end
