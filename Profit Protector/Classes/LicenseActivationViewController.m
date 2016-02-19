#import "LicenseActivationViewController.h"
#import "GlobalMethods.h"

@implementation LicenseActivationViewController

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
  
  UITextField *serial = [[UITextField alloc] initWithFrame:CGRectMake(20.0f,
                                                                      CGRectGetMaxY(label.frame) + 10.0f,
                                                                      CGRectGetWidth(self.view.frame) - 40.0f,
                                                                      37.0f)];
  serial.backgroundColor = [UIColor whiteColor];
  serial.font = [UIFont fontWithName:@"HelveticaNeue" size:21.0f];
  serial.textColor = [UIColor darkTextColor];
  [self.view addSubview:serial];
  
  UIButton *cancel = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMinX(serial.frame),
                                                                CGRectGetMaxY(serial.frame) + 40.0f,
                                                                (CGRectGetWidth(serial.frame) / 2.0f) - 10.0f,
                                                                37.0f)];
  cancel.backgroundColor = [UIColor colorWithWhite:0.5f alpha:1.0f];
  cancel.showsTouchWhenHighlighted = YES;
  [cancel setTintColor:[UIColor whiteColor]];
  [cancel setTitle:@"CANCEL" forState:UIControlStateNormal];
  [cancel addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:cancel];
  
  UIButton *submit = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(serial.frame) - CGRectGetWidth(cancel.frame),
                                                                CGRectGetMinY(cancel.frame),
                                                                CGRectGetWidth(cancel.frame),
                                                                37.0f)];
  submit.backgroundColor = [UIColor colorWithWhite:0.5f alpha:1.0f];
  submit.showsTouchWhenHighlighted = YES;
  [submit setTintColor:[UIColor whiteColor]];
  [submit setTitle:@"SUBMIT" forState:UIControlStateNormal];
  [self.view addSubview:submit];
}

- (void)cancel:(id)sender
{
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)submit:(id)sender
{
  
}

@end