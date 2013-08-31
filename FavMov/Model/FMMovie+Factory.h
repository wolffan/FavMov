#import "FMMovie.h"

@interface FMMovie (Factory)
+ (instancetype)movieFromDictionary:(NSDictionary *)dictionary;
@end
