#import "FMMyFavoriteMovieView.h"

#import "FMView_Protected.h"

#import "UIApplication+FMStatusBar.h"
#import "UIColor+FMColors.h"
#import "UIImage+FMImages.h"
#import "UIImageView+AFNetworking.h"
#import "UIView+FLKAutoLayout.h"

#import "FMUser.h"

UIBarButtonItem * newLoginBarButtonItem() {
  UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Login"
                                                                    style:UIBarButtonItemStylePlain
                                                                   target:nil
                                                                   action:NULL];
  return barButtonItem;
}

UIBarButtonItem * newLogoutBarButtonItem() {
  UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Logout"
                                                                    style:UIBarButtonItemStylePlain
                                                                   target:nil
                                                                   action:NULL];
  return barButtonItem;
}

UIBarButtonItem * newEditBarButtonItem() {
  UIImage *editImage = [UIImage fm_editImage];
  UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithImage:editImage
                                                                    style:UIBarButtonItemStylePlain
                                                                   target:nil
                                                                   action:NULL];
  return barButtonItem;
}

UINavigationItem * newFavMovieNavigationItem() {
  UINavigationItem *navigationItem = [[UINavigationItem alloc] initWithTitle:@"FavMov"];
  navigationItem.rightBarButtonItem = newEditBarButtonItem();
  return navigationItem;
}

UINavigationBar * newFavMovieNavBar() {
  UINavigationBar *navBar = [UINavigationBar new];
  UINavigationItem *navigationItem = newFavMovieNavigationItem();
  [navBar setItems:@[navigationItem] animated:NO];
  return navBar;
}

UIImageView * newMoviePosterImageView() {
  UIImageView *imageView = [UIImageView new];
  imageView.backgroundColor = [UIColor fm_muskyGrey];
  imageView.contentMode = UIViewContentModeScaleAspectFit;
  return imageView;
}

UILabel * newUsernameLabel() {
  UILabel *label = [UILabel new];
  label.textColor = [UIColor whiteColor];
  label.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
  label.textAlignment = NSTextAlignmentLeft;
  return label;
}

@interface FMMyFavoriteMovieView ()<UINavigationBarDelegate>
@property(nonatomic, strong) UINavigationBar *navBar;
@property(nonatomic, strong) UIImageView *favoriteMoviePosterImageView;
@property(nonatomic, strong) UIBarButtonItem *loginBarButtonItem;
@property(nonatomic, strong) UIBarButtonItem *logoutBarButtonItem;
@property(nonatomic, strong) UILabel *usernameLabel;
@property(nonatomic, strong) UIView *profilePictureView;
@end

@implementation FMMyFavoriteMovieView

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    _favoriteMoviePosterImageView = newMoviePosterImageView();
    _navBar = newFavMovieNavBar();
    _loginBarButtonItem = newLoginBarButtonItem();
    _logoutBarButtonItem = newLogoutBarButtonItem();
    _navBar.delegate = self;
    self.backgroundColor = [UIColor fm_muskyGrey];
  }
  return self;
}

- (void)constructHierarchy {
  // Views.
  [self addSubview:self.favoriteMoviePosterImageView];
  [self addSubview:self.navBar];
  
  // Layout.
  [self.favoriteMoviePosterImageView alignCenterWithView:self];
  
  [self.navBar alignTopEdgeWithView:self
                          predicate:[UIApplication fm_sharedApplicationStatusBarHeightString]];
  [self.navBar alignLeading:@"0" trailing:@"0" toView:self];
}

#pragma mark - Event Handlers

- (void)loginButtonSetTarget:(id)target action:(SEL)action {
  self.loginBarButtonItem.target = target;
  self.loginBarButtonItem.action = action;
}

- (void)logoutButtonSetTarget:(id)target action:(SEL)action {
  self.logoutBarButtonItem.target = target;
  self.logoutBarButtonItem.action = action;
}

- (UIBarButtonItem *)editBarButtonItem {
  return self.navBar.topItem.rightBarButtonItem;
}

- (void)editButtonSetTarget:(id)target action:(SEL)action {
  UIBarButtonItem *editBarButtonItem = [self editBarButtonItem];
  editBarButtonItem.target = target;
  editBarButtonItem.action = action;
}

- (void)showLogoutButton {
  [self.navBar topItem].leftBarButtonItem = self.logoutBarButtonItem;
}

- (void)showLoginButton {
  [self.navBar topItem].leftBarButtonItem = self.loginBarButtonItem;
}

- (void)personalizeWithUser:(FMUser*)user {
  self.usernameLabel = newUsernameLabel();
  self.usernameLabel.text = user.name;
  [self addSubview:self.usernameLabel];
  
  self.profilePictureView = [user newProfilePictureView];
  [self addSubview:self.profilePictureView];
  
  [self.profilePictureView alignLeadingEdgeWithView:self predicate:@"0"];
  [self.profilePictureView constrainTopSpaceToView:self.navBar predicate:@"0"];
  [self.profilePictureView constrainWidth:@"44" height:@"44"];
  
  [self.usernameLabel constrainLeadingSpaceToView:self.profilePictureView predicate:@"14"];
  [self.usernameLabel alignCenterYWithView:self.profilePictureView predicate:@"0"];
  [self.usernameLabel alignTrailingEdgeWithView:self predicate:@"0"];
}

- (void)removePersonalization {
  [self.usernameLabel removeFromSuperview];
  [self.profilePictureView removeFromSuperview];
  
  self.usernameLabel = nil;
  self.profilePictureView = nil;
}

#pragma mark - Navigation Bar Delegate

- (UIBarPosition)positionForBar:(id<UIBarPositioning>)bar {
  if (bar == self.navBar) {
    return UIBarPositionTopAttached;
  }
  return UIBarPositionAny;
}

#pragma mark - Property Accessors

- (void)setFavoriteMovieImageURL:(NSURL *)favoriteMovieImageURL {
  if (favoriteMovieImageURL == nil) {
    self.favoriteMoviePosterImageView.image = nil;
  }
  _favoriteMovieImageURL = [favoriteMovieImageURL copy];
  [self.favoriteMoviePosterImageView setImageWithURL:_favoriteMovieImageURL];
}

@end
