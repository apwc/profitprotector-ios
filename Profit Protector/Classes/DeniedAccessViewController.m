#import "DeniedAccessViewController.h"
#import "GlobalMethods.h"

@implementation DeniedAccessViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  self.view.backgroundColor = [UIColor colorWithRed:0.742 green:0.213 blue:0.074 alpha:1.000];
  
  UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 0.0f, CGRectGetWidth(self.view.frame) - 20.0f, CGRectGetHeight(self.view.frame))];
  label.numberOfLines = 0;
  label.textColor = [UIColor whiteColor];
  label.textAlignment = NSTextAlignmentCenter;
  label.font = [UIFont fontWithName:@"HelveticaNeue" size:21.0f];
  label.text = [GlobalMethods localizedStringWithKey:@"Denied Access"];
  [self.view addSubview:label];
  
  UIButton *close = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.view.frame) - 50.0f,
                                                               CGRectGetHeight(label.frame) - 80.0f,
                                                               100.0f,
                                                               37.0f)];
  close.showsTouchWhenHighlighted = YES;
  close.titleLabel.font = [UIFont boldSystemFontOfSize:21.0f];
  [close setTitle:@"CLOSE" forState:UIControlStateNormal];
  [close addTarget:self action:@selector(close:) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:close];
  
  UIButton *support = [[UIButton alloc] initWithFrame:CGRectMake(0.0f,
                                                                 CGRectGetMinY(close.frame) - 100.0f,
                                                                 CGRectGetWidth(self.view.bounds),
                                                                 37.0f)];
  support.showsTouchWhenHighlighted = YES;
  support.titleLabel.font = [UIFont systemFontOfSize:18.0f];
  [support setTitle:@"Contact Support Center" forState:UIControlStateNormal];
  [support addTarget:self action:@selector(support:) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:support];
}

- (void)close:(id)sender
{
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)support:(id)sender
{
}

@end