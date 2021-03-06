#import "SplashViewController.h"
#import "API.h"
#import "GlobalData.h"
#import "GlobalMethods.h"
#import "SignupViewController.h"
#import "TutorialViewController.h"
#import "CoreDataStoring.h"

@interface SplashViewController () <UITextFieldDelegate>
{
  UITextField *username_,
              *password_;
  
  UIImageView *usernameAsterix_,
              *passwordAsterix_;
}
@end

@implementation SplashViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  UIImageView *logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[GlobalMethods isTheChineseVersion] ? @"logo_ch" : @"logo"]];
  logo.frame = CGRectMake((CGRectGetWidth(self.view.bounds) - logo.image.size.width / 1.5f) / 2.0f,
                          60.0f,
                          logo.image.size.width / 1.5f,
                          logo.image.size.height / 1.5f);
  [self.view addSubview:logo];
  
  UILabel *copy = [[UILabel alloc] initWithFrame:CGRectMake(20.0f,
                                                            CGRectGetMaxY(logo.frame) + 10.0f,
                                                            CGRectGetWidth(self.view.bounds) - 40.0f,
                                                            26.0f)];
  copy.text = [GlobalMethods localizedStringWithKey:@"Profit Protector"];
  copy.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:21.0f];
  copy.textAlignment = NSTextAlignmentCenter;
  copy.textColor = [UIColor colorWithRed:0.02 green:0.27 blue:0.52 alpha:1];
  [self.view addSubview:copy];
  
  CGFloat textFieldHeight = 37.0f;
  CGFloat textFieldFontsize = 16.0f;
  CGFloat buttonHeight = 60.0f;
  
  // username
  username_ = [[UITextField alloc] initWithFrame:CGRectMake(60.0f,
                                                            CGRectGetMaxY(copy.frame) + 20.0f,
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
  
  // signup
  UIButton *forgotPassword = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.bounds) / 2.0f,
                                                                        CGRectGetMaxY(password_.frame),
                                                                        CGRectGetWidth(self.view.bounds) / 2.0f,
                                                                        buttonHeight / 2.0f)];
  forgotPassword.showsTouchWhenHighlighted = YES;
  forgotPassword.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:12.0f];
  [forgotPassword setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
  [forgotPassword setTitle:[GlobalMethods localizedStringWithKey:@"Forgot Password"] forState:UIControlStateNormal];
  [forgotPassword addTarget:self
                     action:@selector(forgotPassword:)
           forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:forgotPassword];
  
  // signup
  UIButton *signin = [[UIButton alloc] initWithFrame:CGRectMake(0.0f,
                                                                CGRectGetHeight(self.view.bounds) - (buttonHeight * 2.0f),
                                                                CGRectGetWidth(self.view.bounds),
                                                                buttonHeight)];
  signin.backgroundColor = [UIColor colorWithRed:0 green:0.68 blue:0.95 alpha:1];
  signin.showsTouchWhenHighlighted = YES;
  [signin setTitle:[GlobalMethods localizedStringWithKey:@"Sign In"] forState:UIControlStateNormal];
  [signin addTarget:self
             action:@selector(signin:)
   forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:signin];
  
  // signup
  UIButton *signup = [[UIButton alloc] initWithFrame:CGRectMake(0.0f,
                                                                CGRectGetHeight(self.view.bounds) - (buttonHeight / 2.0f) - 15.0f,
                                                                CGRectGetWidth(self.view.bounds),
                                                                buttonHeight / 2.0f)];
  signup.showsTouchWhenHighlighted = YES;
  signup.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:12.0f];
  [signup setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
  [signup setTitle:[GlobalMethods localizedStringWithKey:@"Don't have an account? Sign Up"] forState:UIControlStateNormal];
  [signup addTarget:self
             action:@selector(signup:)
   forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:signup];
  
  [self disactivateAllAsterixes];
  
  //
  UITapGestureRecognizer *tapper = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                           action:@selector(handleSingleTap:)];
  tapper.cancelsTouchesInView = NO;
  [self.view addGestureRecognizer:tapper];
}

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  
  //
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(apiUserLoginSuccessful:)
                                               name:apiUserLoginSuccessfulNotification
                                             object:nil];
  
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(userHasBeenRegistered:)
                                               name:userHasBeenRegisteredNotification
                                             object:nil];
  
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(licenseHasBeenActivated:)
                                               name:licenseHasBeenActivatedNotification
                                             object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
  [super viewWillDisappear:animated];
  
  [[NSNotificationCenter defaultCenter] removeObserver:self
                                                  name:apiUserLoginSuccessfulNotification
                                                object:nil];
  
  [[NSNotificationCenter defaultCenter] removeObserver:self
                                                  name:userHasBeenRegisteredNotification
                                                object:nil];
  
  [[NSNotificationCenter defaultCenter] removeObserver:self
                                                  name:accountLicenseDisabledStatusNotification
                                                object:nil];
  
  [[NSNotificationCenter defaultCenter] removeObserver:self
                                                  name:licenseHasBeenActivatedNotification
                                                object:nil];
}

