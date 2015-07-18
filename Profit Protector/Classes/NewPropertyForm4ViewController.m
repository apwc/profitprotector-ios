#import "NewPropertyForm4ViewController.h"

@implementation NewPropertyForm4ViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  //
  StepperComponentView *scvA = [[StepperComponentView alloc] initWithFrame:CGRectMake(20.0f,
                                                                                      20.0f,
                                                                                      CGRectGetWidth(self.view.frame) - 40.0f,
                                                                                      100.0f)];
  scvA.numericType = Currency;
  scvA.title = @"What does your typical mattress and\nbox spring cost to replace?";
  [self.uisv addSubview:scvA];
  
  //
  StepperComponentView *scvB = [[StepperComponentView alloc] initWithFrame:CGRectMake(20.0f,
                                                                                      CGRectGetMaxY(scvA.frame) + 20.0f,
                                                                                      CGRectGetWidth(self.view.frame) - 40.0f,
                                                                                      100.0f)];
  scvB.numericType = Currency;
  scvB.title = @"What does your typical cost to replace other\nfurnishings after a bed bug infestation?";
  [self.uisv addSubview:scvB];
  
  self.uisv.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame),
                                     CGRectGetMaxY(scvB.frame) + 20.0f);
}

@end