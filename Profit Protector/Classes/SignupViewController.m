#import "SignupViewController.h"

@interface SignupViewController () <UITextFieldDelegate>
@end

@implementation SignupViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  UIToolbar *uit = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0f,
                                                               0.0f,
                                                               CGRectGetWidth(self.view.frame),
                                                               64.0f)];
  uit.items = @[[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                              target:nil
                                                              action:nil],
                [[UIBarButtonItem alloc] initWithTitle:@"Close"
                                                 style:UIBarButtonItemStylePlain
                                                target:self
                                                action:@selector(close:)]];
  [self.view addSubview:uit];
  
  
  UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(15.0f,
                                                             74.0f,
                                                             CGRectGetWidth(self.view.frame) - 15.0f,
                                                             48.0f)];
  title.text = @"Sign Up";
  title.font = [UIFont fontWithName:@"HelveticaNeue" size:26.0f];
  title.textColor = [UIColor darkGrayColor];
  [self.view addSubview:title];
  
  CGFloat textFieldHeight = 37.0f;
  CGFloat textFieldFontsize = 16.0f;
  CGFloat buttonHeight = 60.0f;
  
  // username
  UITextField *username = [[UITextField alloc] initWithFrame:CGRectMake(60.0f,
                                                                        290.0f,
                                                                        CGRectGetWidth(self.view.bounds) - 60.0f,
                                                                        textFieldHeight)];
  username.delegate = self;
  username.font = [UIFont fontWithName:@"HelveticaNeue" size:textFieldFontsize];
  username.textColor = [UIColor blackColor];
  username.placeholder = @"<username>";
  username.autocorrectionType = UITextAutocorrectionTypeNo;
  username.autocapitalizationType = UITextAutocapitalizationTypeNone;
  [self.view addSubview:username];
  
  // division line
  UIView *divisionLine1 = [[UIView alloc] initWithFrame:CGRectMake(0.0f,
                                                                   290.0f + textFieldHeight,
                                                                   CGRectGetWidth(self.view.bounds),
                                                                   1.0f)];
  divisionLine1.backgroundColor = [UIColor colorWithWhite:0.7f alpha:1.0f];
  [self.view addSubview:divisionLine1];
  
  // signup
  UIButton *signup = [[UIButton alloc] initWithFrame:CGRectMake(0.0f,
                                                                CGRectGetHeight(self.view.bounds) - (buttonHeight * 2.0f) - 10.0f,
                                                                CGRectGetWidth(self.view.bounds),
                                                                buttonHeight)];
  signup.backgroundColor = [UIColor colorWithRed:0 green:0.68 blue:0.95 alpha:1];
  signup.showsTouchWhenHighlighted = YES;
  [signup setTitle:@"Join" forState:UIControlStateNormal];
  [signup addTarget:self
             action:@selector(join:)
   forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:signup];
  
  // signup
  UIButton *signin = [[UIButton alloc] initWithFrame:CGRectMake(0.0f,
                                                                CGRectGetHeight(self.view.bounds) - (buttonHeight / 2.0f) - 15.0f,
                                                                CGRectGetWidth(self.view.bounds),
                                                                buttonHeight / 2.0f)];
  signin.showsTouchWhenHighlighted = YES;
  signin.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:12.0f];
  [signin setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
  [signin setTitle:@"Already have an account? Sign In" forState:UIControlStateNormal];
  [signin addTarget:self
             action:@selector(signin:)
   forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:signin];
}

- (void)close:(UIBarButtonItem *)uibbi
{
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)join:(UIButton *)uib
{
  
}

- (void)signin:(UIButton *)uib
{
  [self dismissViewControllerAnimated:YES completion:nil];
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