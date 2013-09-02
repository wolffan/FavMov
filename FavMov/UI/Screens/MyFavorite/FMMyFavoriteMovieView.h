#import "FMView.h"

@class FMUser;

@interface FMMyFavoriteMovieView : FMView
@property(nonatomic, strong) NSURL *favoriteMovieImageURL;

- (void)loginButtonSetTarget:(id)target action:(SEL)action;
- (void)logoutButtonSetTarget:(id)target action:(SEL)action;
- (void)editButtonSetTarget:(id)target action:(SEL)action;

- (void)showLogoutButton;
- (void)showLoginButton;

- (void)personalizeWithUser:(FMUser*)user;
- (void)removePersonalization;
@end
