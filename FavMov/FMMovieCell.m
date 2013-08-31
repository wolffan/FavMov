#import "FMMovieCell.h"

#import "UIApplication+FMStatusBar.h"
#import "UIImageView+AFNetworking.h"
#import "UIView+FLKAutoLayout.h"

#import "FMMovie.h"

@interface FMMovieCell ()
@property(nonatomic, strong) UIImageView *posterImageView;
@end

@implementation FMMovieCell

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    // Initialization code
  }
  return self;
}

- (void)setMovie:(FMMovie *)movie {
  if ([movie isEqual:_movie]) {
    return;
  }
  _movie = [movie copy];
  if (![self.posterImageView superview]) {
    [self.contentView addSubview:self.posterImageView];
    [self.posterImageView alignTop:@"0" leading:@"0"
                            bottom:@"0" trailing:@"0"
                            toView:self.contentView];
  }
  [self.posterImageView setImageWithURL:_movie.posterImageURL];
}

- (UIImageView *)posterImageView {
  if (_posterImageView == nil) {
    self.posterImageView = [UIImageView new];
  }
  return _posterImageView;
}

@end
