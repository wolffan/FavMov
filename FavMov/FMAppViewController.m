#import "FMAppViewController.h"

#import "UIColor+FMColors.h"
#import "UIView+FLKAutoLayout.h"

#import "FMMyFavoriteMovieViewController.h"
#import "FMFriendsViewController.h"

@interface FMAppViewController ()
@property(nonatomic, strong) FMMyFavoriteMovieViewController *myFavoriteMovieViewController;
@property(nonatomic, strong) FMFriendsViewController *friendsViewController;
@end

@implementation FMAppViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    // Custom initialization
  }
  return self;
}

- (void)loadView {
  self.view = [UIView new];
  self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewDidLoad {
  [super viewDidLoad];
	[self addMyFavoriteViewController];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)addMyFavoriteViewController {
  [self addChildViewController:self.myFavoriteMovieViewController];
  [self.view addSubview:self.myFavoriteMovieViewController.view];
  [self.myFavoriteMovieViewController.view alignCenterWithView:self.view];
  [self.myFavoriteMovieViewController.view alignTop:@"0"
                                            leading:@"0"
                                             bottom:@"0"
                                           trailing:@"0"
                                             toView:self.view];
}

- (void)removeMyFavoriteViewController {
  if ([self.childViewControllers containsObject:self.myFavoriteMovieViewController]) {
    [self.myFavoriteMovieViewController removeFromParentViewController];
    [self.myFavoriteMovieViewController.view removeFromSuperview];
    [self.myFavoriteMovieViewController.view
     removeConstraints:self.myFavoriteMovieViewController.view.constraints];
  }
}

- (void)addFriendsViewController {
  [self addChildViewController:self.friendsViewController];
  [self.view addSubview:self.friendsViewController.view];
  [self.friendsViewController.view alignCenterWithView:self.view];
  [self.friendsViewController.view alignTop:@"0"
                                    leading:@"0"
                                     bottom:@"0"
                                   trailing:@"0"
                                     toView:self.view];
}

- (void)removeFriendsViewController {
  if ([self.childViewControllers containsObject:self.friendsViewController]) {
    [self.friendsViewController removeFromParentViewController];
    [self.friendsViewController.view removeFromSuperview];
    [self.friendsViewController.view
     removeConstraints:self.friendsViewController.view.constraints];
  }
}

#pragma mark - Property Accessors

- (FMMyFavoriteMovieViewController *)myFavoriteMovieViewController {
  if (_myFavoriteMovieViewController == nil) {
    self.myFavoriteMovieViewController = [FMMyFavoriteMovieViewController new];
  }
  return _myFavoriteMovieViewController;
}

- (FMFriendsViewController *)friendsViewController {
  if (_friendsViewController == nil) {
    self.friendsViewController = [FMFriendsViewController new];
  }
  return _friendsViewController;
}

@end
