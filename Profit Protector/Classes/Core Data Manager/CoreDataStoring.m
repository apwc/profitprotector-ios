#import "CoreDataStoring.h"

@implementation CoreDataStoring

+ (void)storeProperty:(NSDictionary *)dictionary
{
  CoreDataManager *cdm = [CoreDataManager singleton];
  
  // create the entity object
  NSManagedObject *property = (NSManagedObject *)[NSEntityDescription insertNewObjectForEntityForName:@"Property"
                                                                               inManagedObjectContext:cdm.managedObjectContext];
  
  [property setValuesForKeysWithDictionary:dictionary];
  
  [cdm.managedObjectContext performBlockAndWait:^{
    [cdm.managedObjectContext save:nil];
  }];
}

@end