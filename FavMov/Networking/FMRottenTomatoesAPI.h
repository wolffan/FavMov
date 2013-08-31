#import <Foundation/Foundation.h>

typedef void(^FMRottenTomatoesMoviesCompletion)(NSArray *movies, NSError *error);

@interface FMRottenTomatoesAPI : NSObject

+ (void)getBoxOfficeListWithCompletion:(FMRottenTomatoesMoviesCompletion)onCompletion;

@end
