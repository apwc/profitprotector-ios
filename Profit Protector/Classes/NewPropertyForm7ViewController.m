#import "NewPropertyForm7ViewController.h"

@implementation NewPropertyForm7ViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  //
  self.scvA = [[StepperComponentView alloc] initWithFrame:CGRectMake(20.0f,
                                                                     20.0f,
                                                                     CGRectGetWidth(self.view.frame) - 40.0f,
                                                                     215.0f)];
  self.scvA.numericType = Numeric;
  self.scvA.key = @"futureBookingDaysLost";
  self.scvA.url = [NSURL URLWithString:@"http://www.tripadvisor.com/Search?q=bed+bug&geo=60763&pid=3825&typeaheadRedirect=true&redirect=&startTime=1445881004305&uiOrigin=MASTHEAD&returnTo=__2F__"];
  self.scvA.title = NSLocalizedString(@"Form7 Question1", nil);
  self.scvA.value = @(10);
  [self.uisv addSubview:self.scvA];
  
  self.uisv.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame),
                                     CGRectGetMinY(self.scvA.frame) + self.scvA.height + 20.0f);
}

@end