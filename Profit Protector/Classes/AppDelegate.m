#import "AppDelegate.h"
#import "Constants.h"
#import "SplashViewController.h"
#import "MainViewController.h"
#import "FrontTableViewController.h"
#import "LeftTableViewController.h"
#import "API.h"

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
  
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(userDidLogout:)
                                               name:userDidLogoutNotification
                                             object:nil];
  
  //
  /*[API createUser:@"david"
         password:@"david"
             name:@"David"
            email:@"david@david.com"
             role:@"Designer"];*/
  
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
  MainViewController *mvc = [MainViewController revealControllerWithFrontViewController:[[UINavigationController alloc] initWithRootViewController:[[FrontTableViewController alloc] initWithNibName:nil bundle:nil]]
                                                                     leftViewController:[[LeftTableViewController alloc] initWithStyle:UITableViewStylePlain]];
  
  self.window.rootViewController = mvc;
}

- (void)userDidLogout:(NSNotification *)notification
{
  UINavigationController *uinc = [[UINavigationController alloc] initWithRootViewController:[[SplashViewController alloc] initWithNibName:nil
                                                                                                                                   bundle:nil]];
  [uinc setNavigationBarHidden:YES animated:NO];
  
  self.window.rootViewController = uinc;
}

@end