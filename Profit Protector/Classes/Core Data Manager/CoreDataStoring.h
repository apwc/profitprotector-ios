#import "Singleton.h"
#import "CoreDataRetrieving.h"
#import "Constants.h"

@interface CoreDataStoring : Singleton

+ (void)storeAuthor:(NSDictionary *)dictionary;

+ (void)storeProperty:(NSDictionary *)dictionary;

@end