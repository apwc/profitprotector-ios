#import "CoreDataStoring.h"

@implementation CoreDataStoring

+ (void)storeProperty:(NSDictionary *)dictionary
{
  NSLog(@"%@", dictionary);
  CoreDataManager *cdm = [CoreDataManager singleton];
  
  // create the entity object
  NSManagedObject *user = (NSManagedObject *)[NSEntityDescription insertNewObjectForEntityForName:@"Property"
                                                            inManagedObjectContext:cdm.managedObjectContext];

  [user setValuesForKeysWithDictionary:dictionary];
  
  [cdm.managedObjectContext performBlockAndWait:^{
    [cdm.managedObjectContext save:nil];
  }];
}

@end