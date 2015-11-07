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
  self.scvA.title = @"What does your typical mattress and box spring cost to replace?";
  [self.uisv addSubview:self.scvA];
  
  //
  self.scvB = [[StepperComponentView alloc] initWithFrame:CGRectMake(20.0f,
                                                                     CGRectGetMinY(self.scvA.frame) + self.scvA.height + 30.0f,
                                                                     CGRectGetWidth(self.view.frame) - 40.0f,
                                                                     245.0f)];
  self.scvB.numericType = Currency;
  self.scvB.key = @"costOfReplaceFurnishings";
  self.scvB.title = @"During an infestation, hotel owners typically are forced to throw away other furnishings, according to property managers and pest control specialist the industry average is $500 per room per incident, adjust this value to best represent your property and experience.";
  self.scvB.value = @(500);
  [self.uisv addSubview:self.scvB];
  
  self.uisv.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame),
                                     CGRectGetMinY(self.scvB.frame) + self.scvB.height + 20.0f);
}

@end