#import "GlobalData.h"

@implementation GlobalData

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

+ (NSString *)username
{
  return [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
}

+ (void)saveUsername:(NSString *)username
{
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

+ (NSString *)password
{
  return [[NSUserDefaults standardUserDefaults] objectForKey:@"password"];
}

+ (void)savePassword:(NSString *)password
{
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