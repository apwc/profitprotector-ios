#import "TutorialPage2ViewController.h"

@implementation TutorialPage2ViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  UIImageView *calendar = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"walkthroughPage2"]];
  calendar.center = CGPointMake(CGRectGetWidth(self.view.bounds) / 2.0f, 170.0f);
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
  label.text = @"Use the “Create A Property” survey\nto build a profile for an unlimited number\nof hotels, motels, or other establishment.";
  [self.view addSubview:label];
}

@end