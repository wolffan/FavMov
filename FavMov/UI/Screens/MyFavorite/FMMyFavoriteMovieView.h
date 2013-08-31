#import "FMView.h"

@interface FMMyFavoriteMovieView : FMView
@property(nonatomic, strong) NSURL *favoriteMovieImageURL;

- (void)loginButtonSetTarget:(id)target action:(SEL)action;
- (void)editButtonSetTarget:(id)target action:(SEL)action;
@end
