#import "FMView.h"

@interface FMMoviePickerView : FMView
@property(nonatomic, strong, readonly) UICollectionView *movieCollectionView;

- (void)doneButtonSetTarget:(id)target action:(SEL)action;
@end
