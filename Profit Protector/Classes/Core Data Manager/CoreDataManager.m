#import "CoreDataManager.h"
#import "Constants.h"

@implementation CoreDataManager

#pragma mark - Static accessors

+ (NSManagedObjectModel *)managedObjectModel 
{
  return [[CoreDataManager singleton] managedObjectModel];
}

+ (NSManagedObjectContext *)managedObjectContext 
{
  return [[CoreDataManager singleton] managedObjectContext];
}

+ (NSPersistentStoreCoordinator *)persistentStoreCoordinator 
{
  return [[CoreDataManager singleton] persistentStoreCoordinator];
}

#pragma mark - CoreData stack

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator 
{
  if (_persistentStoreCoordinator != nil)
    return _persistentStoreCoordinator;
  
  NSString *storePath = [[self applicationCachesDirectory] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@",
                                                                                           persistenceDBName,
                                                                                           persistenceDBNameSuffix]];
  
  NSURL *storeUrl = [NSURL fileURLWithPath:storePath];
  
  NSFileManager *fileManager = [NSFileManager defaultManager];
  
  // If the expected store doesn't exist, copy the default store.
  if (![fileManager fileExistsAtPath:storePath])
  {
    NSString *defaultStorePath = [[NSBundle mainBundle] pathForResource:persistenceDBName
                                                                 ofType:persistenceDBNameSuffix];
    if (defaultStorePath)
    {
      [fileManager copyItemAtPath:defaultStorePath
                           toPath:storePath
                            error:nil];
    }
  }
	
  _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
  
  NSDictionary *options = @{NSMigratePersistentStoresAutomaticallyOption: @(YES),
                            NSInferMappingModelAutomaticallyOption: @(YES)};
  
  NSError *err;
  
  if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                 configuration:nil
                                                           URL:storeUrl
                                                       options:options
                                                         error:&err])
  {
    NSLog(@"%@", [err localizedDescription]);
    abort();
  }

  return _persistentStoreCoordinator;
}

- (NSManagedObjectContext *)managedObjectContext
{
  if (_managedObjectContext != nil)
    return _managedObjectContext;
  
  NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
  if (coordinator != nil)
  {
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator: coordinator];
  }
  return _managedObjectContext;
}

- (NSManagedObjectModel *)managedObjectModel 
{
  if (_managedObjectModel != nil)
    return _managedObjectModel;
  
  _managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
  
  return _managedObjectModel;
}

- (NSString *)applicationCachesDirectory
{
  return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
}

#pragma mark - something common

- (void)saveData
{
  @synchronized(self) 
  {
    [[self managedObjectContext] save:nil];
  }
}

- (void)resetData
{
  // send the notification that we have a valid thumbnail to download
  [[NSNotificationCenter defaultCenter] postNotificationName:contentClearProcessStartNotification
                                                      object:self];
  
  __block NSError *err;

  [self.persistentStoreCoordinator.persistentStores enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
    NSPersistentStore *store = (NSPersistentStore *)obj;
    
    [self.persistentStoreCoordinator removePersistentStore:store error:&err];
    NSURL *storeURL = store.URL;
    [[NSFileManager defaultManager] removeItemAtPath:storeURL.path error:&err];
  }];
  
  /*
   * in order to be sure to remove even the possible cache of external data, 
   * we remove the Cache folder and recreate it
   */
  NSFileManager *nsfm = [NSFileManager defaultManager];
  [nsfm removeItemAtPath:[self applicationCachesDirectory] error:nil];
  [nsfm createDirectoryAtPath:[self applicationCachesDirectory]
  withIntermediateDirectories:NO
                   attributes:nil
                        error:nil];
  
  _persistentStoreCoordinator = nil;
  _managedObjectContext = nil;
  
  // recreate the database
  [self managedObjectModel];
  
  // send the notification that we have a valid thumbnail to download
  [[NSNotificationCenter defaultCenter] postNotificationName:contentClearProcessCompleteNotification
                                                      object:self];
}

- (void)deleteObject:(id)objectToDelete
{
  @synchronized(self)
  {
    [[self managedObjectContext] deleteObject:objectToDelete];
  }
}

@end