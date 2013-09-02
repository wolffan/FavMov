#import <Foundation/Foundation.h>

#import "FMAuthenticator.h"

@interface FMFacebookAuthenticator : NSObject<FMAuthenticator>
+ (instancetype)sharedInstance;
@end
