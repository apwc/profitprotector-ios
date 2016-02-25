#import "Singleton.h"
#import "TypeDefEnumerators.h"

@interface GlobalData : Singleton

@property (nonatomic) float         numberOfBeds;
@property (nonatomic) float         percentage;
@property (nonatomic) float         costPerBed;
@property (nonatomic) PropertyType  propertyType;

#pragma mark - walkthrough

+ (NSString *)walkthrough;

+ (void)saveWalkthrough;

#pragma mark - username

+ (NSString *)username;

+ (void)saveUsername:(NSString *)username;

+ (void)deleteUsername;

#pragma mark - password

+ (NSString *)password;

+ (void)savePassword:(NSString *)password;

+ (void)deletePassword;

#pragma mark - author ID

+ (NSString *)authorID;

+ (void)saveAuthorID:(NSString *)authorID;

+ (void)deleteAuthorID;

#pragma mark - license ID

+ (NSString *)licenseID;

+ (void)saveLicenseID:(NSString *)licenseID;

+ (void)deleteLicenseID;

#pragma mark - account status

+ (AccountStatus)accountStatus;

+ (void)saveAccountStatus:(AccountStatus)accountStatus;

+ (void)deleteAccountStatus;

#pragma mark - language ID

+ (NSString *)languageID;

+ (void)saveLanguageID:(NSString *)languageID;

#pragma mark - currency ID

+ (NSString *)currencyID;

+ (void)saveCurrencyID:(NSString *)currencyID;

@end