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
  
  NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@?iam=%@",
                                     apiPrefix,
                                     user,
                                     base64]];
  
  // first we aleays clean the cache for every request
  [[NSURLCache sharedURLCache] removeAllCachedResponses];
  
  NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
  [request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
  
  NSURLSession *session = [NSURLSession sharedSession];
  
  NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                              completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                
                                                NSLog(@"Response:%@\nError: %@", response, error);
                                                
                                                id json = [NSJSONSerialization JSONObjectWithData:data
                                                                                          options:NSJSONReadingMutableContainers
                                                                                            error:nil];
                                                
                                                NSLog(@"%@", json);
                                                
                                                if ([json isKindOfClass:[NSDictionary class]])
                                                {
                                                  dispatch_async(dispatch_get_main_queue(), ^{
                                                    [HUD removeHUD];
                                                    
                                                    [[NSNotificationCenter defaultCenter] postNotificationName:apiUserLoginSuccessfulNotification
                                                                                                        object:json];
                                                  });
                                                }
                                                
                                                if ([json isKindOfClass:[NSArray class]])
                                                {
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
                                                }
                                              }];
  [dataTask resume];
}

+ (void)createUser:(NSString *)username
          password:(NSString *)password
              name:(NSString *)name
             email:(NSString *)email
             phone:(NSString *)phone
           company:(NSString *)company
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
  
  NSString *parameters = [NSString stringWithFormat:@"iam=%@&username=%@&name=%@&password=%@&email=%@&role=%@&description=%@|%@",
                          base64,
                          username,
                          name,
                          password,
                          email,
                          role,
                          phone,
                          company];

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
  
  NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@?iam=%@&filter=%@&context=edit&type=property",
                                     apiPrefix,
                                     properties,
                                     base64,
                                     [GlobalData username]]];
  
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
                                                
                                                NSLog(@"%@", json);
                                                
                                                dispatch_async(dispatch_get_main_queue(), ^{
                                                  [HUD removeHUD];
                                                  
                                                  [[NSNotificationCenter defaultCenter] postNotificationName:apiUserPropertiesSuccessfulNotification
                                                                                                      object:json];
                                                });
                                              }];
  [dataTask resume];
}

+ (void)uploadPropertyWithTitle:(NSString *)title
                     contentRaw:(NSString *)contentRaw
                         author:(NSString *)author
                       postMeta:(NSDictionary *)postMeta
{
  [HUD addHUD];
  
  NSString *auth = [NSString stringWithFormat:@"%@fjir50e%@",
                    [GlobalData username],
                    [GlobalData password]];
  
  NSData *authData = [auth dataUsingEncoding:NSUTF8StringEncoding];
  NSString *base64 = [authData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
  
  NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@?iam=%@",
                                     apiPrefix,
                                     properties,
                                     base64]];
  
  NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
  [request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
  [request setHTTPMethod:@"POST"];
  
  NSData *jsonData = [NSJSONSerialization dataWithJSONObject:postMeta
                                                     options:NSJSONWritingPrettyPrinted
                                                       error:nil];
  
  NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
  
  NSString *parameters = [NSString stringWithFormat:@"iam=%@&filter=%@&context=edit&type=property&title=%@&content_raw=%@&author=%@&post_meta=%@",
                          base64,
                          [GlobalData username],
                          title,
                          contentRaw,
                          author,
                          jsonString];
  
  [request setHTTPBody:[parameters dataUsingEncoding:NSUTF8StringEncoding]];
  
  NSURLSession *session = [NSURLSession sharedSession];
  
  NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                              completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                
                                                NSLog(@"Response:%@\nError: %@", response, error);
                                                
                                                NSArray *json = [NSJSONSerialization JSONObjectWithData:data
                                                                                                options:NSJSONReadingMutableContainers
                                                                                                  error:nil];
                                                
                                                NSLog(@"%@", json);
                                                
                                                dispatch_async(dispatch_get_main_queue(), ^{
                                                  [HUD removeHUD];
                                                  
                                                  [[NSNotificationCenter defaultCenter] postNotificationName:apiUserPropertiesSuccessfulNotification
                                                                                                      object:json];
                                                });
                                              }];
  [dataTask resume];
}

@end