#import "API.h"
#import "HUD.h"
#import "GlobalData.h"
#import "GlobalMethods.h"

@implementation API

+ (BOOL)isAccountActive:(NSDictionary *)dictionary
{
  if ([GlobalMethods accountStatus:dictionary] == Pending)
  {
    dispatch_async(dispatch_get_main_queue(), ^{
      [HUD removeHUD];
      
      [[NSNotificationCenter defaultCenter] postNotificationName:accountPendingStatusNotification
                                                          object:nil];
    });
    
    return NO;
  }
  
  if ([GlobalMethods accountStatus:dictionary] == Denied)
  {
    dispatch_async(dispatch_get_main_queue(), ^{
      [HUD removeHUD];
      
      [[NSNotificationCenter defaultCenter] postNotificationName:accountDeniedStatusNotification
                                                          object:nil];
    });
    
    return NO;
  }
  
  if ([GlobalMethods accountStatus:dictionary] == IncorrectPassword)
  {
    dispatch_async(dispatch_get_main_queue(), ^{
      [HUD removeHUD];
      
      [[NSNotificationCenter defaultCenter] postNotificationName:accountIncorrectPasswordStatusNotification
                                                          object:nil];
    });
    
    return NO;
  }
  
  return YES;
}

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
  NSLog(@"%@", [url absoluteString]);
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
                                                if (error)
                                                {
                                                  HUD *hud = [HUD singleton];
                                                  hud.hud.mode = MBProgressHUDModeText;
                                                  hud.hud.detailsLabelText = @"Network error, please try again.";
                                                  
                                                  dispatch_async(dispatch_get_main_queue(), ^{
                                                    [HUD removeHUDAfterDelay:1.5f];
                                                    
                                                    [[NSNotificationCenter defaultCenter] postNotificationName:apiUserLoginErrorNotification
                                                                                                        object:json];
                                                  });
                                                  
                                                  return;
                                                }
                                                
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
                                                  if (![API isAccountActive:[json firstObject]])
                                                    return;

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
  NSLog(@"%@", [url absoluteString]);
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
                                                
                                                if (error)
                                                {
                                                  HUD *hud = [HUD singleton];
                                                  hud.hud.mode = MBProgressHUDModeText;
                                                  hud.hud.detailsLabelText = @"Network error, please try again.";
                                                  
                                                  dispatch_async(dispatch_get_main_queue(), ^{
                                                    [HUD removeHUDAfterDelay:1.5f];
                                                    
                                                    [[NSNotificationCenter defaultCenter] postNotificationName:apiUserSignupErrorNotification
                                                                                                        object:nil];
                                                  });
                                                  
                                                  return;
                                                }

                                                id json = [NSJSONSerialization JSONObjectWithData:data
                                                                                                options:NSJSONReadingMutableContainers
                                                                                                  error:nil];
                                                NSLog(@"%@", json);
                                                if ([json isKindOfClass:[NSArray class]])
                                                {
                                                  json = [json firstObject];
                                                  
                                                  if (![API isAccountActive:json])
                                                    return;
                                                }
                                                
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
  
  NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@?iam=%@&filter=%@&context=edit&type=property&filter[posts_per_page]=1000&author=%@",
                                     apiPrefix,
                                     properties,
                                     base64,
                                     [GlobalData username],
                                     [GlobalData authorID]]];

  NSLog(@"%@", [url absoluteString]);
  // first we aleays clean the cache for every request
  [[NSURLCache sharedURLCache] removeAllCachedResponses];
  
  NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
  [request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
  
  NSURLSession *session = [NSURLSession sharedSession];
  
  NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                              completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                
                                                NSLog(@"Response:%@\nError: %@", response, error);
                                                
                                                if (error)
                                                {
                                                  HUD *hud = [HUD singleton];
                                                  hud.hud.mode = MBProgressHUDModeText;
                                                  hud.hud.detailsLabelText = @"Network error, please try again.";
                                                  
                                                  dispatch_async(dispatch_get_main_queue(), ^{
                                                    [HUD removeHUDAfterDelay:1.5f];
                                                    
                                                    [[NSNotificationCenter defaultCenter] postNotificationName:apiUserPropertiesErrorNotification
                                                                                                        object:nil];
                                                  });
                                                  
                                                  return;
                                                }
                                                
                                                NSArray *json = [NSJSONSerialization JSONObjectWithData:data
                                                                                                options:NSJSONReadingMutableContainers
                                                                                                  error:nil];
                                                NSLog(@"%@", json);
                                                
                                                if (![API isAccountActive:[json firstObject]])
                                                  return;
                                                
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
  
  NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",
                                     apiPrefix,
                                     properties]];
  NSLog(@"%@", [url absoluteString]);
  NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
  [request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
  [request setHTTPMethod:@"POST"];
  
  NSMutableString *parameters = [NSMutableString stringWithCapacity:0];
  
  [parameters appendFormat:@"iam=%@", base64];
  
  [parameters appendFormat:@"&filter=%@", [GlobalData username]];
  
  [parameters appendFormat:@"&author=%@", [GlobalData authorID]];
  
  [parameters appendFormat:@"&filter[posts_per_page]=1000"];
  
  [parameters appendString:@"&context=edit"];
  
  [parameters appendString:@"&type=property"];
  
  [parameters appendString:@"&status=publish"];
  
  [parameters appendFormat:@"&title=%@", title];
  
  [parameters appendFormat:@"&content_raw=%@", contentRaw];
  
  [parameters appendFormat:@"&post_meta[0][key]=%@", @"propertyType"];
  [parameters appendFormat:@"&post_meta[0][value]=%@", postMeta[@"propertyType"]];

  [parameters appendFormat:@"&post_meta[1][key]=%@", @"roomsNumber"];
  [parameters appendFormat:@"&post_meta[1][value]=%@", postMeta[@"roomsNumber"]];

  [parameters appendFormat:@"&post_meta[2][key]=%@", @"bedsNumber"];
  [parameters appendFormat:@"&post_meta[2][value]=%@", postMeta[@"bedsNumber"]];
  
  [parameters appendFormat:@"&post_meta[3][key]=%@", @"roomRevenuePerNight"];
  [parameters appendFormat:@"&post_meta[3][value]=%@", postMeta[@"roomRevenuePerNight"]];
  
  [parameters appendFormat:@"&post_meta[4][key]=%@", @"foodBeverageSalesPerRoomPerNight"];
  [parameters appendFormat:@"&post_meta[4][value]=%@", postMeta[@"foodBeverageSalesPerRoomPerNight"]];
  
  [parameters appendFormat:@"&post_meta[5][key]=%@", @"ancillariesRevenuePerRoomPerNight"];
  [parameters appendFormat:@"&post_meta[5][value]=%@", postMeta[@"ancillariesRevenuePerRoomPerNight"]];

  [parameters appendFormat:@"&post_meta[6][key]=%@", @"costOfReplaceMattressesAndBoxSpring"];
  [parameters appendFormat:@"&post_meta[6][value]=%@", postMeta[@"costOfReplaceMattressesAndBoxSpring"]];

  [parameters appendFormat:@"&post_meta[7][key]=%@", @"costOfReplaceFurnishings"];
  [parameters appendFormat:@"&post_meta[7][value]=%@", postMeta[@"costOfReplaceFurnishings"]];

  [parameters appendFormat:@"&post_meta[8][key]=%@", @"percentageOfMattressesReplaceEachYear"];
  [parameters appendFormat:@"&post_meta[8][value]=%@", postMeta[@"percentageOfMattressesReplaceEachYear"]];

  [parameters appendFormat:@"&post_meta[9][key]=%@", @"timesPerYearBedClean"];
  [parameters appendFormat:@"&post_meta[9][value]=%@", postMeta[@"timesPerYearBedClean"]];
  
  [parameters appendFormat:@"&post_meta[10][key]=%@", @"costToCleanAndReinstallEncasements"];
  [parameters appendFormat:@"&post_meta[10][value]=%@", postMeta[@"costToCleanAndReinstallEncasements"]];

  [parameters appendFormat:@"&post_meta[11][key]=%@", @"bedBugIncidents"];
  [parameters appendFormat:@"&post_meta[11][value]=%@", postMeta[@"bedBugIncidents"]];
  
  [parameters appendFormat:@"&post_meta[12][key]=%@", @"bugInspectionAndPestControlFees"];
  [parameters appendFormat:@"&post_meta[12][value]=%@", postMeta[@"bugInspectionAndPestControlFees"]];

  [parameters appendFormat:@"&post_meta[13][key]=%@", @"futureBookingDaysLost"];
  [parameters appendFormat:@"&post_meta[13][value]=%@", postMeta[@"futureBookingDaysLost"]];

  [parameters appendFormat:@"&post_meta[14][key]=%@", @"occupancyRate"];
  [parameters appendFormat:@"&post_meta[14][value]=%@", postMeta[@"occupancyRate"]];
  
  [parameters appendFormat:@"&post_meta[15][key]=%@", @"preemptivePestControlRetainer"];
  [parameters appendFormat:@"&post_meta[15][value]=%@", postMeta[@"preemptivePestControlRetainer"]];
  
  [parameters appendFormat:@"&post_meta[16][key]=%@", @"grievanceCosts"];
  [parameters appendFormat:@"&post_meta[16][value]=%@", postMeta[@"grievanceCosts"]];
  NSLog(@"%@", parameters);
  [request setHTTPBody:[parameters dataUsingEncoding:NSUTF8StringEncoding]];
  
  NSURLSession *session = [NSURLSession sharedSession];
  
  NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                              completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                
                                                NSLog(@"Response:%@\nError: %@", response, error);
                                                
                                                id json = [NSJSONSerialization JSONObjectWithData:data
                                                                                                options:NSJSONReadingMutableContainers
                                                                                                  error:nil];
                                                NSLog(@"%@", json);
                                                HUD *hud = [HUD singleton];
                                                hud.hud.mode = MBProgressHUDModeText;
                                                
                                                if (error)
                                                {
                                                  hud.hud.detailsLabelText = @"Network error, please try again.";
                                                  
                                                  dispatch_async(dispatch_get_main_queue(), ^{
                                                    [HUD removeHUDAfterDelay:1.5f];
                                                    
                                                    [[NSNotificationCenter defaultCenter] postNotificationName:apiUserPropertyStoreErrorNotification
                                                                                                        object:nil];
                                                  });
                                                }
                                                else
                                                {
                                                  if ([json isKindOfClass:[NSArray class]])
                                                  {
                                                    if (![API isAccountActive:[json firstObject]])
                                                      return;
                                                  }
                                                  
                                                  if ([json isKindOfClass:[NSArray class]] &&
                                                      [[json firstObject][@"code"] isEqualToString:@"json_cannot_create"])
                                                  {
                                                    HUD *hud = [HUD singleton];
                                                    hud.hud.mode = MBProgressHUDModeText;
                                                    hud.hud.detailsLabelText = [json firstObject][@"message"];
                                                    
                                                    dispatch_async(dispatch_get_main_queue(), ^{
                                                      [HUD removeHUDAfterDelay:1.5f];
                                                    });
                                                    
                                                    return;
                                                  }

                                                  hud.hud.detailsLabelText = @"Property successfully saved";
                                                  
                                                  dispatch_async(dispatch_get_main_queue(), ^{
                                                    [HUD removeHUDAfterDelay:1.5f];
                                                    
                                                    [[NSNotificationCenter defaultCenter] postNotificationName:apiUserPropertyStoreSuccessfulNotification
                                                                                                        object:json];
                                                  });
                                                }
                                              }];
  [dataTask resume];
}

