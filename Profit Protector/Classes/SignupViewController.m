#import "SignupViewController.h"
#import "API.h"
#import "GlobalData.h"
#import "UserTypeTableViewController.h"
#import "GlobalMethods.h"

@interface SignupViewController () <UITextFieldDelegate,
                                    UserTypeDelegate>
{
  UIScrollView *uisv_;
  
  UITextField *name_,
              *username_,
              *password_,
              *email_,
              *phone_,
              *company_,
              *type_;
  
  UIImageView *emailAsterix_,
              *passwordAsterix_,
              *nameAsterix_,
              *phoneAsterix_,
              *companyAsterix_,
              *typeAsterix_;
}
@end

@implementation SignupViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:[GlobalMethods localizedStringWithKey:@"Close"]
                                                                           style:UIBarButtonItemStylePlain
                                                                          target:self
                                                                          action:@selector(close:)];
  
  uisv_ = [[UIScrollView alloc] initWithFrame:self.view.bounds];
  uisv_.autoresizingMask = (UIViewAutoresizingFlexibleWidth |
                            UIViewAutoresizingFlexibleHeight);
  [self.view addSubview:uisv_];
  
  UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(15.0f,
                                                             14.0f,
                                                             CGRectGetWidth(self.view.frame) - 15.0f,
                                                             48.0f)];
  title.text = [GlobalMethods localizedStringWithKey:@"Sign Up"];
  title.font = [UIFont fontWithName:@"HelveticaNeue" size:26.0f];
  title.textColor = [UIColor darkGrayColor];
  [uisv_ addSubview:title];
  
  CGFloat textFieldWidth = CGRectGetWidth(self.view.bounds) - 100.0f;
  CGFloat textFieldHeight = 37.0f;
  CGFloat textFieldFontsize = 16.0f;
  CGFloat buttonHeight = 60.0f;
  
  // email
  email_ = [[UITextField alloc] initWithFrame:CGRectMake(60.0f,
                                                         CGRectGetMaxY(title.frame),
                                                         textFieldWidth,
                                                         textFieldHeight)];
  email_.delegate = self;
  email_.font = [UIFont fontWithName:@"HelveticaNeue" size:textFieldFontsize];
  email_.textColor = [UIColor blackColor];
  email_.autocorrectionType = UITextAutocorrectionTypeNo;
  email_.autocapitalizationType = UITextAutocapitalizationTypeNone;
  email_.placeholder = [GlobalMethods localizedStringWithKey:@"Email"];
  email_.clipsToBounds = NO;
  [uisv_ addSubview:email_];
  
  UIImageView *emailIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"email"]];
  emailIcon.frame = CGRectMake(20.0f,
                               CGRectGetMinY(email_.frame) + 10.0f,
                               emailIcon.image.size.width,
                               emailIcon.image.size.height);
  [uisv_ addSubview:emailIcon];
  
  emailAsterix_ = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"asterix"]];
  emailAsterix_.center = CGPointMake(CGRectGetWidth(email_.bounds) + 15.0f, CGRectGetMidY(email_.bounds));
  [email_ addSubview:emailAsterix_];

  // division line
  UIView *divisionLine1 = [[UIView alloc] initWithFrame:CGRectMake(0.0f,
                                                                   CGRectGetMaxY(email_.frame),
                                                                   CGRectGetWidth(self.view.bounds),
                                                                   1.0f)];
  divisionLine1.backgroundColor = [UIColor colorWithWhite:0.7f alpha:1.0f];
  [uisv_ addSubview:divisionLine1];
  
  // password
  password_ = [[UITextField alloc] initWithFrame:CGRectMake(60.0f,
                                                            CGRectGetMaxY(email_.frame),
                                                            textFieldWidth,
                                                            textFieldHeight)];
  password_.delegate = self;
  password_.font = [UIFont fontWithName:@"HelveticaNeue" size:textFieldFontsize];
  password_.textColor = [UIColor blackColor];
  password_.autocorrectionType = UITextAutocorrectionTypeNo;
  password_.autocapitalizationType = UITextAutocapitalizationTypeNone;
  password_.secureTextEntry = YES;
  password_.placeholder = [GlobalMethods localizedStringWithKey:@"Password"];
  password_.clipsToBounds = NO;
  [uisv_ addSubview:password_];
  
  UIImageView *passwordIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"password"]];
  passwordIcon.frame = CGRectMake(20.0f,
                                  CGRectGetMinY(password_.frame) + 10.0f,
                                  emailIcon.image.size.width,
                                  emailIcon.image.size.height);
  [uisv_ addSubview:passwordIcon];
  
  passwordAsterix_ = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"asterix"]];
  passwordAsterix_.center = CGPointMake(CGRectGetWidth(password_.bounds) + 15.0f, CGRectGetMidY(password_.bounds));
  [password_ addSubview:passwordAsterix_];
  
  // division line
  UIView *divisionLine2 = [[UIView alloc] initWithFrame:CGRectMake(0.0f,
                                                                   CGRectGetMaxY(password_.frame),
                                                                   CGRectGetWidth(self.view.bounds),
                                                                   1.0f)];
  divisionLine2.backgroundColor = [UIColor colorWithWhite:0.7f alpha:1.0f];
  [uisv_ addSubview:divisionLine2];
  
  // name
  name_ = [[UITextField alloc] initWithFrame:CGRectMake(60.0f,
                                                        CGRectGetMaxY(password_.frame),
                                                        textFieldWidth,
                                                        textFieldHeight)];
  name_.delegate = self;
  name_.font = [UIFont fontWithName:@"HelveticaNeue" size:textFieldFontsize];
  name_.textColor = [UIColor blackColor];
  name_.autocorrectionType = UITextAutocorrectionTypeNo;
  name_.autocapitalizationType = UITextAutocapitalizationTypeNone;
  name_.placeholder = [GlobalMethods localizedStringWithKey:@"Full Name"];
  name_.clipsToBounds = NO;
  [uisv_ addSubview:name_];
  
  UIImageView *nameIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"username"]];
  nameIcon.frame = CGRectMake(20.0f,
                              CGRectGetMinY(name_.frame) + 10.0f,
                              emailIcon.image.size.width,
                              emailIcon.image.size.height);
  [uisv_ addSubview:nameIcon];
  
  nameAsterix_ = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"asterix"]];
  nameAsterix_.center = CGPointMake(CGRectGetWidth(name_.bounds) + 15.0f, CGRectGetMidY(name_.bounds));
  [name_ addSubview:nameAsterix_];
  
  // division line
  UIView *divisionLine3 = [[UIView alloc] initWithFrame:CGRectMake(0.0f,
                                                                   CGRectGetMaxY(name_.frame),
                                                                   CGRectGetWidth(self.view.bounds),
                                                                   1.0f)];
  divisionLine3.backgroundColor = [UIColor colorWithWhite:0.7f alpha:1.0f];
  [uisv_ addSubview:divisionLine3];

  // phone
  phone_ = [[UITextField alloc] initWithFrame:CGRectMake(60.0f,
                                                         CGRectGetMaxY(name_.frame),
                                                         textFieldWidth,
                                                         textFieldHeight)];
  phone_.delegate = self;
  phone_.font = [UIFont fontWithName:@"HelveticaNeue" size:textFieldFontsize];
  phone_.textColor = [UIColor blackColor];
  phone_.autocorrectionType = UITextAutocorrectionTypeNo;
  phone_.autocapitalizationType = UITextAutocapitalizationTypeNone;
  phone_.placeholder = [GlobalMethods localizedStringWithKey:@"Phone"];
  phone_.clipsToBounds = NO;
  [uisv_ addSubview:phone_];
  
  UIImageView *phoneIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"phone"]];
  phoneIcon.frame = CGRectMake(20.0f,
                               CGRectGetMinY(phone_.frame) + 10.0f,
                               phoneIcon.image.size.width,
                               phoneIcon.image.size.height);
  [uisv_ addSubview:phoneIcon];
  
  phoneAsterix_ = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"asterix"]];
  phoneAsterix_.center = CGPointMake(CGRectGetWidth(phone_.bounds) + 15.0f, CGRectGetMidY(phone_.bounds));
  [phone_ addSubview:phoneAsterix_];
  
  // division line
  UIView *divisionLine5 = [[UIView alloc] initWithFrame:CGRectMake(0.0f,
                                                                   CGRectGetMaxY(phone_.frame),
                                                                   CGRectGetWidth(self.view.bounds),
                                                                   1.0f)];
  divisionLine5.backgroundColor = [UIColor colorWithWhite:0.7f alpha:1.0f];
  [uisv_ addSubview:divisionLine5];
  
  // company
  company_ = [[UITextField alloc] initWithFrame:CGRectMake(60.0f,
                                                           CGRectGetMaxY(phone_.frame),
                                                           textFieldWidth,
                                                           textFieldHeight)];
  company_.delegate = self;
  company_.font = [UIFont fontWithName:@"HelveticaNeue" size:textFieldFontsize];
  company_.textColor = [UIColor blackColor];
  company_.autocorrectionType = UITextAutocorrectionTypeNo;
  company_.autocapitalizationType = UITextAutocapitalizationTypeNone;
  company_.placeholder = [GlobalMethods localizedStringWithKey:@"Company"];
  company_.clipsToBounds = NO;
  [uisv_ addSubview:company_];
  
  UIImageView *companyIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"company"]];
  companyIcon.frame = CGRectMake(20.0f,
                                 CGRectGetMinY(company_.frame) + 10.0f,
                                 emailIcon.image.size.width,
                                 emailIcon.image.size.height);
  [uisv_ addSubview:companyIcon];
  
  companyAsterix_ = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"asterix"]];
  companyAsterix_.center = CGPointMake(CGRectGetWidth(company_.bounds) + 15.0f, CGRectGetMidY(company_.bounds));
  [company_ addSubview:companyAsterix_];
  
  // division line
  UIView *divisionLine6 = [[UIView alloc] initWithFrame:CGRectMake(0.0f,
                                                                   CGRectGetMaxY(company_.frame),
                                                                   CGRectGetWidth(self.view.bounds),
                                                                   1.0f)];
  divisionLine6.backgroundColor = [UIColor colorWithWhite:0.7f alpha:1.0f];
  [uisv_ addSubview:divisionLine6];
  
  // username
  type_ = [[UITextField alloc] initWithFrame:CGRectMake(60.0f,
                                                        CGRectGetMaxY(company_.frame),
                                                        textFieldWidth,
                                                        textFieldHeight)];
  type_.delegate = self;
  type_.font = [UIFont fontWithName:@"HelveticaNeue" size:textFieldFontsize];
  type_.textColor = [UIColor blackColor];
  type_.autocorrectionType = UITextAutocorrectionTypeNo;
  type_.autocapitalizationType = UITextAutocapitalizationTypeNone;
  type_.enabled = YES;
  type_.placeholder = [GlobalMethods localizedStringWithKey:@"Type"];
  type_.clipsToBounds = NO;
  [uisv_ addSubview:type_];
  
  UIImageView *typeIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"job"]];
  typeIcon.frame = CGRectMake(20.0f,
                              CGRectGetMinY(type_.frame) + 10.0f,
                              emailIcon.image.size.width,
                              emailIcon.image.size.height);
  [uisv_ addSubview:typeIcon];
  
  typeAsterix_ = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"asterix"]];
  typeAsterix_.center = CGPointMake(CGRectGetWidth(type_.bounds) + 15.0f, CGRectGetMidY(type_.bounds));
  [type_ addSubview:typeAsterix_];
  
  // division line
  UIView *divisionLine7 = [[UIView alloc] initWithFrame:CGRectMake(0.0f,
                                                                   CGRectGetMaxY(type_.frame),
                                                                   CGRectGetWidth(self.view.bounds),
                                                                   1.0f)];
  divisionLine7.backgroundColor = [UIColor colorWithWhite:0.7f alpha:1.0f];
  [uisv_ addSubview:divisionLine7];
  
  // signup
  UIButton *signup = [[UIButton alloc] initWithFrame:CGRectMake(0.0f,
                                                                CGRectGetMaxY(type_.frame) + 40.0f,
                                                                CGRectGetWidth(self.view.bounds),
                                                                buttonHeight)];
  signup.backgroundColor = [UIColor colorWithRed:0 green:0.68 blue:0.95 alpha:1];
  signup.showsTouchWhenHighlighted = YES;
  [signup setTitle:[GlobalMethods localizedStringWithKey:@"Join"] forState:UIControlStateNormal];
  [signup addTarget:self
             action:@selector(join:)
   forControlEvents:UIControlEventTouchUpInside];
  [uisv_ addSubview:signup];
  
  // signup
  UIButton *signin = [[UIButton alloc] initWithFrame:CGRectMake(0.0f,
                                                                CGRectGetMaxY(signup.frame) + 20.0f,
                                                                CGRectGetWidth(self.view.bounds),
                                                                buttonHeight / 2.0f)];
  signin.showsTouchWhenHighlighted = YES;
  signin.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:12.0f];
  [signin setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
  [signin setTitle:[GlobalMethods localizedStringWithKey:@"Already have an account? Sign In"] forState:UIControlStateNormal];
  [signin addTarget:self
             action:@selector(signin:)
   forControlEvents:UIControlEventTouchUpInside];
  [uisv_ addSubview:signin];
  
  uisv_.contentSize = CGSizeMake(0.0f, CGRectGetMaxY(signin.frame) + 10.0f);
  
  //
  UITapGestureRecognizer *tapper = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                           action:@selector(handleSingleTap:)];
  tapper.cancelsTouchesInView = NO;
  [uisv_ addGestureRecognizer:tapper];
  
  //
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(apiUserSignupSuccessful:)
                                               name:apiUserSignupSuccessfulNotification
                                             object:nil];
  
  [self disactivateAllAsterixes];
}

