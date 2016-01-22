#import "AppDelegate.h"
#import "Constants.h"
#import "GlobalData.h"
#import "SplashViewController.h"
#import "MainViewController.h"
#import "FrontTableViewController.h"
#import "LeftTableViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
  didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
  [self.window makeKeyAndVisible];
 
  //
  if (![GlobalData languageID])
    [GlobalData saveLanguageID:@"en"];
  
  if ([GlobalData username] && [GlobalData password])
    [self displayMainViewController:nil];
  else
  {
    UINavigationController *uinc = [[UINavigationController alloc] initWithRootViewController:[[SplashViewController alloc] initWithNibName:nil
                                                                                                                                     bundle:nil]];
    [uinc setNavigationBarHidden:YES animated:NO];
    
    self.window.rootViewController = uinc;
  }
  
  // register the UI notifications
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(displayMainViewController:)
                                               name:displayMainViewControllerNotification
                                             object:nil];
  
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(userDidLogout:)
                                               name:userDidLogoutNotification
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
  MainViewController *mvc = [MainViewController revealControllerWithFrontViewController:[[UINavigationController alloc] initWithRootViewController:[[FrontTableViewController alloc] initWithNibName:nil bundle:nil]]
                                                                     leftViewController:[[LeftTableViewController alloc] initWithStyle:UITableViewStylePlain]];
  
  self.window.rootViewController = mvc;
}

- (void)userDidLogout:(NSNotification *)notification
{
  [GlobalData deleteAuthorID];
  [GlobalData deleteUsername];
  [GlobalData deletePassword];
  
  UINavigationController *uinc = [[UINavigationController alloc] initWithRootViewController:[[SplashViewController alloc] initWithNibName:nil
                                                                                                                                   bundle:nil]];
  [uinc setNavigationBarHidden:YES animated:NO];
  
  self.window.rootViewController = uinc;
}

@end