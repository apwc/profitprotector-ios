#import "SignupViewController.h"
#import "API.h"
#import "GlobalData.h"
#import "GlobalMethods.h"
#import "CoreDataStoring.h"

@interface SignupViewController () <UITextFieldDelegate>
{
  UIScrollView *uisv_;
  
  UITextField *firstname_,
              *lastname_,
              *username_,
              *password_,
              *email_,
              *phone_,
              *company_,
              *role_;
  
  UIImageView *emailAsterix_,
              *passwordAsterix_,
              *firstnameAsterix_,
              *lastnameAsterix_,
              *phoneAsterix_,
              *companyAsterix_,
              *roleAsterix_;
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
  
  // firstname
  firstname_ = [[UITextField alloc] initWithFrame:CGRectMake(60.0f,
                                                             CGRectGetMaxY(password_.frame),
                                                             textFieldWidth,
                                                             textFieldHeight)];
  firstname_.delegate = self;
  firstname_.font = [UIFont fontWithName:@"HelveticaNeue" size:textFieldFontsize];
  firstname_.textColor = [UIColor blackColor];
  firstname_.autocorrectionType = UITextAutocorrectionTypeNo;
  firstname_.autocapitalizationType = UITextAutocapitalizationTypeNone;
  firstname_.placeholder = [GlobalMethods localizedStringWithKey:@"First Name"];
  firstname_.clipsToBounds = NO;
  [uisv_ addSubview:firstname_];
  
  UIImageView *firstnameIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"username"]];
  firstnameIcon.frame = CGRectMake(20.0f,
                                   CGRectGetMinY(firstname_.frame) + 10.0f,
                                   emailIcon.image.size.width,
                                   emailIcon.image.size.height);
  [uisv_ addSubview:firstnameIcon];
  
  firstnameAsterix_ = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"asterix"]];
  firstnameAsterix_.center = CGPointMake(CGRectGetWidth(firstname_.bounds) + 15.0f, CGRectGetMidY(firstname_.bounds));
  [firstname_ addSubview:firstnameAsterix_];
  
  // division line
  UIView *divisionLine3 = [[UIView alloc] initWithFrame:CGRectMake(0.0f,
                                                                   CGRectGetMaxY(firstname_.frame),
                                                                   CGRectGetWidth(self.view.bounds),
                                                                   1.0f)];
  divisionLine3.backgroundColor = [UIColor colorWithWhite:0.7f alpha:1.0f];
  [uisv_ addSubview:divisionLine3];

  // lastname
  lastname_ = [[UITextField alloc] initWithFrame:CGRectMake(60.0f,
                                                             CGRectGetMaxY(firstname_.frame),
                                                             textFieldWidth,
                                                             textFieldHeight)];
  lastname_.delegate = self;
  lastname_.font = [UIFont fontWithName:@"HelveticaNeue" size:textFieldFontsize];
  lastname_.textColor = [UIColor blackColor];
  lastname_.autocorrectionType = UITextAutocorrectionTypeNo;
  lastname_.autocapitalizationType = UITextAutocapitalizationTypeNone;
  lastname_.placeholder = [GlobalMethods localizedStringWithKey:@"Last Name"];
  lastname_.clipsToBounds = NO;
  [uisv_ addSubview:lastname_];
  
  UIImageView *lastnameIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"username"]];
  lastnameIcon.frame = CGRectMake(20.0f,
                              CGRectGetMinY(lastname_.frame) + 10.0f,
                              emailIcon.image.size.width,
                              emailIcon.image.size.height);
  [uisv_ addSubview:lastnameIcon];
  
  lastnameAsterix_ = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"asterix"]];
  lastnameAsterix_.center = CGPointMake(CGRectGetWidth(lastname_.bounds) + 15.0f, CGRectGetMidY(lastname_.bounds));
  [lastname_ addSubview:lastnameAsterix_];
  
  // division line
  UIView *divisionLine4 = [[UIView alloc] initWithFrame:CGRectMake(0.0f,
                                                                   CGRectGetMaxY(lastname_.frame),
                                                                   CGRectGetWidth(self.view.bounds),
                                                                   1.0f)];
  divisionLine4.backgroundColor = [UIColor colorWithWhite:0.7f alpha:1.0f];
  [uisv_ addSubview:divisionLine4];
  
  // phone
  phone_ = [[UITextField alloc] initWithFrame:CGRectMake(60.0f,
                                                         CGRectGetMaxY(lastname_.frame),
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
  role_ = [[UITextField alloc] initWithFrame:CGRectMake(60.0f,
                                                        CGRectGetMaxY(company_.frame),
                                                        textFieldWidth,
                                                        textFieldHeight)];
  role_.delegate = self;
  role_.font = [UIFont fontWithName:@"HelveticaNeue" size:textFieldFontsize];
  role_.textColor = [UIColor blackColor];
  role_.autocorrectionType = UITextAutocorrectionTypeNo;
  role_.autocapitalizationType = UITextAutocapitalizationTypeNone;
  role_.enabled = YES;
  role_.placeholder = [GlobalMethods localizedStringWithKey:@"Type"];
  role_.clipsToBounds = NO;
  [uisv_ addSubview:role_];
  
  UIImageView *typeIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"job"]];
  typeIcon.frame = CGRectMake(20.0f,
                              CGRectGetMinY(role_.frame) + 10.0f,
                              emailIcon.image.size.width,
                              emailIcon.image.size.height);
  [uisv_ addSubview:typeIcon];
  
  roleAsterix_ = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"asterix"]];
  roleAsterix_.center = CGPointMake(CGRectGetWidth(role_.bounds) + 15.0f, CGRectGetMidY(role_.bounds));
  [role_ addSubview:roleAsterix_];
  
  // division line
  UIView *divisionLine7 = [[UIView alloc] initWithFrame:CGRectMake(0.0f,
                                                                   CGRectGetMaxY(role_.frame),
                                                                   CGRectGetWidth(self.view.bounds),
                                                                   1.0f)];
  divisionLine7.backgroundColor = [UIColor colorWithWhite:0.7f alpha:1.0f];
  [uisv_ addSubview:divisionLine7];
  
  // signup
  UIButton *signup = [[UIButton alloc] initWithFrame:CGRectMake(0.0f,
                                                                CGRectGetMaxY(role_.frame) + 40.0f,
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
  
  NSString *role = @"";
  
  if (![role_.text isEqualToString:@""])
  {
    if ([role_.text isEqualToString:[GlobalMethods localizedStringWithKey:@"Distributor"]])
      role = @"distributor";
    
    if ([role_.text isEqualToString:[GlobalMethods localizedStringWithKey:@"Hotel Owner"]])
      role = @"hotel_owner";
    
    if ([role_.text isEqualToString:[GlobalMethods localizedStringWithKey:@"PCO"]])
      role = @"pco";
  }
  
  [API createUser:email_.text
         password:password_.text
        firstname:firstname_.text
         lastname:lastname_.text
            email:email_.text
            phone:(NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                                        NULL,
                                                                                        (CFStringRef)phone_.text,
                                                                                        NULL,
                                                                                        CFSTR("!*'();:@&=+$,/?%#[]\" "),
                                                                                        kCFStringEncodingUTF8))
          company:company_.text
             role:role];
}