+ (void)updateUploadedProperty:(NSString *)postID
                         title:(NSString *)title
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
  
  NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@/%@",
                                     apiPrefix,
                                     properties,
                                     postID]];
  
  NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
  [request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
  [request setHTTPMethod:@"POST"];
  
  NSMutableString *parameters = [NSMutableString stringWithCapacity:0];
  
  [parameters appendFormat:@"iam=%@", base64];
  
  [parameters appendFormat:@"&filter=%@", [GlobalData username]];
  
  [parameters appendFormat:@"&author=%@", [GlobalData authorID]];

  [parameters appendFormat:@"&filter[posts_per_page]=1000"];
  
  [parameters appendString:@"&context=edit"];
  
  [parameters appendString:@"&type=property"];
  
  [parameters appendString:@"&status=publish"];
  
  [parameters appendFormat:@"&title=%@", title];
  
  [parameters appendFormat:@"&content_raw=%@", contentRaw];
  
  [parameters appendFormat:@"&post_meta[0][key]=%@", @"propertyType"];
  [parameters appendFormat:@"&post_meta[0][value]=%@", postMeta[@"propertyType"]];
  
  [parameters appendFormat:@"&post_meta[1][key]=%@", @"roomsNumber"];
  [parameters appendFormat:@"&post_meta[1][value]=%@", postMeta[@"roomsNumber"]];

  [parameters appendFormat:@"&post_meta[2][key]=%@", @"bedsNumber"];
  [parameters appendFormat:@"&post_meta[2][value]=%@", postMeta[@"bedsNumber"]];
  
  [parameters appendFormat:@"&post_meta[3][key]=%@", @"roomRevenuePerNight"];
  [parameters appendFormat:@"&post_meta[3][value]=%@", postMeta[@"roomRevenuePerNight"]];

  [parameters appendFormat:@"&post_meta[4][key]=%@", @"foodBeverageSalesPerRoomPerNight"];
  [parameters appendFormat:@"&post_meta[4][value]=%@", postMeta[@"foodBeverageSalesPerRoomPerNight"]];

  [parameters appendFormat:@"&post_meta[5][key]=%@", @"ancillariesRevenuePerRoomPerNight"];
  [parameters appendFormat:@"&post_meta[5][value]=%@", postMeta[@"ancillariesRevenuePerRoomPerNight"]];

  [parameters appendFormat:@"&post_meta[6][key]=%@", @"costOfReplaceMattressesAndBoxSpring"];
  [parameters appendFormat:@"&post_meta[6][value]=%@", postMeta[@"costOfReplaceMattressesAndBoxSpring"]];

  [parameters appendFormat:@"&post_meta[7][key]=%@", @"costOfReplaceFurnishings"];
  [parameters appendFormat:@"&post_meta[7][value]=%@", postMeta[@"costOfReplaceFurnishings"]];

  [parameters appendFormat:@"&post_meta[8][key]=%@", @"percentageOfMattressesReplaceEachYear"];
  [parameters appendFormat:@"&post_meta[8][value]=%@", postMeta[@"percentageOfMattressesReplaceEachYear"]];

  [parameters appendFormat:@"&post_meta[9][key]=%@", @"timesPerYearBedClean"];
  [parameters appendFormat:@"&post_meta[9][value]=%@", postMeta[@"timesPerYearBedClean"]];

  [parameters appendFormat:@"&post_meta[10][key]=%@", @"costToCleanAndReinstallEncasements"];
  [parameters appendFormat:@"&post_meta[10][value]=%@", postMeta[@"costToCleanAndReinstallEncasements"]];

  [parameters appendFormat:@"&post_meta[11][key]=%@", @"bedBugIncidents"];
  [parameters appendFormat:@"&post_meta[11][value]=%@", postMeta[@"bedBugIncidents"]];

  [parameters appendFormat:@"&post_meta[12][key]=%@", @"bugInspectionAndPestControlFees"];
  [parameters appendFormat:@"&post_meta[12][value]=%@", postMeta[@"bugInspectionAndPestControlFees"]];

  [parameters appendFormat:@"&post_meta[13][key]=%@", @"futureBookingDaysLost"];
  [parameters appendFormat:@"&post_meta[13][value]=%@", postMeta[@"futureBookingDaysLost"]];
  
  [parameters appendFormat:@"&post_meta[14][key]=%@", @"occupancyRate"];
  [parameters appendFormat:@"&post_meta[14][value]=%@", postMeta[@"occupancyRate"]];
  
  [parameters appendFormat:@"&post_meta[15][key]=%@", @"preemptivePestControlRetainer"];
  [parameters appendFormat:@"&post_meta[15][value]=%@", postMeta[@"preemptivePestControlRetainer"]];

  [parameters appendFormat:@"&post_meta[16][key]=%@", @"grievanceCosts"];
  [parameters appendFormat:@"&post_meta[16][value]=%@", postMeta[@"grievanceCosts"]];
  
  [request setHTTPBody:[parameters dataUsingEncoding:NSUTF8StringEncoding]];
  
  NSURLSession *session = [NSURLSession sharedSession];
  
  NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                              completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                
                                                NSLog(@"Response:%@\nError: %@", response, error);
                                                
                                                id json = [NSJSONSerialization JSONObjectWithData:data
                                                                                                options:NSJSONReadingMutableContainers
                                                                                                  error:nil];
                                                NSLog(@"%@", json);
                                                HUD *hud = [HUD singleton];
                                                hud.hud.mode = MBProgressHUDModeText;
                                                
                                                if (error)
                                                {
                                                  hud.hud.detailsLabelText = @"Network error, please try again.";
                                                  
                                                  dispatch_async(dispatch_get_main_queue(), ^{
                                                    [HUD removeHUDAfterDelay:1.5f];
                                                    
                                                    [[NSNotificationCenter defaultCenter] postNotificationName:apiUserPropertyUpdateErrorNotification
                                                                                                        object:json];
                                                  });
                                                }
                                                else
                                                {
                                                  if ([json isKindOfClass:[NSArray class]])
                                                  {
                                                    if (![API isAccountActive:[json firstObject]])
                                                      return;
                                                  }
                                                  
                                                  if ([json isKindOfClass:[NSArray class]] &&
                                                      [[json firstObject][@"code"] isEqualToString:@"json_cannot_edit"])
                                                  {
                                                    HUD *hud = [HUD singleton];
                                                    hud.hud.mode = MBProgressHUDModeText;
                                                    hud.hud.detailsLabelText = [json firstObject][@"message"];
                                                    
                                                    dispatch_async(dispatch_get_main_queue(), ^{
                                                      [HUD removeHUDAfterDelay:1.5f];
                                                    });
                                                    
                                                    return;
                                                  }
                                                  
                                                  hud.hud.detailsLabelText = @"Property successfully updated";
                                                  
                                                  dispatch_async(dispatch_get_main_queue(), ^{
                                                    [HUD removeHUDAfterDelay:1.5f];
                                                    
                                                    [[NSNotificationCenter defaultCenter] postNotificationName:apiUserPropertyUpdateSuccessfulNotification
                                                                                                        object:json];
                                                  });
                                                }
                                              }];
  [dataTask resume];
}

