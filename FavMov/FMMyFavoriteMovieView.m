#import "FMMyFavoriteMovieView.h"

#import "FMView_Protected.h"

#import "UIApplication+FMStatusBar.h"
#import "UIColor+FMColors.h"
#import "UIImage+FMImages.h"
#import "UIImageView+AFNetworking.h"
#import "UIView+FLKAutoLayout.h"

UIBarButtonItem * newLoginBarButtonItem() {
  UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Login"
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
  navigationItem.leftBarButtonItem = newLoginBarButtonItem();
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
  imageView.backgroundColor = [UIColor fm_blue];
  imageView.contentMode = UIViewContentModeScaleAspectFit;
  return imageView;
}

@interface FMMyFavoriteMovieView ()<UINavigationBarDelegate>
@property(nonatomic, strong) UINavigationBar *navBar;
@property(nonatomic, strong) UIImageView *favoriteMoviePosterImageView;
@end

@implementation FMMyFavoriteMovieView

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    _favoriteMoviePosterImageView = newMoviePosterImageView();
    _navBar = newFavMovieNavBar();
    _navBar.delegate = self;
  }
  return self;
}

- (void)constructHierarchy {
  // Views.
  [self addSubview:self.favoriteMoviePosterImageView];
  [self addSubview:self.navBar];
  
  // Layout.
  [self.favoriteMoviePosterImageView constrainTopSpaceToView:self.navBar predicate:@"0"];
  [self.favoriteMoviePosterImageView alignBottomEdgeWithView:self predicate:@"0"];
  [self.favoriteMoviePosterImageView alignLeading:@"0" trailing:@"0" toView:self];
  
  [self.navBar alignTopEdgeWithView:self
                          predicate:[UIApplication fm_sharedApplicationStatusBarHeightString]];
  [self.navBar alignLeading:@"0" trailing:@"0" toView:self];
}

#pragma mark - Event Handlers

- (UIBarButtonItem *)loginBarButtonItem {
  return self.navBar.topItem.leftBarButtonItem;
}

- (void)loginButtonSetTarget:(id)target action:(SEL)action {
  UIBarButtonItem *loginBarButtonItem = [self loginBarButtonItem];
  loginBarButtonItem.target = target;
  loginBarButtonItem.action = action;
}

- (UIBarButtonItem *)editBarButtonItem {
  return self.navBar.topItem.rightBarButtonItem;
}

- (void)editButtonSetTarget:(id)target action:(SEL)action {
  UIBarButtonItem *editBarButtonItem = [self editBarButtonItem];
  editBarButtonItem.target = target;
  editBarButtonItem.action = action;
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
  _favoriteMovieImageURL = [favoriteMovieImageURL copy];
  [self.favoriteMoviePosterImageView setImageWithURL:_favoriteMovieImageURL];
}

@end
