#import "DeniedAccessViewController.h"

@interface DeniedAccessViewController ()
@end

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
  label.text = @"Thank you for your interest in the CleanRest ROI Profit Protector App. Unfortunately your account was denied access.";
  [self.view addSubview:label];
}

@end