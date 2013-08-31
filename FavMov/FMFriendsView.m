#import "FMFriendsView.h"

#import "FMView_Protected.h"

#import "UIApplication+FMStatusBar.h"
#import "UIView+FLKAutoLayout.h"

UINavigationItem * newFriendsNavigationItem() {
  UINavigationItem *navigationItem = [[UINavigationItem alloc] initWithTitle:@"Friends"];
  return navigationItem;
}

UINavigationBar * newFriendsNavBar() {
  UINavigationBar *navBar = [UINavigationBar new];
  UINavigationItem *navigationItem = newFriendsNavigationItem();
  [navBar setItems:@[navigationItem] animated:NO];
  return navBar;
}

UITableView * newFriendsTableView() {
  UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero
                                                        style:UITableViewStylePlain];
  tableView.rowHeight = 100.0f;
  return tableView;
}

@interface FMFriendsView ()<UINavigationBarDelegate>
@property(nonatomic, strong) UINavigationBar *navBar;
@property(nonatomic, strong, readwrite) UITableView *friendsTableView;
@end

@implementation FMFriendsView

- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    _navBar = newFriendsNavBar();
    _navBar.delegate = self;
    _friendsTableView = newFriendsTableView();
  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
  // TODO: Check if this is the right way to do this.
  CGFloat navBarBottomY = CGRectGetMaxY(self.navBar.frame);
  self.friendsTableView.contentInset = UIEdgeInsetsMake(navBarBottomY, 0.0f, 0.0f, 0.0f);
  self.friendsTableView.contentOffset = CGPointMake(0.0f, -navBarBottomY);
}

- (void)constructHierarchy {
  // Friends table.
  [self addSubview:self.friendsTableView];
  [self.friendsTableView alignTop:@"0" leading:@"0" bottom:@"0" trailing:@"0" toView:self];
  
  // Nav bar.
  [self addSubview:self.navBar];
  [self.navBar alignTopEdgeWithView:self
                          predicate:[UIApplication fm_sharedApplicationStatusBarHeightString]];
  [self.navBar alignLeading:@"0" trailing:@"0" toView:self];
}

#pragma mark - Navigation Bar Delegate

- (UIBarPosition)positionForBar:(id<UIBarPositioning>)bar {
  if (bar == self.navBar) {
    return UIBarPositionTopAttached;
  }
  return UIBarPositionAny;
}


@end
