#import <UIKit/UIKit.h>

@class FMMovie;

typedef void(^FMMoviePickerDismissalBlock)(FMMovie *movie);

@interface FMMoviePickerViewController : UIViewController
@property(nonatomic, strong) FMMoviePickerDismissalBlock dismissalBlock;
@end
