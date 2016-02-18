#import "PendingApprovalViewController.h"

@interface PendingApprovalViewController ()
@end

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
  label.text = @"Thank you for your interest in the CleanRest ROI Profit Protector App. We will reach out to you shortly with an activation link.";
  [self.view addSubview:label];
}

@end