+ (void)deleteProperty:(NSManagedObject *)property
{
  [HUD addHUD];
  
  NSString *auth = [NSString stringWithFormat:@"%@fjir50e%@",
                    [GlobalData username],
                    [GlobalData password]];
  
  NSData *authData = [auth dataUsingEncoding:NSUTF8StringEncoding];
  NSString *base64 = [authData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
  
  NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@/%@",
                                     apiPrefix,
                                     properties,
                                     [property valueForKey:@"propertyID"]]];
  NSLog(@"%@", [url absoluteString]);
  NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
  [request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
  [request setHTTPMethod:@"POST"];
  
  NSMutableString *parameters = [NSMutableString stringWithCapacity:0];
  
  [parameters appendFormat:@"iam=%@", base64];
  
  [parameters appendFormat:@"&filter=%@", [GlobalData username]];
  
  [parameters appendFormat:@"&author=%@", [GlobalData authorID]];

  [parameters appendFormat:@"&filter[posts_per_page]=1000"];
  
  [parameters appendString:@"&context=edit"];
  
  [parameters appendString:@"&type=property"];
  
  [parameters appendString:@"&status=trash"];
  
  [parameters appendFormat:@"&title=%@", [property valueForKey:@"name"]];
  
  [parameters appendFormat:@"&content_raw=%@", [property valueForKey:@"name"]];
  
  [parameters appendFormat:@"&post_meta[0][key]=%@", @"propertyType"];
  [parameters appendFormat:@"&post_meta[0][value]=%@", [property valueForKey:@"propertyType"]];
  
  [parameters appendFormat:@"&post_meta[1][key]=%@", @"roomsNumber"];
  [parameters appendFormat:@"&post_meta[1][value]=%@", [property valueForKey:@"roomsNumber"]];
  
  [parameters appendFormat:@"&post_meta[2][key]=%@", @"bedsNumber"];
  [parameters appendFormat:@"&post_meta[2][value]=%@", [property valueForKey:@"bedsNumber"]];
  
  [parameters appendFormat:@"&post_meta[3][key]=%@", @"roomRevenuePerNight"];
  [parameters appendFormat:@"&post_meta[3][value]=%@", [property valueForKey:@"roomRevenuePerNight"]];
  
  [parameters appendFormat:@"&post_meta[4][key]=%@", @"foodBeverageSalesPerRoomPerNight"];
  [parameters appendFormat:@"&post_meta[4][value]=%@", [property valueForKey:@"foodBeverageSalesPerRoomPerNight"]];
  
  [parameters appendFormat:@"&post_meta[5][key]=%@", @"ancillariesRevenuePerRoomPerNight"];
  [parameters appendFormat:@"&post_meta[5][value]=%@", [property valueForKey:@"ancillariesRevenuePerRoomPerNight"]];
  
  [parameters appendFormat:@"&post_meta[6][key]=%@", @"costOfReplaceMattressesAndBoxSpring"];
  [parameters appendFormat:@"&post_meta[6][value]=%@", [property valueForKey:@"costOfReplaceMattressesAndBoxSpring"]];
  
  [parameters appendFormat:@"&post_meta[7][key]=%@", @"costOfReplaceFurnishings"];
  [parameters appendFormat:@"&post_meta[7][value]=%@", [property valueForKey:@"costOfReplaceFurnishings"]];
  
  [parameters appendFormat:@"&post_meta[8][key]=%@", @"percentageOfMattressesReplaceEachYear"];
  [parameters appendFormat:@"&post_meta[8][value]=%@", [property valueForKey:@"percentageOfMattressesReplaceEachYear"]];
  
  [parameters appendFormat:@"&post_meta[9][key]=%@", @"timesPerYearBedClean"];
  [parameters appendFormat:@"&post_meta[9][value]=%@", [property valueForKey:@"timesPerYearBedClean"]];
  
  [parameters appendFormat:@"&post_meta[10][key]=%@", @"costToCleanAndReinstallEncasements"];
  [parameters appendFormat:@"&post_meta[10][value]=%@", [property valueForKey:@"costToCleanAndReinstallEncasements"]];
  
  [parameters appendFormat:@"&post_meta[11][key]=%@", @"bedBugIncidents"];
  [parameters appendFormat:@"&post_meta[11][value]=%@", [property valueForKey:@"bedBugIncidents"]];
  
  [parameters appendFormat:@"&post_meta[12][key]=%@", @"bugInspectionAndPestControlFees"];
  [parameters appendFormat:@"&post_meta[12][value]=%@", [property valueForKey:@"bugInspectionAndPestControlFees"]];
  
  [parameters appendFormat:@"&post_meta[13][key]=%@", @"futureBookingDaysLost"];
  [parameters appendFormat:@"&post_meta[13][value]=%@", [property valueForKey:@"futureBookingDaysLost"]];
  
  [parameters appendFormat:@"&post_meta[14][key]=%@", @"occupancyRate"];
  [parameters appendFormat:@"&post_meta[14][value]=%@", [property valueForKey:@"occupancyRate"]];
  
  [parameters appendFormat:@"&post_meta[15][key]=%@", @"preemptivePestControlRetainer"];
  [parameters appendFormat:@"&post_meta[15][value]=%@", [property valueForKey:@"preemptivePestControlRetainer"]];

  [parameters appendFormat:@"&post_meta[16][key]=%@", @"grievanceCosts"];
  [parameters appendFormat:@"&post_meta[16][value]=%@", [property valueForKey:@"grievanceCosts"]];
  
  [request setHTTPBody:[parameters dataUsingEncoding:NSUTF8StringEncoding]];
  
  NSURLSession *session = [NSURLSession sharedSession];
  
  NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                              completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                
                                                NSLog(@"Response:%@\nError: %@", response, error);
                                                
                                                id json = [NSJSONSerialization JSONObjectWithData:data
                                                                                                options:NSJSONReadingMutableContainers
                                                                                                  error:nil];
                                                NSLog(@"%@", json);
                                                HUD *hud = [HUD singleton];
                                                hud.hud.mode = MBProgressHUDModeText;
                                                
                                                if (error)
                                                {
                                                  hud.hud.detailsLabelText = @"Network error, please try again.";
                                                  
                                                  dispatch_async(dispatch_get_main_queue(), ^{
                                                    [HUD removeHUDAfterDelay:1.5f];
                                                    
                                                    [[NSNotificationCenter defaultCenter] postNotificationName:apiUserPropertyDeleteErrorNotification
                                                                                                        object:json];
                                                  });
                                                }
                                                else
                                                {
                                                  if ([json isKindOfClass:[NSArray class]])
                                                  {
                                                    if (![API isAccountActive:[json firstObject]])
                                                      return;
                                                  }
                                                  
                                                  if ([json isKindOfClass:[NSArray class]] &&
                                                      [[json firstObject][@"code"] isEqualToString:@"json_cannot_edit"])
                                                  {
                                                    HUD *hud = [HUD singleton];
                                                    hud.hud.mode = MBProgressHUDModeText;
                                                    hud.hud.detailsLabelText = [json firstObject][@"message"];
                                                    
                                                    dispatch_async(dispatch_get_main_queue(), ^{
                                                      [HUD removeHUDAfterDelay:1.5f];
                                                    });
                                                    
                                                    return;
                                                  }

                                                  hud.hud.detailsLabelText = @"Property successfully deleted";
                                                  
                                                  dispatch_async(dispatch_get_main_queue(), ^{
                                                    [HUD removeHUDAfterDelay:1.5f];
                                                    
                                                    CoreDataManager *cdm = [CoreDataManager singleton];
                                                    [cdm deleteObject:property];
                                                    [cdm saveData];
                                                    
                                                    [[NSNotificationCenter defaultCenter] postNotificationName:apiUserPropertyDeleteSuccessfulNotification
                                                                                                        object:json];
                                                  });
                                                }
                                              }];
  [dataTask resume];
}

+ (void)profilePasswordRecover:(NSString *)email
{
  [HUD addHUD];
  
  NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@?user_login=%@",
                                     apiPrefix,
                                     recoverPassword,
                                     email]];
  NSLog(@"%@", [url absoluteString]);
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
                                                HUD *hud = [HUD singleton];
                                                hud.hud.mode = MBProgressHUDModeText;
                                                
                                                if ([json isKindOfClass:[NSArray class]])
                                                {
                                                  if (![API isAccountActive:[json firstObject]])
                                                    return;
                                                }
                                                
                                                if ([[json firstObject][@"code"] isEqualToString:@"invalid_username"])
                                                  hud.hud.detailsLabelText = @"Invalid Email";
                                                else
                                                  hud.hud.detailsLabelText = @"Check your e-mail for the confirmation link.";
                                                
                                                dispatch_async(dispatch_get_main_queue(), ^{
                                                  [HUD removeHUDAfterDelay:1.5f];
                                                  
                                                  [[NSNotificationCenter defaultCenter] postNotificationName:apiUserLoginErrorNotification
                                                                                                      object:json];
                                                });
                                              }];
  [dataTask resume];
}

@end