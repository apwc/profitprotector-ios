#import "CoreDataStoring.h"
#import "CoreDataRetrieving.h"

@implementation CoreDataStoring

+ (void)storeAuthor:(NSDictionary *)dictionary
{
  CoreDataManager *cdm = [CoreDataManager singleton];
  
  // create the entity object
  NSManagedObject *author = [CoreDataRetrieving authorWithID:dictionary[@"authorID"]];
  
  if (!author)
    author = (NSManagedObject *)[NSEntityDescription insertNewObjectForEntityForName:@"Author"
                                                              inManagedObjectContext:cdm.managedObjectContext];
  
  [author setValuesForKeysWithDictionary:dictionary];
  
  [cdm.managedObjectContext performBlockAndWait:^{
    [cdm.managedObjectContext save:nil];
  }];
}

+ (void)storeProperty:(NSDictionary *)dictionary
{
  CoreDataManager *cdm = [CoreDataManager singleton];

  // create the entity object
  NSManagedObject *property = [CoreDataRetrieving propertyWithID:dictionary[@"ID"]];
  
  if (!property)
    property = (NSManagedObject *)[NSEntityDescription insertNewObjectForEntityForName:@"Property"
                                                                inManagedObjectContext:cdm.managedObjectContext];
  
  
  [property setValue:dictionary[@"ID"] forKey:@"propertyID"];
  
  [property setValue:dictionary[@"title"] forKey:@"name"];
  
  [property setValue:dictionary[@"author"][@"ID"] forKey:@"authorID"];
  
  NSArray *postMeta = dictionary[@"post_meta"];
  
  [postMeta enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
    NSDictionary *meta = (NSDictionary *)obj;
    
    if ([meta[@"key"] isEqualToString:@"ancillariesRevenuePerRoomPerNight"])
    {
      [property setValue:@([meta[@"value"] doubleValue])
                  forKey:meta[@"key"]];
    }
    
    if ([meta[@"key"] isEqualToString:@"bedBugIncidents"])
    {
      [property setValue:@([meta[@"value"] integerValue])
                  forKey:meta[@"key"]];
    }
    
    if ([meta[@"key"] isEqualToString:@"bedsNumber"])
    {
      [property setValue:@([meta[@"value"] integerValue])
                  forKey:meta[@"key"]];
    }
    
    if ([meta[@"key"] isEqualToString:@"occupancyRate"])
    {
      [property setValue:@([meta[@"value"] doubleValue])
                  forKey:meta[@"key"]];
    }
    
    if ([meta[@"key"] isEqualToString:@"bugInspectionAndPestControlFees"])
    {
      [property setValue:@([meta[@"value"] doubleValue])
                  forKey:meta[@"key"]];
    }
    
    if ([meta[@"key"] isEqualToString:@"costOfReplaceFurnishings"])
    {
      [property setValue:@([meta[@"value"] doubleValue])
                  forKey:meta[@"key"]];
    }
    
    if ([meta[@"key"] isEqualToString:@"costOfReplaceMattressesAndBoxSpring"])
    {
      [property setValue:@([meta[@"value"] doubleValue])
                  forKey:meta[@"key"]];
    }
    
    if ([meta[@"key"] isEqualToString:@"costToCleanAndReinstallEncasements"])
    {
      [property setValue:@([meta[@"value"] doubleValue])
                  forKey:meta[@"key"]];
    }
    
    if ([meta[@"key"] isEqualToString:@"favorite"])
    {
      [property setValue:@([meta[@"value"] boolValue])
                  forKey:meta[@"key"]];
    }
    
    if ([meta[@"key"] isEqualToString:@"foodBeverageSalesPerRoomPerNight"])
    {
      [property setValue:@([meta[@"value"] doubleValue])
                  forKey:meta[@"key"]];
    }
    
    if ([meta[@"key"] isEqualToString:@"futureBookingDaysLost"])
    {
      [property setValue:@([meta[@"value"] integerValue])
                  forKey:meta[@"key"]];
    }
    
    if ([meta[@"key"] isEqualToString:@"grievanceCosts"])
    {
      [property setValue:@([meta[@"value"] doubleValue])
                  forKey:meta[@"key"]];
    }
    
    if ([meta[@"key"] isEqualToString:@"preemptivePestControlRetainer"])
    {
      [property setValue:@([meta[@"value"] doubleValue])
                  forKey:meta[@"key"]];
    }
    
    if ([meta[@"key"] isEqualToString:@"percentageOfMattressesReplaceEachYear"])
    {
      [property setValue:@([meta[@"value"] doubleValue])
                  forKey:meta[@"key"]];
    }
    
    if ([meta[@"key"] isEqualToString:@"propertyType"])
    {
      [property setValue:meta[@"value"]
                  forKey:meta[@"key"]];
    }
    
    if ([meta[@"key"] isEqualToString:@"roomRevenuePerNight"])
    {
      [property setValue:@([meta[@"value"] doubleValue])
                  forKey:meta[@"key"]];
    }
    
    if ([meta[@"key"] isEqualToString:@"roomsNumber"])
    {
      [property setValue:@([meta[@"value"] integerValue])
                  forKey:meta[@"key"]];
    }
    
    if ([meta[@"key"] isEqualToString:@"timesPerYearBedClean"])
    {
      [property setValue:@([meta[@"value"] integerValue])
                  forKey:meta[@"key"]];
    }
  }];
  
  [cdm.managedObjectContext performBlockAndWait:^{
    [cdm.managedObjectContext save:nil];
  }];
}

@end