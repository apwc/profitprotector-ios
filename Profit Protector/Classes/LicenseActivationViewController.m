#import "LicenseActivationViewController.h"
#import "GlobalMethods.h"
#import "Constants.h"
#import "API.h"
#import "GlobalData.h"

@interface LicenseActivationViewController () <UITextFieldDelegate>
{
  UITextField *username_,
              *password_,
              *serial_;
  
  UIImageView *usernameAsterix_,
              *passwordAsterix_;
}
@end

@implementation LicenseActivationViewController

- (void)dealloc
{
  [[NSNotificationCenter defaultCenter] removeObserver:self
                                                  name:apiLicenseActivationSuccessfulNotification
                                                object:nil];
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  self.code = @"B2TA-56C50E9F58968";
  
  self.view.backgroundColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
  
  CGFloat textFieldHeight = 37.0f;
  CGFloat textFieldFontsize = 16.0f;

  UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10.0f,
                                                             110.0f,
                                                             CGRectGetWidth(self.view.frame) - 20.0f,
                                                             26.0f)];
  label.textColor = [UIColor darkTextColor];
  label.textAlignment = NSTextAlignmentCenter;
  label.font = [UIFont fontWithName:@"HelveticaNeue" size:19.0f];
  label.text = [GlobalMethods localizedStringWithKey:@"Activation Code"];
  [self.view addSubview:label];
  
  // username
  username_ = [[UITextField alloc] initWithFrame:CGRectMake(60.0f,
                                                            CGRectGetMaxY(label.frame) + 10.0f,
                                                            CGRectGetWidth(self.view.bounds) - 100.0f,
                                                            textFieldHeight)];
  username_.delegate = self;
  username_.font = [UIFont fontWithName:@"HelveticaNeue" size:textFieldFontsize];
  username_.textColor = [UIColor blackColor];
  username_.autocorrectionType = UITextAutocorrectionTypeNo;
  username_.autocapitalizationType = UITextAutocapitalizationTypeNone;
  username_.placeholder = [GlobalMethods localizedStringWithKey:@"Email"];
  username_.clipsToBounds = NO;
  [self.view addSubview:username_];
  
  UIImageView *usernameIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"email"]];
  usernameIcon.frame = CGRectMake(20.0f,
                                  CGRectGetMinY(username_.frame) + 10.0f,
                                  usernameIcon.image.size.width,
                                  usernameIcon.image.size.height);
  [self.view addSubview:usernameIcon];
  
  usernameAsterix_ = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"asterix"]];
  usernameAsterix_.center = CGPointMake(CGRectGetWidth(username_.bounds) + 15.0f, CGRectGetMidY(username_.bounds));
  [username_ addSubview:usernameAsterix_];
  
  // division line
  UIView *divisionLine1 = [[UIView alloc] initWithFrame:CGRectMake(0.0f,
                                                                   CGRectGetMaxY(username_.frame),
                                                                   CGRectGetWidth(self.view.bounds),
                                                                   1.0f)];
  divisionLine1.backgroundColor = [UIColor colorWithWhite:0.7f alpha:1.0f];
  [self.view addSubview:divisionLine1];
  
  // password
  password_ = [[UITextField alloc] initWithFrame:CGRectMake(60.0f,
                                                            CGRectGetMaxY(username_.frame),
                                                            CGRectGetWidth(username_.bounds),
                                                            textFieldHeight)];
  password_.delegate = self;
  password_.font = [UIFont fontWithName:@"HelveticaNeue" size:textFieldFontsize];
  password_.textColor = [UIColor blackColor];
  password_.autocorrectionType = UITextAutocorrectionTypeNo;
  password_.autocapitalizationType = UITextAutocapitalizationTypeNone;
  password_.secureTextEntry = YES;
  password_.placeholder = [GlobalMethods localizedStringWithKey:@"Password"];
  password_.clipsToBounds = NO;
  [self.view addSubview:password_];
  
  UIImageView *passwordIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"password"]];
  passwordIcon.frame = CGRectMake(20.0f,
                                  CGRectGetMinY(password_.frame) + 10.0f,
                                  usernameIcon.image.size.width,
                                  usernameIcon.image.size.height);
  [self.view addSubview:passwordIcon];
  
  passwordAsterix_ = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"asterix"]];
  passwordAsterix_.center = CGPointMake(CGRectGetWidth(password_.bounds) + 15.0f, CGRectGetMidY(password_.bounds));
  [password_ addSubview:passwordAsterix_];
  
  // division line
  UIView *divisionLine2 = [[UIView alloc] initWithFrame:CGRectMake(0.0f,
                                                                   CGRectGetMaxY(password_.frame),
                                                                   CGRectGetWidth(self.view.bounds),
                                                                   1.0f)];
  divisionLine2.backgroundColor = [UIColor colorWithWhite:0.7f alpha:1.0f];
  [self.view addSubview:divisionLine2];
  
  // license code
  serial_ = [[UITextField alloc] initWithFrame:CGRectMake(20.0f,
                                                          CGRectGetMaxY(password_.frame) + 20.0f,
                                                          CGRectGetWidth(self.view.bounds) - 40.0f,
                                                          textFieldHeight)];
  serial_.backgroundColor = [UIColor whiteColor];
  serial_.font = [UIFont fontWithName:@"HelveticaNeue" size:21.0f];
  serial_.textColor = [UIColor darkTextColor];
  serial_.autocorrectionType = UITextAutocorrectionTypeNo;
  serial_.autocapitalizationType = UITextAutocapitalizationTypeNone;
  serial_.text = self.code ? self.code : @"";
  [self.view addSubview:serial_];
  
  UIButton *cancel = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMinX(serial_.frame),
                                                                CGRectGetMaxY(serial_.frame) + 40.0f,
                                                                (CGRectGetWidth(serial_.frame) / 2.0f) - 10.0f,
                                                                37.0f)];
  cancel.backgroundColor = [UIColor colorWithWhite:0.5f alpha:1.0f];
  cancel.showsTouchWhenHighlighted = YES;
  [cancel setTintColor:[UIColor whiteColor]];
  [cancel setTitle:@"CANCEL" forState:UIControlStateNormal];
  [cancel addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:cancel];
  
  UIButton *submit = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(serial_.frame) - CGRectGetWidth(cancel.frame),
                                                                CGRectGetMinY(cancel.frame),
                                                                CGRectGetWidth(cancel.frame),
                                                                37.0f)];
  submit.backgroundColor = [UIColor colorWithWhite:0.5f alpha:1.0f];
  submit.showsTouchWhenHighlighted = YES;
  [submit setTintColor:[UIColor whiteColor]];
  [submit setTitle:@"SUBMIT" forState:UIControlStateNormal];
  [submit addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:submit];
  
  [self disactivateAllAsterixes];
  
  //
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(apiLicenseActivationSuccessful:)
                                               name:apiLicenseActivationSuccessfulNotification
                                             object:nil];
}

