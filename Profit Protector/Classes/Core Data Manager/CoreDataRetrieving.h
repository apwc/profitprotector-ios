#import "Singleton.h"
#import "CoreDataManager.h"

@interface CoreDataRetrieving : Singleton

+ (NSArray *)allProperties;

+ (NSManagedObject *)propertyWithID:(NSString *)propertyID;

@end