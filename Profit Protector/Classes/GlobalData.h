#import "Singleton.h"
#import "TypeDefEnumerators.h"

@interface GlobalData : Singleton

@property (nonatomic) float         numberOfBeds;
@property (nonatomic) float         percentage;
@property (nonatomic) float         costPerBed;
@property (nonatomic) PropertyType  propertyType;

+ (NSString *)walkthrough;

+ (void)saveWalkthrough;

+ (NSString *)username;

+ (void)saveUsername:(NSString *)username;

+ (void)deleteUsername;

+ (NSString *)password;

+ (void)savePassword:(NSString *)password;

+ (void)deletePassword;

+ (NSString *)authorID;

+ (void)saveAuthorID:(NSString *)authorID;

+ (void)deleteAuthorID;

@end