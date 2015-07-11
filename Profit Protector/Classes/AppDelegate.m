#import "AppDelegate.h"
#import "Constants.h"
#import "SplashViewController.h"
#import "MainViewController.h"

@interface AppDelegate ()
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
  [self.window makeKeyAndVisible];
  
  self.window.backgroundColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
  
  UINavigationController *uinc = [[UINavigationController alloc] initWithRootViewController:[[SplashViewController alloc] initWithNibName:nil
                                                                                                                                   bundle:nil]];
  [uinc setNavigationBarHidden:YES animated:NO];
  
  self.window.rootViewController = uinc;
  
  // register the UI notifications
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(displayMainViewController:)
                                               name:displayMainViewControllerNotification
                                             object:nil];
  
  return YES;
}

#pragma mark - UIApplication delegate method on URLsession background event

- (void)application:(UIApplication *)application
  handleEventsForBackgroundURLSession:(NSString *)identifier
  completionHandler:(void (^)())completionHandler
{
  self.backgroundSynchSessionCompletionHandler = completionHandler;
}

#pragma mark - UI notifications callbacks

- (void)displayMainViewController:(NSNotification *)notification
{
  UINavigationController *uinc = [[UINavigationController alloc] initWithRootViewController:[[MainViewController alloc] initWithNibName:nil
                                                                                                                                 bundle:nil]];
  
  self.window.rootViewController = uinc;
}

@end