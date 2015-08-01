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

@end