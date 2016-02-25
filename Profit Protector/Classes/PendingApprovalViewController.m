#import "PendingApprovalViewController.h"
#import "GlobalMethods.h"

@implementation PendingApprovalViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  self.view.backgroundColor = [UIColor colorWithRed:0.22f green:0.58f blue:0.82f alpha:1.0f];
  
  UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 0.0f, CGRectGetWidth(self.view.frame) - 20.0f, CGRectGetHeight(self.view.frame))];
  label.numberOfLines = 0;
  label.textColor = [UIColor whiteColor];
  label.textAlignment = NSTextAlignmentCenter;
  label.font = [UIFont fontWithName:@"HelveticaNeue" size:21.0f];
  label.text = [GlobalMethods localizedStringWithKey:@"Pending Approval"];
  [self.view addSubview:label];
  
  UIButton *close = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.view.frame) - 50.0f,
                                                               CGRectGetHeight(label.frame) - 120.0f,
                                                               100.0f,
                                                               37.0f)];
  close.showsTouchWhenHighlighted = YES;
  close.titleLabel.font = [UIFont boldSystemFontOfSize:21.0f];
  [close setTitle:@"CLOSE" forState:UIControlStateNormal];
  [close addTarget:self action:@selector(close:) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:close];
}

- (void)close:(id)sender
{
  [self dismissViewControllerAnimated:YES completion:nil];
}

@end