#import <UIKit/UIKit.h>

@interface UIColor (HexColor)

+ (UIColor *)fm_colorWithRGB:(unsigned int)rgb;
+ (UIColor *)fm_colorWithRGB:(unsigned int)rgb alpha:(CGFloat)alpha;

@end
