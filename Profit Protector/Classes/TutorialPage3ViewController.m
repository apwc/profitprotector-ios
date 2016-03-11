#import "TutorialPage3ViewController.h"
#import "GlobalMethods.h"

@implementation TutorialPage3ViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  UIImageView *calendar = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[GlobalMethods isTheChineseVersion] ? @"walkthroughPage2_ch" : @"walkthroughPage3"]];
  calendar.center = CGPointMake(CGRectGetWidth(self.view.bounds) / 2.0f, 200.0f);
  [self.view addSubview:calendar];
  
  UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10.0f,
                                                             CGRectGetHeight(self.view.bounds) - 150.0f,
                                                             CGRectGetWidth(self.view.bounds) - 20.0f,
                                                             100.0f)];
  label.autoresizingMask = (UIViewAutoresizingFlexibleTopMargin |
                            UIViewAutoresizingFlexibleBottomMargin);
  label.textColor = [UIColor whiteColor];
  label.textAlignment = NSTextAlignmentCenter;
  label.numberOfLines = 0;
  label.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:14.0f];
  label.text = @"Review the “Loses” and “Savings”\nreports by clicking on a property within\nthe Property List.";
  [self.view addSubview:label];
}

@end