#import "LicenseActivationViewController.h"
#import "GlobalMethods.h"
#import "Constants.h"
#import "API.h"

@interface LicenseActivationViewController ()
{
  UITextField *serial_;
}
@end

@implementation LicenseActivationViewController

- (void)dealloc
{
  [[NSNotificationCenter defaultCenter] removeObserver:self
                                                  name:apiLicenseActivationErrorNotification
                                                object:nil];
  
  [[NSNotificationCenter defaultCenter] removeObserver:self
                                                  name:apiLicenseActivationSuccessfulNotification
                                                object:nil];
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  self.view.backgroundColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
  
  UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10.0f,
                                                             110.0f,
                                                             CGRectGetWidth(self.view.frame) - 20.0f,
                                                             26.0f)];
  label.textColor = [UIColor darkTextColor];
  label.textAlignment = NSTextAlignmentCenter;
  label.font = [UIFont fontWithName:@"HelveticaNeue" size:19.0f];
  label.text = [GlobalMethods localizedStringWithKey:@"Activation Code"];
  [self.view addSubview:label];
  
  serial_ = [[UITextField alloc] initWithFrame:CGRectMake(20.0f,
                                                          CGRectGetMaxY(label.frame) + 10.0f,
                                                          CGRectGetWidth(self.view.frame) - 40.0f,
                                                          37.0f)];
  serial_.backgroundColor = [UIColor whiteColor];
  serial_.font = [UIFont fontWithName:@"HelveticaNeue" size:21.0f];
  serial_.textColor = [UIColor darkTextColor];
  serial_.autocorrectionType = UITextAutocorrectionTypeNo;
  serial_.autocapitalizationType = UITextAutocapitalizationTypeNone;
  serial_.text = self.code ?: @"";
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
  
  //
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(apiLicenseActivationError:)
                                               name:apiLicenseActivationErrorNotification
                                             object:nil];
  
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(apiLicenseActivationSuccessful:)
                                               name:apiLicenseActivationSuccessfulNotification
                                             object:nil];
}

- (void)cancel:(id)sender
{
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)submit:(id)sender
{
  [API activateLicense:serial_.text];
}

#pragma mark - UI notifications callbacks

- (void)apiLicenseActivationError:(NSNotification *)notification
{
}

- (void)apiLicenseActivationSuccessful:(NSNotification *)notification
{
}

@end