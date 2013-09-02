#import "FMMyFavoriteMovieViewController.h"

#import "FMMyFavoriteMovieView.h"
#import "FMMoviePickerViewController.h"
#import "FMMovie.h"
#import "FMUserRetriever.h"
#import "FMUser.h"

@interface FMMyFavoriteMovieViewController ()
@property(nonatomic, strong, readonly) FMMyFavoriteMovieView *myFavoriteMovieView;
@property(nonatomic, copy) FMMovie *favoriteMovie;
@property(nonatomic, strong) FMUser *user;
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
}

- (void)viewDidLoad {
  [super viewDidLoad];
	[self.myFavoriteMovieView editButtonSetTarget:self action:@selector(editMyFavoriteMovie)];
  [self.myFavoriteMovieView loginButtonSetTarget:self action:@selector(login)];
  [self.myFavoriteMovieView logoutButtonSetTarget:self action:@selector(logout)];
  
  FMUserRetriever *userRetriever = [FMUserRetriever new];
  [userRetriever retrieveUserAllowLogin:NO completion:[self newUserRetrievalCompletionBlock]];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)login {
  FMUserRetriever *userRetriever = [FMUserRetriever new];
  userRetriever.loginPresentingViewController = self;
  [userRetriever retrieveUserAllowLogin:YES completion:[self newUserRetrievalCompletionBlock]];
}

- (FMUserRetrievalCompletionBlock)newUserRetrievalCompletionBlock {
  FMBlockWeakSelf weakSelf = self;
  FMUserRetrievalCompletionBlock block = ^(FMUser *user, NSError *error) {
    if (user != nil && error == nil) {
      // TODO: Update UI with user.
      weakSelf.user = user;
      [weakSelf.myFavoriteMovieView showLogoutButton];
      [weakSelf.myFavoriteMovieView personalizeWithUser:user];
      [weakSelf loadFavoriteMovieFromUserDefaults];
    } else {
      [weakSelf.myFavoriteMovieView showLoginButton];
      [weakSelf clearOutFavoriteMovie];
    }
  };
  return block;
}

- (void)logout {
  [self.user logout];
  [self.myFavoriteMovieView showLoginButton];
  [self.myFavoriteMovieView removePersonalization];
  [self clearOutFavoriteMovie];
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
  moviePicker.completionBlock = ^(FMMovie *movie) {
    weakSelf.favoriteMovie = movie;
    [weakSelf storeFavoriteMovieInUserDefaults];
    weakSelf.myFavoriteMovieView.favoriteMovieImageURL = movie.posterImageURL;
    [weakSelf dismissViewControllerAnimated:YES completion:nil];
  };
  [self presentViewController:moviePicker animated:YES completion:nil];
}

- (FMMyFavoriteMovieView *)myFavoriteMovieView {
  return (FMMyFavoriteMovieView *)self.view;
}

- (void)loadFavoriteMovieFromUserDefaults {
  NSString *favMovieURL = [[NSUserDefaults standardUserDefaults] objectForKey:@"favMovieURL"];
  NSString *favMovieName = [[NSUserDefaults standardUserDefaults] objectForKey:@"favMovieName"];
  if (favMovieName != nil && favMovieURL != nil) {
    self.favoriteMovie = [FMMovie new];
    self.favoriteMovie.posterImageURL = [NSURL URLWithString:favMovieURL];
    self.favoriteMovie.name = favMovieName;
    self.myFavoriteMovieView.favoriteMovieImageURL = self.favoriteMovie.posterImageURL;
  }
}

- (void)clearOutFavoriteMovie {
  [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"favMovieURL"];
  [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"favMovieName"];
  [[NSUserDefaults standardUserDefaults] synchronize];
  self.myFavoriteMovieView.favoriteMovieImageURL = nil;
}

- (void)storeFavoriteMovieInUserDefaults {
  NSString *favMovieURL = [self.favoriteMovie.posterImageURL absoluteString];
  NSString *favMovieName = [self.favoriteMovie.name copy];
  [[NSUserDefaults standardUserDefaults] setObject:favMovieURL forKey:@"favMovieURL"];
  [[NSUserDefaults standardUserDefaults] setObject:favMovieName forKey:@"favMovieName"];
  [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
