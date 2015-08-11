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

@end