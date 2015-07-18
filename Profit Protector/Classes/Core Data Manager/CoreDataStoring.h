#import "Singleton.h"
#import "CoreDataRetrieving.h"
#import "Constants.h"

@interface CoreDataStoring : Singleton

+ (void)storeProperty:(NSDictionary *)dictionary;

@end