#import "Singleton.h"
#import "CoreDataManager.h"
#import "TypeDefEnumerators.h"

@interface GlobalMethods : Singleton

+ (AccountStatus)accountStatus:(NSDictionary *)dictionary;

+ (NSDictionary *)math:(NSManagedObject *)obj;

+ (NSString *)localizedStringWithKey:(NSString *)key;

+ (BOOL)isTheChineseVersion;

- (NSString *)stringByDecodingXMLEntities:(NSString *)string;

@end