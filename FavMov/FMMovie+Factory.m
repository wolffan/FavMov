#import "FMMovie+Factory.h"

@implementation FMMovie (Factory)

+ (instancetype)movieFromDictionary:(NSDictionary *)dictionary {
  FMMovie *movie = [FMMovie new];
  movie.posterImageURL = [NSURL URLWithString:dictionary[@"posters"][@" "]];
  movie.name = dictionary[@"title"];
  return movie;
}

@end
