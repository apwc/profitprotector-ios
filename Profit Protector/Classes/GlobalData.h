#import "Singleton.h"

@interface GlobalData : Singleton

@property (nonatomic) float numberOfBeds;
@property (nonatomic) float percentage;
@property (nonatomic) float costPerBed;

+ (NSString *)walkthrough;

+ (void)saveWalkthrough;

+ (NSString *)username;

+ (void)saveUsername:(NSString *)username;

+ (NSString *)password;

+ (void)savePassword:(NSString *)password;

@end