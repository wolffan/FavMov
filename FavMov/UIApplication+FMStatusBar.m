#import "UIApplication+FMStatusBar.h"

@implementation UIApplication (FMStatusBar)

// TODO: What is the right way to lay this out.
+ (NSString *)fm_sharedApplicationStatusBarHeightString {
  return [NSString stringWithFormat:@"%f",
          [UIApplication sharedApplication].statusBarFrame.size.height];
}

@end