- (void)signin:(UIButton *)uib
{
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)disactivateAllAsterixes
{
  emailAsterix_.hidden = YES;
  passwordAsterix_.hidden = YES;
  firstnameAsterix_.hidden = YES;
  lastnameAsterix_.hidden = YES;
  phoneAsterix_.hidden = YES;
  companyAsterix_.hidden = YES;
  roleAsterix_.hidden = YES;
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
  
  if ([firstname_.text isEqualToString:@""])
  {
    flag = YES;
    firstnameAsterix_.hidden = NO;
  }
  else
    firstnameAsterix_.hidden = YES;
  
  if ([lastname_.text isEqualToString:@""])
  {
    flag = YES;
    lastnameAsterix_.hidden = NO;
  }
  else
    lastnameAsterix_.hidden = YES;
  
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
  
  if ([role_.text isEqualToString:@""])
  {
    flag = YES;
    roleAsterix_.hidden = NO;
  }
  else
    roleAsterix_.hidden = YES;
  
  return flag;
}

#pragma mark - API notifications callbacks

- (void)apiUserSignupSuccessful:(NSNotification *)notification
{
  NSDictionary *json = (NSDictionary *)notification.object;
  
  //
  [GlobalData saveUsername:email_.text];
  [GlobalData savePassword:password_.text];
  [GlobalData saveAuthorID:json[@"ID"]];
  [GlobalData saveLicenseID:json[@"license"][@"code"]];
  
  //
  [CoreDataStoring storeUser:@{@"company": company_.text,
                               @"email": email_.text,
                               @"password": password_.text,
                               @"authorID": json[@"ID"],
                               @"licenseID": json[@"license"][@"code"],
                               @"firstname": firstname_.text,
                               @"lastname": lastname_.text,
                               @"phone": (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                                                               NULL,
                                                                                                               (CFStringRef)phone_.text,
                                                                                                               NULL,
                                                                                                               CFSTR("!*'();:@&=+$,/?%#[]\" "),
                                                                                                               kCFStringEncodingUTF8)),
                               @"role": role_.text}];
  
  //
  [self dismissViewControllerAnimated:YES
                           completion:^{
                             [[NSNotificationCenter defaultCenter] postNotificationName:userHasBeenRegisteredNotification
                                                                                 object:nil];
                           }];
}

#pragma mark - UITextField delegate methods implementation

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
  if (textField == role_)
  {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil
                                                                   message:nil
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *english = [UIAlertAction actionWithTitle:@"Distributor"
                                                      style:UIAlertActionStyleDefault
                                                    handler:^(UIAlertAction *action) {
                                                      role_.text = @"Distributor";
                                                    }];
    
    [alert addAction:english];
    
    UIAlertAction *french = [UIAlertAction actionWithTitle:@"Hotel Owner"
                                                     style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction *action) {
                                                     role_.text = @"Hotel Owner";
                                                   }];
    
    [alert addAction:french];
    
    UIAlertAction *mandarin = [UIAlertAction actionWithTitle:@"PCO"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction *action) {
                                                       role_.text = @"PCO";
                                                     }];
    
    [alert addAction:mandarin];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:[GlobalMethods localizedStringWithKey:@"Cancel"]
                                                     style:UIAlertActionStyleDestructive
                                                   handler:nil];
    
    [alert addAction:cancel];
    
    [self presentViewController:alert animated:YES completion:nil];
    
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