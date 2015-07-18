#import "NewPropertyForm3ViewController.h"

@implementation NewPropertyForm3ViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  //
  StepperComponentView *scvA = [[StepperComponentView alloc] initWithFrame:CGRectMake(20.0f,
                                                                                      20.0f,
                                                                                      CGRectGetWidth(self.view.frame) - 40.0f,
                                                                                      100.0f)];
  scvA.numericType = Currency;
  scvA.title = @"What is your average\nroom revenue per night?";
  [self.uisv addSubview:scvA];
  
  //
  StepperComponentView *scvB = [[StepperComponentView alloc] initWithFrame:CGRectMake(20.0f,
                                                                                      CGRectGetMaxY(scvA.frame) + 20.0f,
                                                                                      CGRectGetWidth(self.view.frame) - 40.0f,
                                                                                      100.0f)];
  scvB.numericType = Currency;
  scvB.title = @"What is your average food and beverage\nsales per room per night?";
  [self.uisv addSubview:scvB];
  
  //
  StepperComponentView *scvC = [[StepperComponentView alloc] initWithFrame:CGRectMake(20.0f,
                                                                                      CGRectGetMaxY(scvB.frame) + 20.0f,
                                                                                      CGRectGetWidth(self.view.frame) - 40.0f,
                                                                                      100.0f)];
  scvC.numericType = Currency;
  scvC.title = @"What is your total ancillaries revenues\nper room per night?";
  [self.uisv addSubview:scvC];
  
  self.uisv.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame),
                                     CGRectGetMaxY(scvC.frame) + 20.0f);
}

@end