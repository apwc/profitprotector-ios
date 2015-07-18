#import "Singleton.h"
#import "CoreDataManager.h"

@interface CoreDataRetrieving : Singleton

+ (NSArray *)properties;

@end