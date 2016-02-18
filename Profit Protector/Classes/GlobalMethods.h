#import "Singleton.h"
#import "CoreDataManager.h"
#import "TypeDefEnumerators.h"

@interface GlobalMethods : Singleton

+ (AccountStatus)accountStatus:(NSDictionary *)dictionary;

+ (NSDictionary *)math:(NSManagedObject *)obj;

+ (NSString *)localizedStringWithKey:(NSString *)key;

- (NSString *)stringByDecodingXMLEntities:(NSString *)string;

@end