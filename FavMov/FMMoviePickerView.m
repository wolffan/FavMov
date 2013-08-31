#import "FMMoviePickerView.h"

#import "FMView_Protected.h"

#import "UIApplication+FMStatusBar.h"
#import "UIColor+FMColors.h"
#import "UIView+FLKAutoLayout.h"


UIBarButtonItem * newMoviePickerDoneBarButtonItem(){
  return [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                       target:nil
                                                       action:NULL];
}

UINavigationItem * newMoviePickerNavigationItem() {
  UINavigationItem *navigationItem = [[UINavigationItem alloc] initWithTitle:@"Pick Your Fav"];
  navigationItem.rightBarButtonItem = newMoviePickerDoneBarButtonItem();
  return navigationItem;
}

UINavigationBar * newMoviePickerNavBar() {
  UINavigationBar *navBar = [UINavigationBar new];
  UINavigationItem *navigationItem = newMoviePickerNavigationItem();
  [navBar setItems:@[navigationItem] animated:NO];
  return navBar;
}

UICollectionViewFlowLayout * newMovieFlowLayout() {
  UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
  flowLayout.itemSize = CGSizeMake(94.0f, 130.0f);
  return flowLayout;
}

UICollectionView * newMovieCollectionView() {
  UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero
                                                        collectionViewLayout:newMovieFlowLayout()];
  return collectionView;
}

@interface FMMoviePickerView ()<UINavigationBarDelegate>
@property(nonatomic, strong) UINavigationBar *navBar;
@property(nonatomic, strong, readwrite) UICollectionView *movieCollectionView;
@end

@implementation FMMoviePickerView

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    _navBar = newMoviePickerNavBar();
    _navBar.delegate = self;
    _movieCollectionView = newMovieCollectionView();
    self.backgroundColor = [UIColor fm_muskyGrey];
  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
  // TODO: Check if this is the right way to do this.
  CGFloat navBarBottomY = CGRectGetMaxY(self.navBar.frame);
  self.movieCollectionView.contentInset = UIEdgeInsetsMake(navBarBottomY, 0.0f, 0.0f, 0.0f);
  self.movieCollectionView.contentOffset = CGPointMake(0.0f, -navBarBottomY);
}

- (void)constructHierarchy {
  // Movie Collection View.
  [self addSubview:self.movieCollectionView];
  [self.movieCollectionView alignTop:@"0" leading:@"0" bottom:@"0" trailing:@"0" toView:self];
  
  // Nav Bar.
  [self addSubview:self.navBar];
  [self.navBar alignTopEdgeWithView:self
                          predicate:[UIApplication fm_sharedApplicationStatusBarHeightString]];
  [self.navBar alignLeading:@"0" trailing:@"0" toView:self];
}

- (UIBarButtonItem *)doneBarButtonItem {
  return self.navBar.topItem.rightBarButtonItem;
}

- (void)doneButtonSetTarget:(id)target action:(SEL)action {
  UIBarButtonItem *doneBarButtonItem = [self doneBarButtonItem];
  doneBarButtonItem.target = target;
  doneBarButtonItem.action = action;
}

#pragma mark - Navigation Bar Delegate

- (UIBarPosition)positionForBar:(id<UIBarPositioning>)bar {
  if (bar == self.navBar) {
    return UIBarPositionTopAttached;
  }
  return UIBarPositionAny;
}

@end
