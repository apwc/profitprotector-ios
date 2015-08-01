#import "Singleton.h"

@interface API : Singleton

+ (void)createUser:(NSString *)username
          password:(NSString *)password
              name:(NSString *)name
             email:(NSString *)email
              role:(NSString *)role;

+ (void)getProperties;

@end