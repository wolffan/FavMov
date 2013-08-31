#import "FMRottenTomatoesAPI.h"

#import "FMRottenTomatoesHTTPClient.h"

typedef void(^FMAFNetworkingSuccessBlock)(AFHTTPRequestOperation *operation, id responseObject);
typedef void(^FMAFNetworkingFailureBlock)(AFHTTPRequestOperation *operation, NSError *error);

@implementation FMRottenTomatoesAPI

+ (void)getBoxOfficeListWithCompletion:(FMRottenTomatoesMoviesCompletion)onCompletion; {
  FMRottenTomatoesHTTPClient *httpClient = [FMRottenTomatoesHTTPClient sharedInstance];
  FMAFNetworkingSuccessBlock onSuccess = ^(AFHTTPRequestOperation *operation, id responseObject) {
    NSDictionary *boxOfficeResponse = (NSDictionary *)responseObject;
    onCompletion? onCompletion(boxOfficeResponse[@"movies"], nil) : NULL;
  };
  FMAFNetworkingFailureBlock onFailure = ^(AFHTTPRequestOperation *operation, NSError *error) {
    NSLog(@"Failure getting box office list, %@", error);
    onCompletion? onCompletion(@[], error) : NULL;
  };
  [httpClient getPath:@"lists/movies/box_office.json"
           parameters:@{}
              success:onSuccess
              failure:onFailure];
}

@end
