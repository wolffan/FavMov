#import "FMView.h"

@interface FMView ()
@property(nonatomic, assign, readwrite) BOOL isHierarchyConstructed;
@end

@implementation FMView

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    _isHierarchyConstructed = NO;
  }
  return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
  [self constructHierarchyIfNeeded];
  [super willMoveToSuperview:newSuperview];
}

- (void)constructHierarchyIfNeeded {
  if (!self.isHierarchyConstructed) {
    [self constructHierarchy];
    self.isHierarchyConstructed = YES;
  }
}

- (void)constructHierarchy {
  // Abstract method.
}


@end
