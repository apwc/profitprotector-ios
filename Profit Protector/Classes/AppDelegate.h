@import UIKit;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, copy) void (^backgroundSynchSessionCompletionHandler)();
@property (nonatomic, copy) void (^backgroundThumbanilsSessionCompletionHandler)();

@end