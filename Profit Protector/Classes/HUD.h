#import "Singleton.h"
#import "MBProgressHUD.h"

@interface HUD : Singleton

@property (nonatomic, strong) MBProgressHUD *hud;

+ (void)addHUD;
+ (void)removeHUD;
+ (void)removeHUDAfterDelay:(NSTimeInterval)delay;

@end