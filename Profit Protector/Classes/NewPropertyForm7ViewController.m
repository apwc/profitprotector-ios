#import "NewPropertyForm7ViewController.h"

@implementation NewPropertyForm7ViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  //
  self.scvB = [[StepperComponentView alloc] initWithFrame:CGRectMake(20.0f,
                                                                     20.0f,
                                                                     CGRectGetWidth(self.view.frame) - 40.0f,
                                                                     440.0f)];
  self.scvB.numericType = Numeric;
  self.scvB.key = @"futureBookingDaysLost";
  self.scvB.title = @"How many future days will you lose based on negative reviews (yelp, TripAdvisor, bed bug registry etc) per Bed Bug incident?";
  self.scvB.value = @(10);
  [self.uisv addSubview:self.scvB];
  
  //
  self.scvC = [[StepperComponentView alloc] initWithFrame:CGRectMake(20.0f,
                                                                     CGRectGetMinY(self.scvB.frame) + self.scvB.height + 30.0f,
                                                                     CGRectGetWidth(self.view.frame) - 40.0f,
                                                                     120.0f)];
  self.scvC.numericType = Currency;
  self.scvC.key = @"preemptivePestControlRetainer";
  self.scvC.title = @"Monthly Preemptive Pest Control Retainer per 100 rooms";
  self.scvC.value = @(400);
  [self.uisv addSubview:self.scvC];
  
  //
  self.finish = [UIButton buttonWithType:UIButtonTypeCustom];
  self.finish.showsTouchWhenHighlighted = YES;
  self.finish.frame = CGRectMake(20.0f,
                                 CGRectGetMinY(self.scvC.frame) + self.scvC.height + 40.0f,
                                 CGRectGetWidth(self.view.frame) - 40.0f,
                                 96.0f);
  self.finish.backgroundColor = [UIColor colorWithRed:0 green:0.68 blue:0.95 alpha:1];
  self.finish.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:32.0f];
  [self.finish setTitle:@"SAVE & FINISH" forState:UIControlStateNormal];
  [self.finish setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
  [self.uisv addSubview:self.finish];
  
  self.uisv.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame),
                                     CGRectGetMaxY(self.finish.frame) + 30.0f);
}

@end