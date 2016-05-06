#import "CoreDataRetrieving.h"
#import "GlobalData.h"

@implementation CoreDataRetrieving

+ (NSArray *)allProperties;
{
  NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Property"];
  
  request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"favorite"
                                                            ascending:NO],
                              [NSSortDescriptor sortDescriptorWithKey:@"name"
                                                            ascending:YES]];

  request.predicate = [NSPredicate predicateWithFormat:@"authorID = %@", [GlobalData authorID]];
  
  NSArray *result = [[CoreDataManager managedObjectContext] executeFetchRequest:request
                                                                          error:nil];
  
  return result;
}

+ (NSManagedObject *)authorWithID:(NSString *)userID
{
  NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Author"];
  
  request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"authorID"
                                                            ascending:YES]];
  
  request.predicate = [NSPredicate predicateWithFormat:@"authorID = %@", userID];
  request.fetchLimit = 1;
  
  NSArray *result = [[CoreDataManager managedObjectContext] executeFetchRequest:request
                                                                          error:nil];
  
  return [result firstObject];
}

+ (NSManagedObject *)propertyWithID:(NSString *)propertyID
{
  NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Property"];
  
  request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"propertyID"
                                                            ascending:YES]];
  
  request.predicate = [NSPredicate predicateWithFormat:@"propertyID = %@", propertyID];
  request.fetchLimit = 1;
  
  NSArray *result = [[CoreDataManager managedObjectContext] executeFetchRequest:request
                                                                          error:nil];
  
  return [result firstObject];
}

@end