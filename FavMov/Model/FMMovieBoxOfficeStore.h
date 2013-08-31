#import <Foundation/Foundation.h>

typedef void(^FMMovieBoxOfficeStoreLoadCompletion)(NSError *error);

@interface FMMovieBoxOfficeStore : NSObject
@property(nonatomic, assign, readonly) BOOL isLoaded;
@property(nonatomic, copy, readonly) NSArray *movies;

- (void)loadWithCompletion:(FMMovieBoxOfficeStoreLoadCompletion)onCompletion;
@end
