#import "FMMovie.h"

@implementation FMMovie

- (id)copyWithZone:(NSZone *)zone {
  FMMovie *newMovie = [[FMMovie allocWithZone:zone] init];
  newMovie.posterImageURL = self.posterImageURL;
  newMovie.name = self.name;
  return newMovie;
}

@end
