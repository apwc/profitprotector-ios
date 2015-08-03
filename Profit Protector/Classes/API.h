#import "Singleton.h"
#import "Constants.h"

@interface API : Singleton

+ (void)loginWithUsername:(NSString *)username
                 password:(NSString *)password;

+ (void)createUser:(NSString *)username
          password:(NSString *)password
              name:(NSString *)name
             email:(NSString *)email
              role:(NSString *)role;

+ (void)getProperties;

@end