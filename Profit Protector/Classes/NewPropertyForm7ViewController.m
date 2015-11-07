#import "NewPropertyForm7ViewController.h"

@implementation NewPropertyForm7ViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  //
  self.scvA = [[StepperComponentView alloc] initWithFrame:CGRectMake(20.0f,
                                                                     20.0f,
                                                                     CGRectGetWidth(self.view.frame) - 40.0f,
                                                                     140.0f)];
  self.scvA.numericType = Numeric;
  self.scvA.key = @"futureBookingDaysLost";
  self.scvA.title = @"How many future days will you lose based on negative reviews (yelp, TripAdvisor, bed bug registry etc) per Bed Bug incident?";
  self.scvA.value = @(10);
  [self.uisv addSubview:self.scvA];
  
  self.uisv.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame),
                                     CGRectGetMinY(self.scvA.frame) + self.scvA.height + 20.0f);
}

@end