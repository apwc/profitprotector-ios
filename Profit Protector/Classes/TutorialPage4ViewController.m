#import "TutorialPage4ViewController.h"

@implementation TutorialPage4ViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  UIImageView *calendar = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"calendar"]];
  calendar.center = CGPointMake(CGRectGetWidth(self.view.bounds) / 2.0f, 150.0f);
  [self.view addSubview:calendar];
  
  UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10.0f,
                                                             300.0f,
                                                             CGRectGetWidth(self.view.bounds) - 20.0f,
                                                             100.0f)];
  label.textAlignment = NSTextAlignmentCenter;
  label.numberOfLines = 0;
  label.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:14.0f];
  label.text = @"Share the savings report with your contacts.";
  [self.view addSubview:label];
}

@end