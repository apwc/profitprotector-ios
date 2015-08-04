#import "SignupViewController.h"
#import "API.h"
#import "GlobalData.h"
#import "UserTypeTableViewController.h"

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
}
@end

@implementation SignupViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Close"
                                                                           style:UIBarButtonItemStylePlain
                                                                          target:self
                                                                          action:@selector(close:)];
  
  uisv_ = [[UIScrollView alloc] initWithFrame:self.view.bounds];
  uisv_.autoresizingMask = (UIViewAutoresizingFlexibleWidth |
                            UIViewAutoresizingFlexibleHeight);
  [self.view addSubview:uisv_];
  
  UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(15.0f,
                                                             74.0f,
                                                             CGRectGetWidth(self.view.frame) - 15.0f,
                                                             48.0f)];
  title.text = @"Sign Up";
  title.font = [UIFont fontWithName:@"HelveticaNeue" size:26.0f];
  title.textColor = [UIColor darkGrayColor];
  [uisv_ addSubview:title];
  
  CGFloat textFieldHeight = 37.0f;
  CGFloat textFieldFontsize = 16.0f;
  CGFloat buttonHeight = 60.0f;
  
  // username
  username_ = [[UITextField alloc] initWithFrame:CGRectMake(60.0f,
                                                            CGRectGetMaxY(title.frame),
                                                            CGRectGetWidth(self.view.bounds) - 60.0f,
                                                            textFieldHeight)];
  username_.delegate = self;
  username_.font = [UIFont fontWithName:@"HelveticaNeue" size:textFieldFontsize];
  username_.textColor = [UIColor blackColor];
  username_.autocorrectionType = UITextAutocorrectionTypeNo;
  username_.autocapitalizationType = UITextAutocapitalizationTypeNone;
  [uisv_ addSubview:username_];
  
  UIImageView *usernameIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"username"]];
  usernameIcon.frame = CGRectMake(20.0f,
                                  CGRectGetMinY(username_.frame) + 10.0f,
                                  usernameIcon.image.size.width,
                                  usernameIcon.image.size.height);
  [uisv_ addSubview:usernameIcon];
  
  // division line
  UIView *divisionLine1 = [[UIView alloc] initWithFrame:CGRectMake(0.0f,
                                                                   CGRectGetMaxY(username_.frame),
                                                                   CGRectGetWidth(self.view.bounds),
                                                                   1.0f)];
  divisionLine1.backgroundColor = [UIColor colorWithWhite:0.7f alpha:1.0f];
  [uisv_ addSubview:divisionLine1];
  
  // password
  password_ = [[UITextField alloc] initWithFrame:CGRectMake(60.0f,
                                                            CGRectGetMaxY(username_.frame),
                                                            CGRectGetWidth(self.view.bounds) - 60.0f,
                                                            textFieldHeight)];
  password_.delegate = self;
  password_.font = [UIFont fontWithName:@"HelveticaNeue" size:textFieldFontsize];
  password_.textColor = [UIColor blackColor];
  password_.autocorrectionType = UITextAutocorrectionTypeNo;
  password_.autocapitalizationType = UITextAutocapitalizationTypeNone;
  password_.secureTextEntry = YES;
  [uisv_ addSubview:password_];
  
  UIImageView *passwordIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"password"]];
  passwordIcon.frame = CGRectMake(20.0f,
                                  CGRectGetMinY(password_.frame) + 10.0f,
                                  usernameIcon.image.size.width,
                                  usernameIcon.image.size.height);
  [uisv_ addSubview:passwordIcon];
  
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
                                                        CGRectGetWidth(self.view.bounds) - 60.0f,
                                                        textFieldHeight)];
  name_.delegate = self;
  name_.font = [UIFont fontWithName:@"HelveticaNeue" size:textFieldFontsize];
  name_.textColor = [UIColor blackColor];
  name_.autocorrectionType = UITextAutocorrectionTypeNo;
  name_.autocapitalizationType = UITextAutocapitalizationTypeNone;
  [uisv_ addSubview:name_];
  
  UIImageView *nameIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"username"]];
  nameIcon.frame = CGRectMake(20.0f,
                              CGRectGetMinY(name_.frame) + 10.0f,
                              usernameIcon.image.size.width,
                              usernameIcon.image.size.height);
  [uisv_ addSubview:nameIcon];
  
  // division line
  UIView *divisionLine3 = [[UIView alloc] initWithFrame:CGRectMake(0.0f,
                                                                   CGRectGetMaxY(name_.frame),
                                                                   CGRectGetWidth(self.view.bounds),
                                                                   1.0f)];
  divisionLine3.backgroundColor = [UIColor colorWithWhite:0.7f alpha:1.0f];
  [uisv_ addSubview:divisionLine3];

  // email
  email_ = [[UITextField alloc] initWithFrame:CGRectMake(60.0f,
                                                         CGRectGetMaxY(name_.frame),
                                                         CGRectGetWidth(self.view.bounds) - 60.0f,
                                                         textFieldHeight)];
  email_.delegate = self;
  email_.font = [UIFont fontWithName:@"HelveticaNeue" size:textFieldFontsize];
  email_.textColor = [UIColor blackColor];
  email_.autocorrectionType = UITextAutocorrectionTypeNo;
  email_.autocapitalizationType = UITextAutocapitalizationTypeNone;
  [uisv_ addSubview:email_];
  
  UIImageView *emailIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"email"]];
  emailIcon.frame = CGRectMake(20.0f,
                               CGRectGetMinY(email_.frame) + 10.0f,
                               usernameIcon.image.size.width,
                               usernameIcon.image.size.height);
  [uisv_ addSubview:emailIcon];
  
  // division line
  UIView *divisionLine4 = [[UIView alloc] initWithFrame:CGRectMake(0.0f,
                                                                   CGRectGetMaxY(email_.frame),
                                                                   CGRectGetWidth(self.view.bounds),
                                                                   1.0f)];
  divisionLine4.backgroundColor = [UIColor colorWithWhite:0.7f alpha:1.0f];
  [uisv_ addSubview:divisionLine4];
  
  // phone
  phone_ = [[UITextField alloc] initWithFrame:CGRectMake(60.0f,
                                                         CGRectGetMaxY(email_.frame),
                                                         CGRectGetWidth(self.view.bounds) - 60.0f,
                                                         textFieldHeight)];
  phone_.delegate = self;
  phone_.font = [UIFont fontWithName:@"HelveticaNeue" size:textFieldFontsize];
  phone_.textColor = [UIColor blackColor];
  phone_.autocorrectionType = UITextAutocorrectionTypeNo;
  phone_.autocapitalizationType = UITextAutocapitalizationTypeNone;
  [uisv_ addSubview:phone_];
  
  UIImageView *phoneIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"phone"]];
  phoneIcon.frame = CGRectMake(20.0f,
                               CGRectGetMinY(phone_.frame) + 10.0f,
                               phoneIcon.image.size.width,
                               phoneIcon.image.size.height);
  [uisv_ addSubview:phoneIcon];
  
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
                                                           CGRectGetWidth(self.view.bounds) - 60.0f,
                                                           textFieldHeight)];
  company_.delegate = self;
  company_.font = [UIFont fontWithName:@"HelveticaNeue" size:textFieldFontsize];
  company_.textColor = [UIColor blackColor];
  company_.autocorrectionType = UITextAutocorrectionTypeNo;
  company_.autocapitalizationType = UITextAutocapitalizationTypeNone;
  [uisv_ addSubview:company_];
  
  UIImageView *companyIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"company"]];
  companyIcon.frame = CGRectMake(20.0f,
                                 CGRectGetMinY(company_.frame) + 10.0f,
                                 usernameIcon.image.size.width,
                                 usernameIcon.image.size.height);
  [uisv_ addSubview:companyIcon];
  
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
                                                        CGRectGetWidth(self.view.bounds) - 60.0f,
                                                        textFieldHeight)];
  type_.delegate = self;
  type_.font = [UIFont fontWithName:@"HelveticaNeue" size:textFieldFontsize];
  type_.textColor = [UIColor blackColor];
  type_.autocorrectionType = UITextAutocorrectionTypeNo;
  type_.autocapitalizationType = UITextAutocapitalizationTypeNone;
  type_.enabled = YES;
  [uisv_ addSubview:type_];
  
  // division line
  UIView *divisionLine7 = [[UIView alloc] initWithFrame:CGRectMake(0.0f,
                                                                   CGRectGetMaxY(type_.frame),
                                                                   CGRectGetWidth(self.view.bounds),
                                                                   1.0f)];
  divisionLine7.backgroundColor = [UIColor colorWithWhite:0.7f alpha:1.0f];
  [uisv_ addSubview:divisionLine7];
  
  // signup
  UIButton *signup = [[UIButton alloc] initWithFrame:CGRectMake(0.0f,
                                                                CGRectGetMaxY(type_.frame) + 40.0f,//CGRectGetHeight(self.view.bounds) - (buttonHeight * 2.0f) - 10.0f,
                                                                CGRectGetWidth(self.view.bounds),
                                                                buttonHeight)];
  signup.backgroundColor = [UIColor colorWithRed:0 green:0.68 blue:0.95 alpha:1];
  signup.showsTouchWhenHighlighted = YES;
  [signup setTitle:@"Join" forState:UIControlStateNormal];
  [signup addTarget:self
             action:@selector(join:)
   forControlEvents:UIControlEventTouchUpInside];
  [uisv_ addSubview:signup];
  
  // signup
  UIButton *signin = [[UIButton alloc] initWithFrame:CGRectMake(0.0f,
                                                                CGRectGetMaxY(signup.frame) + 20.0f,//CGRectGetHeight(self.view.bounds) - (buttonHeight / 2.0f) - 15.0f,
                                                                CGRectGetWidth(self.view.bounds),
                                                                buttonHeight / 2.0f)];
  signin.showsTouchWhenHighlighted = YES;
  signin.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:12.0f];
  [signin setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
  [signin setTitle:@"Already have an account? Sign In" forState:UIControlStateNormal];
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
  
  // register the UIKeyboard notifications
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(keyboardWillShow:)
                                               name:UIKeyboardWillShowNotification
                                             object:nil];
  
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(keyboardWillHide:)
                                               name:UIKeyboardWillHideNotification
                                             object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
  [super viewWillDisappear:animated];
  
  // register the UIKeyboard notifications
  [[NSNotificationCenter defaultCenter] removeObserver:self
                                                  name:UIKeyboardWillShowNotification
                                                object:nil];
  
  [[NSNotificationCenter defaultCenter] removeObserver:self
                                                  name:UIKeyboardWillHideNotification
                                                object:nil];
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
  [API createUser:username_.text
         password:password_.text
             name:name_.text
            email:email_.text
             role:type_.text];
}

- (void)signin:(UIButton *)uib
{
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)userTypeSelected:(NSString *)userType
{
  type_.text = userType;
}

#pragma mark - API notifications callbacks

- (void)apiUserSignupSuccessful:(NSNotification *)notification
{
  [GlobalData saveUsername:username_.text];
  [GlobalData savePassword:password_.text];
  
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

#pragma mark - UIKeyboard delegate methods implementation

- (void)keyboardWillShow:(NSNotification *)notification
{
  NSDictionary *info = [notification userInfo];
  
  CGSize keyboardSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
  
  uisv_.contentInset = UIEdgeInsetsMake(0.0f,
                                        0.0f,
                                        keyboardSize.height,
                                        0.0f);
}

- (void)keyboardWillHide:(NSNotification *)notification
{
  uisv_.contentInset = UIEdgeInsetsZero;
}

@end