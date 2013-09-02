#import "FMMoviePickerViewController.h"

#import "UIColor+FMColors.h"

#import "FMMoviePickerView.h"
#import "FMMovieBoxOfficeStore.h"
#import "FMMovieCell.h"
#import "FMMovie+Factory.h"

@interface FMMoviePickerViewController ()<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property(nonatomic, strong, readonly) FMMoviePickerView *moviePickerView;
@property(nonatomic, strong) FMMovieBoxOfficeStore *movieStore;
@property(nonatomic, copy) FMMovie *selectedMovie;
@end

@implementation FMMoviePickerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
  }
  return self;
}

- (void)loadView {
  self.view = [FMMoviePickerView new];
}

- (void)viewDidLoad {
  [super viewDidLoad];
	[self.moviePickerView doneButtonSetTarget:self action:@selector(dismissMyself)];
  self.moviePickerView.movieCollectionView.dataSource = self;
  self.moviePickerView.movieCollectionView.delegate = self;
  [self.moviePickerView.movieCollectionView registerClass:[FMMovieCell class]
                               forCellWithReuseIdentifier:[self movieCellReuseID]];
  self.movieStore = [FMMovieBoxOfficeStore new];
  FMBlockWeakSelf weakSelf = self;
  [self.movieStore loadWithCompletion:^(NSError *error) {
    if (!error) {
      [weakSelf.moviePickerView.movieCollectionView reloadData];
    }
  }];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)dismissMyself {
  self.completionBlock ? self.completionBlock(self.selectedMovie) : NULL;
}

#pragma mark - Movie Collection View Datasource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
  return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
  return [self.movieStore.movies count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  FMMovieCell *cell =
      (FMMovieCell *)[collectionView dequeueReusableCellWithReuseIdentifier:[self movieCellReuseID]
                                                               forIndexPath:indexPath];
  cell.backgroundColor = [UIColor fm_muskyGrey];
  // TODO: Clean this up, no need to always creat movie instances from dictionary.
  cell.movie = [FMMovie movieFromDictionary:[self.movieStore.movies objectAtIndex:indexPath.item]];
  UIView *selectedBackgroundView = [UIView new];
  selectedBackgroundView.backgroundColor = [UIColor fm_blue];
  cell.selectedBackgroundView = selectedBackgroundView;
  return cell;
}

#pragma mark - Movie Collection View Delegate

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                        layout:(UICollectionViewLayout*)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section {
  return UIEdgeInsetsMake(10.0f, 8.0f, 0.0f, 8.0f);
}

- (BOOL)collectionView:(UICollectionView *)collectionView
    shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  return YES;
}

- (void)collectionView:(UICollectionView *)collectionView
    didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  self.selectedMovie =
      [FMMovie movieFromDictionary:[self.movieStore.movies objectAtIndex:indexPath.item]];
}

#pragma mark - Property Accessors

- (FMMoviePickerView *)moviePickerView {
  return (FMMoviePickerView *)self.view;
}

#pragma mark - Literals

- (NSString *)movieCellReuseID {
  return @"CELL";
}

@end
