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
  self.scvA.title = [GlobalMethods localizedStringWithKey:@"Form4 Question1"];
  [self.uisv addSubview:self.scvA];
  
  //
  self.scvB = [[StepperComponentView alloc] initWithFrame:CGRectMake(20.0f,
                                                                     CGRectGetMinY(self.scvA.frame) + self.scvA.height + 30.0f,
                                                                     CGRectGetWidth(self.view.frame) - 40.0f,
                                                                     245.0f)];
  self.scvB.numericType = Currency;
  self.scvB.key = @"costOfReplaceFurnishings";
  self.scvB.title = [GlobalMethods localizedStringWithKey:@"Form4 Question2"];
  self.scvB.value = @(500);
  self.scvB.industryStandardValue = 500;
  [self.uisv addSubview:self.scvB];
  
  self.uisv.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame),
                                     CGRectGetMinY(self.scvB.frame) + self.scvB.height + 20.0f);
}

@end