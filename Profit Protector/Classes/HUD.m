#import "HUD.h"
#import "AppDelegate.h"

@implementation HUD

+ (void)addHUD
{
  // visual HUD with infos
  AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
  
  // failsafe
  [HUD removeHUD];
  
  HUD *hud = [HUD singleton];

  hud.hud = [[MBProgressHUD alloc] initWithWindow:app.window];
  hud.hud.removeFromSuperViewOnHide = YES;
  hud.hud.mode = MBProgressHUDModeIndeterminate;
  hud.hud.labelText = @"";
  hud.hud.detailsLabelText = @"";

  [app.window addSubview:hud.hud];
  
  [hud.hud show:YES];
}

+ (void)removeHUD
{
  HUD *hud = [HUD singleton];
  [hud.hud removeFromSuperview];
  hud.hud = nil;
}

+ (void)removeHUDAfterDelay:(NSTimeInterval)delay
{
  HUD *hud = [HUD singleton];
  [hud.hud hide:YES afterDelay:delay];
}

@end