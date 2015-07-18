#import "NewPropertyForm2ViewController.h"

@implementation NewPropertyForm2ViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  //
  StepperComponentView *scvA = [[StepperComponentView alloc] initWithFrame:CGRectMake(20.0f,
                                                                                      20.0f,
                                                                                      CGRectGetWidth(self.view.frame) - 40.0f,
                                                                                      100.0f)];
  scvA.numericType = Numeric;
  scvA.title = @"How many rooms do you have\nin your property?";
  [self.uisv addSubview:scvA];
  
  //
  StepperComponentView *scvB = [[StepperComponentView alloc] initWithFrame:CGRectMake(20.0f,
                                                                                      CGRectGetMaxY(scvA.frame) + 20.0f,
                                                                                      CGRectGetWidth(self.view.frame) - 40.0f,
                                                                                      100.0f)];
  scvB.numericType = Numeric;
  scvB.title = @"How many beds do you have\nin your property?";
  [self.uisv addSubview:scvB];
  
  self.uisv.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame),
                                     CGRectGetMaxY(scvB.frame) + 20.0f);
}

@end