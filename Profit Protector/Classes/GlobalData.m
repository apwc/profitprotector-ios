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

@end