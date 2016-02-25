#import "GlobalData.h"

@implementation GlobalData

#pragma mark - walkthrough

+ (NSString *)walkthrough
{
  return [[NSUserDefaults standardUserDefaults] objectForKey:@"walkthrough"];
}

+ (void)saveWalkthrough
{
  NSUserDefaults *nsud = [NSUserDefaults standardUserDefaults];
  [nsud setObject:@"walkthrough" forKey:@"walkthrough"];
  [nsud synchronize];
}

#pragma mark - username

+ (NSString *)username
{
  return [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
}

+ (void)saveUsername:(NSString *)username
{
  NSLog(@"saveUsername %@", username);
  NSUserDefaults *nsud = [NSUserDefaults standardUserDefaults];
  [nsud setObject:username forKey:@"username"];
  [nsud synchronize];
}

+ (void)deleteUsername
{
  NSUserDefaults *nsud = [NSUserDefaults standardUserDefaults];
  [nsud removeObjectForKey:@"username"];
  [nsud synchronize];
}

#pragma mark - password

+ (NSString *)password
{
  return [[NSUserDefaults standardUserDefaults] objectForKey:@"password"];
}

+ (void)savePassword:(NSString *)password
{
  NSLog(@"savePassword %@", password);
  NSUserDefaults *nsud = [NSUserDefaults standardUserDefaults];
  [nsud setObject:password forKey:@"password"];
  [nsud synchronize];
}

+ (void)deletePassword
{
  NSUserDefaults *nsud = [NSUserDefaults standardUserDefaults];
  [nsud removeObjectForKey:@"password"];
  [nsud synchronize];
}

#pragma mark - author ID

+ (NSString *)authorID
{
  return [[NSUserDefaults standardUserDefaults] objectForKey:@"authorID"];
}

+ (void)saveAuthorID:(NSString *)authorID
{
  NSUserDefaults *nsud = [NSUserDefaults standardUserDefaults];
  [nsud setObject:authorID forKey:@"authorID"];
  [nsud synchronize];
}

+ (void)deleteAuthorID
{
  NSUserDefaults *nsud = [NSUserDefaults standardUserDefaults];
  [nsud removeObjectForKey:@"authorID"];
  [nsud synchronize];
}

#pragma mark - license ID

+ (NSString *)licenseID
{
  return [[NSUserDefaults standardUserDefaults] objectForKey:@"licenseID"];
}

+ (void)saveLicenseID:(NSString *)licenseID
{
  NSUserDefaults *nsud = [NSUserDefaults standardUserDefaults];
  [nsud setObject:licenseID forKey:@"licenseID"];
  [nsud synchronize];
}

+ (void)deleteLicenseID
{
  NSUserDefaults *nsud = [NSUserDefaults standardUserDefaults];
  [nsud removeObjectForKey:@"licenseID"];
  [nsud synchronize];
}

#pragma mark - account status

+ (AccountStatus)accountStatus
{
  return [[NSUserDefaults standardUserDefaults] integerForKey:@"accountStatus"];
}

+ (void)saveAccountStatus:(AccountStatus)accountStatus
{
  NSUserDefaults *nsud = [NSUserDefaults standardUserDefaults];
  [nsud setInteger:accountStatus forKey:@"accountStatus"];
  [nsud synchronize];
}

+ (void)deleteAccountStatus
{
  NSUserDefaults *nsud = [NSUserDefaults standardUserDefaults];
  [nsud removeObjectForKey:@"accountStatus"];
  [nsud synchronize];
}

#pragma mark - language ID

+ (NSString *)languageID
{
  return [[NSUserDefaults standardUserDefaults] objectForKey:@"languageID"];
}

+ (void)saveLanguageID:(NSString *)languageID
{
  NSUserDefaults *nsud = [NSUserDefaults standardUserDefaults];
  [nsud setObject:languageID forKey:@"languageID"];
  [nsud synchronize];
}

#pragma mark - currency ID

+ (NSString *)currencyID
{
  return [[NSUserDefaults standardUserDefaults] objectForKey:@"currencyID"];
}

+ (void)saveCurrencyID:(NSString *)currencyID
{
  NSUserDefaults *nsud = [NSUserDefaults standardUserDefaults];
  [nsud setObject:currencyID forKey:@"currencyID"];
  [nsud synchronize];
}

@end