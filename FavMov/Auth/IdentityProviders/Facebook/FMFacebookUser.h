#import <Foundation/Foundation.h>

#import "FMUser.h"

@protocol FBGraphUser;

@interface FMFacebookUser : FMUser
@property(nonatomic, copy, readonly) NSString *name;

- (instancetype)initWithGraphUser:(NSDictionary<FBGraphUser> *)graphUser;
@end
