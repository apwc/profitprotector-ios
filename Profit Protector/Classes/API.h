#import "Singleton.h"
#import "Constants.h"
#import "CoreDataManager.h"

@interface API : Singleton

+ (void)activateLicense:(NSString *)code
               username:(NSString *)username
               password:(NSString *)password;

+ (void)loginWithUsername:(NSString *)username
                 password:(NSString *)password;

+ (void)createUser:(NSString *)username
          password:(NSString *)password
         firstname:(NSString *)firstname
          lastname:(NSString *)lastname
             email:(NSString *)email
             phone:(NSString *)phone
           company:(NSString *)company
              role:(NSString *)role;

+ (void)updateUserWithFirstname:(NSString *)firstname
                       lastname:(NSString *)lastname
                          phone:(NSString *)phone
                        company:(NSString *)company
                           role:(NSString *)role;

+ (void)getProperties;

+ (void)uploadPropertyWithTitle:(NSString *)title
                     contentRaw:(NSString *)contentRaw
                         author:(NSString *)author
                       postMeta:(NSDictionary *)postMeta;

+ (void)updateUploadedProperty:(NSString *)postID
                         title:(NSString *)title
                    contentRaw:(NSString *)contentRaw
                        author:(NSString *)author
                      postMeta:(NSDictionary *)postMeta;

+ (void)updateUploadedProperty:(NSString *)postID
                      favorite:(BOOL)favorite;

+ (void)deleteProperty:(NSManagedObject *)property;

+ (void)profilePasswordRecover:(NSString *)email;

@end