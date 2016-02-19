#import "AppDelegate.h"
#import "Constants.h"
#import "GlobalData.h"
#import "SplashViewController.h"
#import "MainViewController.h"
#import "FrontTableViewController.h"
#import "LeftTableViewController.h"
#import "PendingApprovalViewController.h"
#import "LicenseActivationViewController.h"
#import "DeniedAccessViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
  didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
  [self.window makeKeyAndVisible];
 
  // set the default language if the app is in its first run
  if (![GlobalData languageID])
    [GlobalData saveLanguageID:@"en"];
  
  if ([GlobalData username] && [GlobalData password])
    [self displayMainViewController:nil];
  else
  {
    UINavigationController *uinc = [[UINavigationController alloc] initWithRootViewController:[[SplashViewController alloc] init]];
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
  
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(accountPendingStatus:)
                                               name:accountPendingStatusNotification
                                             object:nil];
  
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(accountDeniedStatus:)
                                               name:accountDeniedStatusNotification
                                             object:nil];
  
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(accountIncorrectPasswordStatus:)
                                               name:accountIncorrectPasswordStatusNotification
                                             object:nil];
 
  return YES;
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
  
  return YES;
}

#pragma mark - UIApplication delegate method on URLsession background event

- (void)application:(UIApplication *)application
  handleEventsForBackgroundURLSession:(NSString *)identifier
  completionHandler:(void (^)())completionHandler
{
  self.backgroundSynchSessionCompletionHandler = completionHandler;
}

- (void)removeUserData
{
  [GlobalData deleteAuthorID];
  [GlobalData deleteUsername];
  [GlobalData deletePassword];
}

#pragma mark - UI notifications callbacks

- (void)displayMainViewController:(NSNotification *)notification
{
  MainViewController *mvc = [MainViewController revealControllerWithFrontViewController:[[UINavigationController alloc] initWithRootViewController:[[FrontTableViewController alloc] init]]
                                                                     leftViewController:[[LeftTableViewController alloc] initWithStyle:UITableViewStylePlain]];
  
  self.window.rootViewController = mvc;
}

- (void)userDidLogout:(NSNotification *)notification
{
  [self removeUserData];
  
  UINavigationController *uinc = [[UINavigationController alloc] initWithRootViewController:[[SplashViewController alloc] init]];
  [uinc setNavigationBarHidden:YES animated:NO];
  
  self.window.rootViewController = uinc;
}

- (void)accountPendingStatus:(NSNotification *)notification
{
  [self removeUserData];
  
  LicenseActivationViewController *lavc = [[LicenseActivationViewController alloc] init];
  [self.window.rootViewController presentViewController:lavc animated:YES completion:nil];

  return;
  PendingApprovalViewController *pavc = [[PendingApprovalViewController alloc] init];
  
  [self.window.rootViewController.view addSubview:pavc.view];
  
  [UIView animateWithDuration:0.25f
                        delay:4.0f
                      options:UIViewAnimationOptionCurveEaseOut
                   animations:^{
                     pavc.view.alpha = 0.0f;
                   }
                   completion:^(BOOL finished) {
                     [pavc.view removeFromSuperview];
                     pavc.view = nil;
                   }];
}

- (void)accountDeniedStatus:(NSNotification *)notification
{
  [self userDidLogout:nil];
  
  DeniedAccessViewController *davc = [[DeniedAccessViewController alloc] init];
  
  [self.window.rootViewController.view addSubview:davc.view];
  
  [UIView animateWithDuration:0.25f
                        delay:4.0f
                      options:UIViewAnimationOptionCurveEaseOut
                   animations:^{
                     davc.view.alpha = 0.0f;
                   }
                   completion:^(BOOL finished) {
                     [davc.view removeFromSuperview];
                     davc.view = nil;
                   }];
}

- (void)accountIncorrectPasswordStatus:(NSNotification *)notification
{
  [self removeUserData];
  
  UINavigationController *uinc = [[UINavigationController alloc] initWithRootViewController:[[SplashViewController alloc] init]];
  [uinc setNavigationBarHidden:YES animated:NO];
  
  self.window.rootViewController = uinc;
  
  UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil
                                                                 message:@"Incorrect Password - Your password is misstyped or has changed. Please check and try to log-in again"
                                                          preferredStyle:UIAlertControllerStyleAlert];
  
  UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Ok"
                                               style:UIAlertActionStyleCancel
                                             handler:nil];
  
  [alert addAction:ok];
  
  [self.window.rootViewController presentViewController:alert animated:YES completion:nil];
}

@end