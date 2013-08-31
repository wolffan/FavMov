#import "FMRottenTomatoesHTTPClient.h"

#import "AFJSONRequestOperation.h"

static NSString * kFMRottenTomatoesBaseURL = @"http://api.rottentomatoes.com/api/public/v1.0";

@implementation FMRottenTomatoesHTTPClient

+ (instancetype)sharedInstance {
  static FMRottenTomatoesHTTPClient *sharedInstance = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    sharedInstance = [[self alloc] initWithBaseURL:[NSURL URLWithString:kFMRottenTomatoesBaseURL]];
  });
  return sharedInstance;
}

- (id)initWithBaseURL:(NSURL *)url {
  self = [super initWithBaseURL:url];
  if (!self) return nil;
  
  [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
  return self;
}

- (NSMutableURLRequest *)requestWithMethod:(NSString *)method
                                      path:(NSString *)path
                                parameters:(NSDictionary *)parameters {
  NSMutableDictionary *paramtersWithAPIKey = [parameters mutableCopy];
  // TODO: Place API Key somewhere else.
  paramtersWithAPIKey[@"apikey"] = @"bv4377qv8f29wz74vrngz73b";
  return [super requestWithMethod:method path:path parameters:[paramtersWithAPIKey copy]];
}

@end