- (void)handleSingleTap:(UITapGestureRecognizer *) sender
{
  [self.view endEditing:YES];
}

- (void)close:(UIBarButtonItem *)uibbi
{
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)join:(UIButton *)uib
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
  
  NSString *type = @"";
  
  if (![type_.text isEqualToString:@""])
  {
    if ([type_.text isEqualToString:[GlobalMethods localizedStringWithKey:@"Distributor"]])
      type = @"distributor";
    
    if ([type_.text isEqualToString:[GlobalMethods localizedStringWithKey:@"Hotel Owner"]])
      type = @"hotel_owner";
    
    if ([type_.text isEqualToString:[GlobalMethods localizedStringWithKey:@"PCO"]])
      type = @"pco";
  }

  [API createUser:email_.text
         password:password_.text
             name:name_.text
            email:email_.text
            phone:(NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                                        NULL,
                                                                                        (CFStringRef)phone_.text,
                                                                                        NULL,
                                                                                        CFSTR("!*'();:@&=+$,/?%#[]\" "),
                                                                                        kCFStringEncodingUTF8))
          company:company_.text
             role:type];
}

- (void)signin:(UIButton *)uib
{
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)userTypeSelected:(NSString *)userType
{
  type_.text = userType;
}

- (void)disactivateAllAsterixes
{
  emailAsterix_.hidden = YES;
  passwordAsterix_.hidden = YES;
  nameAsterix_.hidden = YES;
  phoneAsterix_.hidden = YES;
  companyAsterix_.hidden = YES;
  typeAsterix_.hidden = YES;
}

