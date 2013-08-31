#import "FMFriendsViewController.h"

#import "UIColor+FMColors.h"

#import "FMFriendsView.h"

@interface FMFriendsViewController ()<UITableViewDataSource>
@property(nonatomic, strong, readonly) FMFriendsView *friendsView;
@end

@implementation FMFriendsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    // Custom initialization
  }
  return self;
}

- (void)loadView {
  self.view = [FMFriendsView new];
  self.view.backgroundColor = [UIColor redColor];
}

- (void)viewDidLoad {
  [super viewDidLoad];
	self.friendsView.friendsTableView.dataSource = self;
  [self.friendsView.friendsTableView registerClass:[UITableViewCell class]
                            forCellReuseIdentifier:[self friendsCellReuseID]];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (FMFriendsView *)friendsView {
  return (FMFriendsView *)self.view;
}

#pragma mark - Table View Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[self friendsCellReuseID]];
  cell.backgroundColor = [UIColor fm_green];
  return cell;
}

#pragma mark - Literals

- (NSString *)friendsCellReuseID {
  return @"CELL";
}

@end
