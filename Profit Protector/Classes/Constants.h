#pragma mark - Core Data SQLite database name reference

#define persistenceDBName @"Profit_Protector"
#define persistenceDBNameSuffix @"sqlite"

#define apiPrefix @"http://cleanrestapp.com/wp-json/"
#define adminUsername @"cleanrestadmin"
#define adminPassword @"vRjycfxrLcmo"
#define properties @"posts"
#define users @"users"

#pragma mark - Core Data SQLite database reset

#define contentClearProcessStartNotification @"contentClearProcessStartNotification"
#define contentClearProcessCompleteNotification @"contentClearProcessCompleteNotification"

#pragma mark - Reachability

#define networkConnectionChangeNotification @"networkConnectionChangeNotification"
#define networkDownloadCompleteNotification @"networkDownloadCompleteNotification"
#define networkOnlineNotification @"networkOnlineNotification"
#define networkOfflineNotification @"networkOfflineNotification"
#define networkDownloadingNotification @"networkDownloadingNotification"
#define networkDownloadCompletedNotification @"networkDownloadCompletedNotification"

#pragma mark - Background session identifier

#define backgroundSessionSynchIdentifier @"backgroundSessionSynchIdentifier"

#pragma mark - UI Updates

#define displayMainViewControllerNotification @"displayMainViewControllerNotification"
#define updateUserInterfaceNotification @"updateUserInterfaceNotification"
#define userHasBeenRegisteredNotification @"userHasBeenRegisteredNotification"
#define userDidLogoutNotification @"userDidLogoutNotification"

#pragma mark - API

#define apiUserLoginSuccessfulNotification @"apiUserLoginSuccessfulNotification"
#define apiUserLoginErrorNotification @"apiUserLoginErrorNotification"

#define apiUserSignupSuccessfulNotification @"apiUserSignupSuccessfulNotification"
#define apiUserSignupErrorNotification @"apiUserSignupErrorNotification"