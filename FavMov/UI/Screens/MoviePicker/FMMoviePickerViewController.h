#import <UIKit/UIKit.h>

@class FMMovie;

typedef void(^FMMoviePickerCompletionBlock)(FMMovie *movie);

@interface FMMoviePickerViewController : UIViewController
@property(nonatomic, copy) FMMoviePickerCompletionBlock completionBlock;
@end