- (BOOL)checkAndActivateAsterixesForMissingFields
{
  BOOL flag = NO;
  
  if ([email_.text isEqualToString:@""])
  {
    flag = YES;
    emailAsterix_.hidden = NO;
  }
  else
    emailAsterix_.hidden = YES;
  
  if ([password_.text isEqualToString:@""])
  {
    flag = YES;
    passwordAsterix_.hidden = NO;
  }
  else
    passwordAsterix_.hidden = YES;
  
  if ([name_.text isEqualToString:@""])
  {
    flag = YES;
    nameAsterix_.hidden = NO;
  }
  else
    nameAsterix_.hidden = YES;
  
  if ([phone_.text isEqualToString:@""])
  {
    flag = YES;
    phoneAsterix_.hidden = NO;
  }
  else
    phoneAsterix_.hidden = YES;
  
  if ([company_.text isEqualToString:@""])
  {
    flag = YES;
    companyAsterix_.hidden = NO;
  }
  else
    companyAsterix_.hidden = YES;
  
  if ([type_.text isEqualToString:@""])
  {
    flag = YES;
    typeAsterix_.hidden = NO;
  }
  else
    typeAsterix_.hidden = YES;
  
  return flag;
}

#pragma mark - API notifications callbacks

- (void)apiUserSignupSuccessful:(NSNotification *)notification
{
  NSDictionary *json = (NSDictionary *)notification.object;
  
  [GlobalData saveUsername:email_.text];
  [GlobalData savePassword:password_.text];
  [GlobalData saveAuthorID:json[@"ID"]];
  [GlobalData saveLicenseID:json[@"license"][@"code"]];
  
  [self dismissViewControllerAnimated:YES
                           completion:^{
                             [[NSNotificationCenter defaultCenter] postNotificationName:userHasBeenRegisteredNotification
                                                                                 object:nil];
                           }];
}

#pragma mark - UITextField delegate methods implementation

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
  if (textField == type_)
  {
    UserTypeTableViewController *uttvc = [[UserTypeTableViewController alloc] initWithStyle:UITableViewStylePlain];
    uttvc.delegate = self;
    [self.navigationController pushViewController:uttvc animated:YES];
    
    return NO;
  }
  
  return YES;
}

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