- (void)cancel:(id)sender
{
  [self dismissViewControllerAnimated:YES
                           completion:^{
                             if (sender == nil)
                               [[NSNotificationCenter defaultCenter] postNotificationName:licenseHasBeenActivatedNotification
                                                                                   object:nil];
                           }];
}

- (void)submit:(id)sender
{
  if ([self checkAndActivateAsterixesForMissingFields])
  {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil
                                                                   message:@"Please fill all the missing fields"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Ok"
                                                 style:UIAlertActionStyleCancel
                                               handler:nil];
    
    [alert addAction:ok];
    
    [self presentViewController:alert animated:YES completion:nil];
    
    return;
  }
  
  [API activateLicense:serial_.text username:username_.text password:password_.text];
}

- (void)disactivateAllAsterixes
{
  usernameAsterix_.hidden = YES;
  passwordAsterix_.hidden = YES;
}

- (BOOL)checkAndActivateAsterixesForMissingFields
{
  BOOL flag = NO;
  
  if ([username_.text isEqualToString:@""])
  {
    flag = YES;
    usernameAsterix_.hidden = NO;
  }
  else
    usernameAsterix_.hidden = YES;
  
  if ([password_.text isEqualToString:@""])
  {
    flag = YES;
    passwordAsterix_.hidden = NO;
  }
  else
    passwordAsterix_.hidden = YES;
  
  return flag;
}

#pragma mark - UITextField delegate methods implementation

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
  return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
  [textField resignFirstResponder];
  
  return YES;
}

#pragma mark - UI notifications callbacks

- (void)apiLicenseActivationSuccessful:(NSNotification *)notification
{
  NSDictionary *json = (NSDictionary *)notification.object;
  
  [GlobalData saveUsername:username_.text];
  [GlobalData savePassword:password_.text];
  [GlobalData saveAuthorID:json[@"ID"]];
  [GlobalData saveLicenseID:json[@"license"][@"code"]];
  
  [GlobalData saveAccountStatus:Approved];
  
  NSLog(@"username_.text %@", username_.text);
  NSLog(@"password_.text %@", password_.text);
  NSLog(@"[GlobalData username] %@", [GlobalData username]);
  NSLog(@"[GlobalData password] %@", [GlobalData password]);
  
  [self cancel:nil];
}

@end