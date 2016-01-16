#import "Singleton.h"
#import "CoreDataManager.h"

@interface GlobalMethods : Singleton

+ (NSDictionary *)math:(NSManagedObject *)obj;

+ (NSString *)localizedStringWithKey:(NSString *)key;

@end