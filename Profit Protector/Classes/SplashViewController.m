#import "SplashViewController.h"
#import "SignupViewController.h"
#import "TutorialViewController.h"
#import "GlobalData.h"
#import "Constants.h"

@interface SplashViewController () <UITextFieldDelegate>
@end

@implementation SplashViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  UIImageView *logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo"]];
  logo.frame = CGRectMake((CGRectGetWidth(self.view.bounds) - logo.image.size.width / 2.0f) / 2.0f,
                          60.0f,
                          logo.image.size.width / 2.0f,
                          logo.image.size.height / 2.0f);
  [self.view addSubview:logo];
  
  UILabel *copy = [[UILabel alloc] initWithFrame:CGRectMake(20.0f,
                                                            CGRectGetMaxY(logo.frame) + 10.0f,
                                                            CGRectGetWidth(self.view.bounds) - 40.0f,
                                                            26.0f)];
  copy.text = @"Profit Protector";
  copy.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:21.0f];
  copy.textAlignment = NSTextAlignmentCenter;
  copy.textColor = [UIColor colorWithRed:0.02 green:0.27 blue:0.52 alpha:1];
  [self.view addSubview:copy];
  
  CGFloat textFieldHeight = 37.0f;
  CGFloat textFieldFontsize = 16.0f;
  CGFloat buttonHeight = 60.0f;
  
  // username
  UITextField *username = [[UITextField alloc] initWithFrame:CGRectMake(60.0f,
                                                                        CGRectGetMaxY(copy.frame) + 20.0f,
                                                                        CGRectGetWidth(self.view.bounds) - 60.0f,
                                                                        textFieldHeight)];
  username.delegate = self;
  username.font = [UIFont fontWithName:@"HelveticaNeue" size:textFieldFontsize];
  username.textColor = [UIColor blackColor];
  username.autocorrectionType = UITextAutocorrectionTypeNo;
  username.autocapitalizationType = UITextAutocapitalizationTypeNone;
  [self.view addSubview:username];
  
  UIImageView *usernameIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"username"]];
  usernameIcon.frame = CGRectMake(20.0f,
                                  CGRectGetMinY(username.frame) + 10.0f,
                                  usernameIcon.image.size.width,
                                  usernameIcon.image.size.height);
  [self.view addSubview:usernameIcon];
  
  // division line
  UIView *divisionLine1 = [[UIView alloc] initWithFrame:CGRectMake(0.0f,
                                                                   CGRectGetMaxY(username.frame),
                                                                   CGRectGetWidth(self.view.bounds),
                                                                   1.0f)];
  divisionLine1.backgroundColor = [UIColor colorWithWhite:0.7f alpha:1.0f];
  [self.view addSubview:divisionLine1];
  
  // username
  UITextField *password = [[UITextField alloc] initWithFrame:CGRectMake(60.0f,
                                                                        CGRectGetMaxY(username.frame),
                                                                        CGRectGetWidth(self.view.bounds) - 60.0f,
                                                                        textFieldHeight)];
  password.delegate = self;
  password.font = [UIFont fontWithName:@"HelveticaNeue" size:textFieldFontsize];
  password.textColor = [UIColor blackColor];
  password.autocorrectionType = UITextAutocorrectionTypeNo;
  password.autocapitalizationType = UITextAutocapitalizationTypeNone;
  password.secureTextEntry = YES;
  [self.view addSubview:password];
  
  UIImageView *passwordIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"password"]];
  passwordIcon.frame = CGRectMake(20.0f,
                                  CGRectGetMinY(password.frame) + 10.0f,
                                  usernameIcon.image.size.width,
                                  usernameIcon.image.size.height);
  [self.view addSubview:passwordIcon];
  
  // division line
  UIView *divisionLine2 = [[UIView alloc] initWithFrame:CGRectMake(0.0f,
                                                                   CGRectGetMaxY(password.frame),
                                                                   CGRectGetWidth(self.view.bounds),
                                                                   1.0f)];
  divisionLine2.backgroundColor = [UIColor colorWithWhite:0.7f alpha:1.0f];
  [self.view addSubview:divisionLine2];
  
  // signup
  UIButton *forgotPassword = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.bounds) / 2.0f,
                                                                        CGRectGetMaxY(password.frame),
                                                                        CGRectGetWidth(self.view.bounds) / 2.0f,
                                                                        buttonHeight / 2.0f)];
  forgotPassword.showsTouchWhenHighlighted = YES;
  forgotPassword.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:12.0f];
  [forgotPassword setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
  [forgotPassword setTitle:@"Forgot Password" forState:UIControlStateNormal];
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
  [signin setTitle:@"Sign In" forState:UIControlStateNormal];
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
  [signup setTitle:@"Don't have an account? Sign Up" forState:UIControlStateNormal];
  [signup addTarget:self
             action:@selector(signup:)
   forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:signup];
  
  //
  UITapGestureRecognizer *tapper = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                           action:@selector(handleSingleTap:)];
  tapper.cancelsTouchesInView = NO;
  [self.view addGestureRecognizer:tapper];
}

- (void)handleSingleTap:(UITapGestureRecognizer *) sender
{
  [self.view endEditing:YES];
}

- (void)forgotPassword:(UIButton *)uib
{
}

- (void)signin:(UIButton *)uib
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

- (void)signup:(UIButton *)uib
{
  SignupViewController *svc = [[SignupViewController alloc] initWithNibName:nil
                                                                     bundle:nil];
  [self presentViewController:svc animated:YES completion:nil];
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