- (void)handleSingleTap:(UITapGestureRecognizer *) sender
{
  [self.view endEditing:YES];
}

- (void)forgotPassword:(UIButton *)uib
{
  // display the name and info request
  UIAlertController *alert = [UIAlertController alertControllerWithTitle:[GlobalMethods localizedStringWithKey:@"Password reset"]
                                                                 message:[GlobalMethods localizedStringWithKey:@"Please enter your username or email address. You will receive a link to create a new password via email."]
                                                          preferredStyle:UIAlertControllerStyleAlert];
  
  [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
    textField.placeholder = @"email";
    textField.font = [UIFont fontWithName:@"helveticaNeue" size:16.0f];
  }];
  
  UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK"
                                               style:UIAlertActionStyleDefault
                                             handler:^(UIAlertAction * action)
                       {
                         UITextField *info = [alert textFields][0];
                         
                         if (![info.text isEqualToString:@""])
                           [API profilePasswordRecover:info.text];
                       }];
  
  [alert addAction:ok];
  
  UIAlertAction *cancel = [UIAlertAction actionWithTitle:[GlobalMethods localizedStringWithKey:@"Cancel"]
                                                   style:UIAlertActionStyleDestructive
                                                 handler:nil];
  
  [alert addAction:cancel];
  
  [self presentViewController:alert animated:YES completion:nil];
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

- (void)signin:(UIButton *)uib
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
 
  [API loginWithUsername:username_.text
                password:password_.text];
}

- (void)signup:(UIButton *)uib
{
  SignupViewController *svc = [[SignupViewController alloc] initWithNibName:nil
                                                                     bundle:nil];
  
  [self presentViewController:[[UINavigationController alloc] initWithRootViewController:svc]
                     animated:YES
                   completion:nil];
}

#pragma mark - API notifications callbacks

- (void)apiUserLoginSuccessful:(NSNotification *)notification
{
  NSDictionary *json = (NSDictionary *)notification.object;

  if (![username_.text isEqualToString:@""] &&
      ![password_.text isEqualToString:@""])
  {
    [GlobalData saveUsername:username_.text];
    [GlobalData savePassword:password_.text];
  }

  [GlobalData saveAuthorID:json[@"ID"]];
  [GlobalData saveLicenseID:json[@"license"][@"code"]];
  
  //
  NSString *role = [json[@"roles"] firstObject];
  
  if ([role isEqualToString:@"distributor"])
    role = @"Distributor";
  
  if ([role isEqualToString:@"hotel_owner"])
    role = @"Hotel Owner";
  
  if ([role isEqualToString:@"pco"])
    role = @"PCO";
  
  //
  [CoreDataStoring storeAuthor:@{@"company": json[@"company"],
                                 @"email": json[@"username"],
                                 @"password": [GlobalData password],
                                 @"authorID": json[@"ID"],
                                 @"licenseID": json[@"license"][@"code"],
                                 @"firstname": json[@"first_name"],
                                 @"lastname": json[@"last_name"],
                                 @"phone": json[@"phone"],
                                 @"role": role}];
  
  if (![GlobalData walkthrough])
  {
    TutorialViewController *tvc = [[TutorialViewController alloc] initWithNibName:nil
                                                                           bundle:nil];
    [self.navigationController pushViewController:tvc animated:YES];
  }
  else
  {
    [[NSNotificationCenter defaultCenter] postNotificationName:displayMainViewControllerNotification
                                                        object:nil];
  }
}

- (void)userHasBeenRegistered:(NSNotification *)notification
{
  [API loginWithUsername:[GlobalData username]
                password:[GlobalData password]];
}

- (void)licenseHasBeenActivated:(NSNotification *)notification
{
  if (![GlobalData walkthrough])
  {
    TutorialViewController *tvc = [[TutorialViewController alloc] initWithNibName:nil
                                                                           bundle:nil];
    [self.navigationController pushViewController:tvc animated:YES];
  }
  else
  {
    [[NSNotificationCenter defaultCenter] postNotificationName:displayMainViewControllerNotification
                                                        object:nil];
  }
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

@end