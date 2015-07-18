#import "CoreDataRetrieving.h"

@implementation CoreDataRetrieving

+ (NSArray *)properties;
{
  NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Property"];
  request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"name"
                                                            ascending:YES]];
  
  NSArray *result = [[CoreDataManager managedObjectContext] executeFetchRequest:request
                                                                          error:nil];
  
  return result;
}

@end