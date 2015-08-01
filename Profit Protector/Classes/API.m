#import "API.h"
#import "HUD.h"
#import "Constants.h"

@implementation API

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
  NSLog(@"%@", url);

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
  NSLog(@"%@", parameters);
  [request setHTTPBody:[parameters dataUsingEncoding:NSUTF8StringEncoding]];
  
  NSURLSession *session = [NSURLSession sharedSession];
  
  NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                              completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                
                                                NSLog(@"Response:%@\nError: %@", response, error);
                                                
                                                NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data
                                                                                                     options:NSJSONReadingMutableContainers
                                                                                                       error:nil];
                                                
                                                NSLog(@"%@", json);
                                                [HUD removeHUD];
                                                
                                                dispatch_async(dispatch_get_main_queue(), ^{
                                                  [[NSNotificationCenter defaultCenter] postNotificationName:@""
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
                    adminUsername,
                    adminPassword];
  
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
  
  NSString *parameters = [NSString stringWithFormat:@"iam=%@&type[]=property&context=edit",
                          base64];
  NSLog(@"%@", parameters);
//  [request setHTTPBody:[parameters dataUsingEncoding:NSUTF8StringEncoding]];
  
  NSURLSession *session = [NSURLSession sharedSession];
  
  NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                              completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                
                                                NSLog(@"Response:%@\nError: %@", response, error);
                                                
                                                NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data
                                                                                                     options:NSJSONReadingMutableContainers
                                                                                                       error:nil];
                                                
                                                NSLog(@"%@", json);
                                                
                                                dispatch_async(dispatch_get_main_queue(), ^{
                                                  [HUD removeHUD];
                                                  
                                                  [[NSNotificationCenter defaultCenter] postNotificationName:@""
                                                                                                      object:json];
                                                });
                                              }];
  [dataTask resume];
}

@end
