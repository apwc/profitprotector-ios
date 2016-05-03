#import "Singleton.h"
#import "CoreDataRetrieving.h"
#import "Constants.h"

@interface CoreDataStoring : Singleton

+ (void)storeUser:(NSDictionary *)dictionary;

+ (void)storeProperty:(NSDictionary *)dictionary;

@end