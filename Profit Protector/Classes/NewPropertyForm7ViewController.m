#import "NewPropertyForm7ViewController.h"

@implementation NewPropertyForm7ViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  //
  self.scvA = [[StepperComponentView alloc] initWithFrame:CGRectMake(20.0f,
                                                                     20.0f,
                                                                     CGRectGetWidth(self.view.frame) - 40.0f,
                                                                     100.0f)];
  self.scvA.numericType = Currency;
  self.scvA.key = @"bugInspectionAndPestControlFees";
  self.scvA.title = @"What are your monthly bed bug inspection  & pest control fees";
  [self.uisv addSubview:self.scvA];
  
  //
  self.scvB = [[StepperComponentView alloc] initWithFrame:CGRectMake(20.0f,
                                                                     CGRectGetMaxY(self.scvA.frame) + 20.0f,
                                                                     CGRectGetWidth(self.view.frame) - 40.0f,
                                                                     100.0f)];
  self.scvB.numericType = Numeric;
  self.scvB.key = @"futureBookingDaysLost";
  self.scvB.title = @"What is your assumed future booking days\nlost from social media response to infestation?";
  [self.uisv addSubview:self.scvB];
}

@end