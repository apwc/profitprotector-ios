#import "API.h"
#import "HUD.h"
#import "GlobalData.h"

@implementation API

+ (void)loginWithUsername:(NSString *)username
                 password:(NSString *)password
{
  NSLog(@"%s", __PRETTY_FUNCTION__);
  [HUD addHUD];

  NSString *auth = [NSString stringWithFormat:@"%@fjir50e%@",
                    username,
                    password];

  NSData *authData = [auth dataUsingEncoding:NSUTF8StringEncoding];
  NSString *base64 = [authData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
  
  NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@?type=property&iam=%@",
                                     apiPrefix,
                                     properties,
                                     base64]];
  
  // first we aleays clean the cache for every request
  [[NSURLCache sharedURLCache] removeAllCachedResponses];
  
  NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
  [request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
  
  NSURLSession *session = [NSURLSession sharedSession];
  
  NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                              completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                
                                                NSLog(@"Response:%@\nError: %@", response, error);
                                                
                                                NSArray *json = [NSJSONSerialization JSONObjectWithData:data
                                                                                                options:NSJSONReadingMutableContainers
                                                                                                  error:nil];
                                                
                                                NSLog(@"%@", [json firstObject]);
                                                
                                                if ([[json firstObject][@"code"] isEqualToString:@"invalid_username"] ||
                                                    [[json firstObject][@"code"] isEqualToString:@"incorrect_password"] ||
                                                    [[json firstObject][@"code"] isEqualToString:@"empty_username"] ||
                                                    [[json firstObject][@"code"] isEqualToString:@"empty_password"])
                                                {
                                                  HUD *hud = [HUD singleton];
                                                  hud.hud.mode = MBProgressHUDModeText;
                                                  
                                                  if ([[json firstObject][@"code"] isEqualToString:@"invalid_username"])
                                                    hud.hud.detailsLabelText = @"Invalid username";
                                                  
                                                  if ([[json firstObject][@"code"] isEqualToString:@"incorrect_password"])
                                                    hud.hud.detailsLabelText = @"Incorrect password";
                                                  
                                                  if ([[json firstObject][@"code"] isEqualToString:@"empty_username"])
                                                    hud.hud.detailsLabelText = @"Empty username";

                                                  if ([[json firstObject][@"code"] isEqualToString:@"empty_password"])
                                                    hud.hud.detailsLabelText = @"Empty password";
                                                  
                                                  dispatch_async(dispatch_get_main_queue(), ^{
                                                    [HUD removeHUDAfterDelay:1.5f];
                                                  });
                                                  
                                                  return;
                                                }
                                                
                                                dispatch_async(dispatch_get_main_queue(), ^{
                                                  [HUD removeHUD];
                                                  
                                                  [[NSNotificationCenter defaultCenter] postNotificationName:apiUserLoginSuccessfulNotification
                                                                                                      object:json];
                                                });
                                              }];
  [dataTask resume];
}

+ (void)createUser:(NSString *)username
          password:(NSString *)password
              name:(NSString *)name
             email:(NSString *)email
              role:(NSString *)role
{
  NSLog(@"%s", __PRETTY_FUNCTION__);
  [HUD addHUD];
  
  NSString *auth = [NSString stringWithFormat:@"%@fjir50e%@",
                    adminUsername,
                    adminPassword];
  
  NSData *authData = [auth dataUsingEncoding:NSUTF8StringEncoding];
  NSString *base64 = [authData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
  
  NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",
                                     apiPrefix,
                                     users]];
  
  NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
  [request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
  [request setHTTPMethod:@"POST"];
  
  NSString *parameters = [NSString stringWithFormat:@"iam=%@&username=%@&name=%@&password=%@&email=%@&role=%@",
                          base64,
                          username,
                          name,
                          password,
                          email,
                          role];

  [request setHTTPBody:[parameters dataUsingEncoding:NSUTF8StringEncoding]];
  
  NSURLSession *session = [NSURLSession sharedSession];
  
  NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                              completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                
                                                NSLog(@"Response:%@\nError: %@", response, error);
                                                
                                                id json = [NSJSONSerialization JSONObjectWithData:data
                                                                                                options:NSJSONReadingMutableContainers
                                                                                                  error:nil];
                                                
                                                if ([json isKindOfClass:[NSArray class]])
                                                  json = [json firstObject];
                                                
                                                if ([json[@"code"] isEqualToString:@"json_missing_callback_param"])
                                                {
                                                  HUD *hud = [HUD singleton];
                                                  hud.hud.mode = MBProgressHUDModeText;
                                                  hud.hud.detailsLabelText = json[@"message"];
                                                  
                                                  dispatch_async(dispatch_get_main_queue(), ^{
                                                    [HUD removeHUDAfterDelay:1.5f];
                                                  });
                                                  
                                                  return;
                                                }
                                                
                                                dispatch_async(dispatch_get_main_queue(), ^{
                                                  [HUD removeHUD];
                                                  
                                                  [[NSNotificationCenter defaultCenter] postNotificationName:apiUserSignupSuccessfulNotification
                                                                                                      object:json];
                                                });
                                              }];
  [dataTask resume];
}

+ (void)getProperties
{
  NSLog(@"%s", __PRETTY_FUNCTION__);
  [HUD addHUD];
  
  NSString *auth = [NSString stringWithFormat:@"%@fjir50e%@",
                    [GlobalData username],
                    [GlobalData password]];
  
  NSData *authData = [auth dataUsingEncoding:NSUTF8StringEncoding];
  NSString *base64 = [authData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
  
  NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@?type=property&iam=%@",
                                     apiPrefix,
                                     properties,
                                     base64]];
  
  // first we aleays clean the cache for every request
  [[NSURLCache sharedURLCache] removeAllCachedResponses];
  
  NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
  [request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
  
  NSURLSession *session = [NSURLSession sharedSession];
  
  NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                              completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                
                                                NSLog(@"Response:%@\nError: %@", response, error);
                                                
                                                NSArray *json = [NSJSONSerialization JSONObjectWithData:data
                                                                                                options:NSJSONReadingMutableContainers
                                                                                                  error:nil];
                                                
                                                NSLog(@"%@", [json firstObject][@"code"]);
                                                if ([[json firstObject][@"code"] isEqualToString:@"invalid_username"] ||
                                                    [[json firstObject][@"code"] isEqualToString:@"incorrect_password"] )
                                                {
                                                  HUD *hud = [HUD singleton];
                                                  hud.hud.mode = MBProgressHUDModeText;
                                                  
                                                  if ([[json firstObject][@"code"] isEqualToString:@"invalid_username"])
                                                    hud.hud.detailsLabelText = @"Invalid username";
                                                  
                                                  if ([[json firstObject][@"code"] isEqualToString:@"incorrect_password"])
                                                    hud.hud.detailsLabelText = @"Incorrect password";
                                                  
                                                  dispatch_async(dispatch_get_main_queue(), ^{
                                                    [HUD removeHUDAfterDelay:1.5f];
                                                  });
                                                  
                                                  return;
                                                }
                                                
                                                dispatch_async(dispatch_get_main_queue(), ^{
                                                  [HUD removeHUD];
                                                  
                                                  [[NSNotificationCenter defaultCenter] postNotificationName:apiUserLoginSuccessfulNotification
                                                                                                      object:json];
                                                });
                                              }];
  [dataTask resume];
}

@end