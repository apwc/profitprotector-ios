#import "Singleton.h"
@import CoreData;

@interface CoreDataManager : Singleton

@property (nonatomic, strong) NSPersistentStoreCoordinator  *persistentStoreCoordinator;
@property (nonatomic, strong) NSManagedObjectContext        *managedObjectContext;
@property (nonatomic, strong) NSManagedObjectModel          *managedObjectModel;

+ (NSManagedObjectModel *)managedObjectModel;
+ (NSManagedObjectContext *)managedObjectContext;
+ (NSPersistentStoreCoordinator *)persistentStoreCoordinator;

- (NSString *)applicationCachesDirectory;

- (void)resetData;

- (void)saveData;

- (void)deleteObject:(id)objectToDelete;

@end