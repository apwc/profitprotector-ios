#import "AppDelegate.h"
#import "API.h"
#import "Constants.h"
#import "GlobalData.h"
#import "GlobalMethods.h"
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
  {
    if ([GlobalMethods isTheChineseVersion])
      [GlobalData saveLanguageID:@"cz"];
    else
      [GlobalData saveLanguageID:@"en"];
  }
  
  AccountStatus accountStatus = [GlobalData accountStatus];
  
  if (accountStatus == Approved)
    [self displayMainViewController:nil];
  else
    [self displaySplashViewController];
  
  // register the UI notifications
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(displayMainViewController:)
                                               name:displayMainViewControllerNotification
                                             object:nil];
  
  // usr logout notification
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(userDidLogout:)
                                               name:userDidLogoutNotification
                                             object:nil];
  
  // account and license status notifications
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
  
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(accountLicenseDisabledStatus:)
                                               name:accountLicenseDisabledStatusNotification
                                             object:nil];

  return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
  AccountStatus accountStatus = [GlobalData accountStatus];
  
  if (accountStatus != Approved)
  {
    if ([GlobalData username] && [GlobalData password])
      [API loginWithUsername:[GlobalData username]
                    password:[GlobalData password]];
  }
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
  NSArray *arr = [url.query componentsSeparatedByString:@"="];
  
  if ([url.host isEqualToString:@"password_updated"])
  {
    [self userDidLogout:nil];
  }
  else
    [self manuallyActivateLicense:[arr lastObject]];
  
  return YES;
}

#pragma mark - UIApplication delegate method on URLsession background event

- (void)application:(UIApplication *)application
  handleEventsForBackgroundURLSession:(NSString *)identifier
  completionHandler:(void (^)())completionHandler
{
  self.backgroundSynchSessionCompletionHandler = completionHandler;
}

#pragma mark -

- (void)displaySplashViewController
{
  UINavigationController *uinc = [[UINavigationController alloc] initWithRootViewController:[[SplashViewController alloc] init]];
  [uinc setNavigationBarHidden:YES animated:NO];
  
  self.window.rootViewController = uinc;
}

- (void)manuallyActivateLicense:(NSString *)code
{
  LicenseActivationViewController *lavc = [[LicenseActivationViewController alloc] init];
  lavc.code = code;
  [self.window.rootViewController presentViewController:lavc animated:YES completion:nil];
}

- (void)removeUserData
{
  [GlobalData deleteUsername];
  [GlobalData deletePassword];
  [GlobalData deleteAuthorID];
  [GlobalData deleteLicenseID];
  
  [GlobalData saveAccountStatus:Unknown];
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
  PendingApprovalViewController *pavc = [[PendingApprovalViewController alloc] init];
  
  [self.window.rootViewController presentViewController:pavc animated:YES completion:nil];
}

- (void)accountDeniedStatus:(NSNotification *)notification
{
  [self displaySplashViewController];
  
  DeniedAccessViewController *davc = [[DeniedAccessViewController alloc] init];
  
  [self.window.rootViewController presentViewController:davc animated:YES completion:nil];
}

- (void)accountIncorrectPasswordStatus:(NSNotification *)notification
{
  [self displaySplashViewController];
  
  UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil
                                                                 message:[GlobalMethods localizedStringWithKey:@"Incorrect Password"]
                                                          preferredStyle:UIAlertControllerStyleAlert];
  
  UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Ok"
                                               style:UIAlertActionStyleCancel
                                             handler:nil];
  
  [alert addAction:ok];
  
  [self.window.rootViewController presentViewController:alert animated:YES completion:nil];
}

- (void)accountLicenseDisabledStatus:(NSNotification *)notification
{
  [self displaySplashViewController];
  
  [self manuallyActivateLicense:nil];
}

@end