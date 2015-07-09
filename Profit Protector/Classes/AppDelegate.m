#import "AppDelegate.h"
#import "SplashViewController.h"

@interface AppDelegate ()
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
  didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
  [self.window makeKeyAndVisible];
  
  self.window.backgroundColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
  
  self.window.rootViewController = [[SplashViewController alloc] initWithNibName:nil
                                                                          bundle:nil];
  
  return YES;
}

@end