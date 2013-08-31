#import "FMMovieBoxOfficeStore.h"

#import "FMRottenTomatoesAPI.h"

@interface FMMovieBoxOfficeStore()
@property(nonatomic, assign, readwrite) BOOL isLoaded;
@property(nonatomic, copy, readwrite) NSArray *movies;
@end

@implementation FMMovieBoxOfficeStore

- (id)init {
  self = [super init];
  if (self) {
    _isLoaded = NO;
    _movies = @[];
  }
  return self;
}

- (void)loadWithCompletion:(FMMovieBoxOfficeStoreLoadCompletion)onCompletion {
  FMBlockWeakSelf weakSelf = self;
  [FMRottenTomatoesAPI getBoxOfficeListWithCompletion:^(NSArray *movies, NSError *error) {
    if (!error) {
      NSLog(@"Movies, %@", movies);
      weakSelf.movies = movies;
    }
    onCompletion? onCompletion(error) : NULL;
  }];
}



@end
