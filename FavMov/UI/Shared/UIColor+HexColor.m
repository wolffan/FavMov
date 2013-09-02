#import "UIColor+HexColor.h"

@implementation UIColor (HexColor)

+ (UIColor *)fm_colorWithRGB:(unsigned int)rgb {
  return [self fm_colorWithRGB:rgb alpha:1.0f];
}

+ (UIColor *)fm_colorWithRGB:(unsigned int)rgb alpha:(CGFloat)alpha {
  CGFloat r = (rgb / 0x10000) % 0x100;
  CGFloat g = (rgb / 0x100) % 0x100;
  CGFloat b = rgb % 0x100;
  
  return [self colorWithRed:r/0xFF
                      green:g/0xFF
                       blue:b/0xFF
                      alpha:alpha];
}

@end
