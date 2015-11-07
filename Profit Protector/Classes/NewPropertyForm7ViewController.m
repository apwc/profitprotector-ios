#import "NewPropertyForm7ViewController.h"

@implementation NewPropertyForm7ViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  //
  self.scvA = [[StepperComponentView alloc] initWithFrame:CGRectMake(20.0f,
                                                                     20.0f,
                                                                     CGRectGetWidth(self.view.frame) - 40.0f,
                                                                     440.0f)];
  self.scvA.numericType = Numeric;
  self.scvA.key = @"futureBookingDaysLost";
  self.scvA.title = @"How many future days will you lose based on negative reviews (yelp, TripAdvisor, bed bug registry etc) per Bed Bug incident?";
  self.scvA.value = @(10);
  [self.uisv addSubview:self.scvA];
  
  //
  self.finish = [UIButton buttonWithType:UIButtonTypeCustom];
  self.finish.showsTouchWhenHighlighted = YES;
  self.finish.frame = CGRectMake(20.0f,
                                 CGRectGetMinY(self.scvA.frame) + self.scvA.height + 40.0f,
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