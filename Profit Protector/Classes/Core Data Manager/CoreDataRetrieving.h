#import "Singleton.h"
#import "CoreDataManager.h"

@interface CoreDataRetrieving : Singleton

+ (NSArray *)allProperties;

+ (NSManagedObject *)authorWithID:(NSString *)userID;

+ (NSManagedObject *)propertyWithID:(NSString *)propertyID;

@end