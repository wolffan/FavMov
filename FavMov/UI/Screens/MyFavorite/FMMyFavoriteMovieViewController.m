#import "FMMyFavoriteMovieViewController.h"

#import "FMMyFavoriteMovieView.h"
#import "FMMoviePickerViewController.h"
#import "FMMovie.h"

@interface FMMyFavoriteMovieViewController ()
@property(nonatomic, strong, readonly) FMMyFavoriteMovieView *myFavoriteMovieView;
@property(nonatomic, copy) FMMovie *favoriteMovie;
@end

@implementation FMMyFavoriteMovieViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    // Custom initialization
  }
  return self;
}

- (void)loadView {
  self.view = [FMMyFavoriteMovieView new];
  self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewDidLoad {
  [super viewDidLoad];
	[self.myFavoriteMovieView editButtonSetTarget:self action:@selector(editMyFavoriteMovie)];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)login {
  
}

- (void)editMyFavoriteMovie {
  [self presentMoviePicker];
}

- (void)presentMoviePicker {
  FMMoviePickerViewController *moviePicker = [FMMoviePickerViewController new];
  moviePicker.modalPresentationStyle = UIModalPresentationFullScreen;
  moviePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
  moviePicker.modalPresentationCapturesStatusBarAppearance = YES;
  FMBlockWeakSelf weakSelf = self;
  moviePicker.dismissalBlock = ^(FMMovie *movie) {
    weakSelf.favoriteMovie = movie;
    weakSelf.myFavoriteMovieView.favoriteMovieImageURL = movie.posterImageURL;
    [weakSelf dismissViewControllerAnimated:YES completion:nil];
  };
  [self presentViewController:moviePicker animated:YES completion:nil];
}

- (FMMyFavoriteMovieView *)myFavoriteMovieView {
  return (FMMyFavoriteMovieView *)self.view;
}

@end
