#import <Foundation/Foundation.h>

@interface FMMovie : NSObject<NSCopying>
@property(nonatomic, copy) NSURL *posterImageURL;
@property(nonatomic, copy) NSString *name;
@end
