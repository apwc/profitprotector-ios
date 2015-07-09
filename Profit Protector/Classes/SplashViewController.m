#import "SplashViewController.h"

@interface SplashViewController () <UITextFieldDelegate>
@end

@implementation SplashViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  // UI customizations
  self.view.backgroundColor = [UIColor lightGrayColor];
  
  UIImageView *logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo"]];
  logo.center = CGPointMake(CGRectGetWidth(self.view.bounds) / 2.0f, 150.0f);
  [self.view addSubview:logo];
  
  UILabel *copy = [[UILabel alloc] initWithFrame:CGRectMake(20.0f,
                                                            240.0f,
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
  UITextField *username = [[UITextField alloc] initWithFrame:CGRectMake(0.0f,
                                                                        290.0f,
                                                                        CGRectGetWidth(self.view.bounds),
                                                                        textFieldHeight)];
  username.delegate = self;
  username.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:textFieldFontsize];
  username.textColor = [UIColor blackColor];
  username.backgroundColor = [UIColor colorWithWhite:0.6f alpha:1.0f];
  username.placeholder = @"<username>";
  username.autocorrectionType = UITextAutocorrectionTypeNo;
  username.autocapitalizationType = UITextAutocapitalizationTypeNone;
  [self.view addSubview:username];
  
  // username
  UITextField *password = [[UITextField alloc] initWithFrame:CGRectMake(0.0f,
                                                                        330.0f,
                                                                        CGRectGetWidth(self.view.bounds),
                                                                        textFieldHeight)];
  password.delegate = self;
  password.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:textFieldFontsize];
  password.textColor = [UIColor blackColor];
  password.backgroundColor = [UIColor colorWithWhite:0.6f alpha:1.0f];
  password.placeholder = @"<password>";
  password.autocorrectionType = UITextAutocorrectionTypeNo;
  password.autocapitalizationType = UITextAutocapitalizationTypeNone;
  password.secureTextEntry = YES;
  [self.view addSubview:password];
  
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
}

- (void)signin:(UIButton *)uib
{
}

@end