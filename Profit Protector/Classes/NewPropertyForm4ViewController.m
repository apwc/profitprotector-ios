#import "NewPropertyForm4ViewController.h"

@implementation NewPropertyForm4ViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  //
  self.scvA = [[StepperComponentView alloc] initWithFrame:CGRectMake(20.0f,
                                                                     20.0f,
                                                                     CGRectGetWidth(self.view.frame) - 40.0f,
                                                                     100.0f)];
  self.scvA.numericType = Currency;
  self.scvA.key = @"costOfReplaceMattressesAndBoxSpring";
  self.scvA.title = @"What does your typical mattress and\nbox spring cost to replace?";
  [self.uisv addSubview:self.scvA];
  
  //
  self.scvB = [[StepperComponentView alloc] initWithFrame:CGRectMake(20.0f,
                                                                     CGRectGetMaxY(self.scvA.frame) + 20.0f,
                                                                     CGRectGetWidth(self.view.frame) - 40.0f,
                                                                     100.0f)];
  self.scvB.numericType = Currency;
  self.scvB.key = @"costOfReplaceFurnishings";
  self.scvB.title = @"What does your typical cost to replace other\nfurnishings after a bed bug infestation?";
  [self.uisv addSubview:self.scvB];
  
  self.uisv.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame),
                                     CGRectGetMaxY(self.scvB.frame) + 20.0f);
}

@end