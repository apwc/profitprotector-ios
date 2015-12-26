#import "NewPropertyForm6ViewController.h"

@implementation NewPropertyForm6ViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  //
  self.scvA = [[StepperComponentView alloc] initWithFrame:CGRectMake(20.0f,
                                                                     20.0f,
                                                                     CGRectGetWidth(self.view.frame) - 40.0f,
                                                                     140.0f)];
  self.scvA.numericType = Numeric;
  self.scvA.key = @"timesPerYearBedClean";
  self.scvA.title = NSLocalizedString(@"Form6 Question1", nil);
  self.scvA.value = @(2);
  [self.uisv addSubview:self.scvA];
  
  //
  self.scvB = [[StepperComponentView alloc] initWithFrame:CGRectMake(20.0f,
                                                                     CGRectGetMinY(self.scvA.frame) + self.scvA.height + 30.0f,
                                                                     CGRectGetWidth(self.view.frame) - 40.0f,
                                                                     200.0f)];
  self.scvB.numericType = Currency;
  self.scvB.key = @"costToCleanAndReinstallEncasements";
  self.scvB.title = NSLocalizedString(@"Form6 Question2", nil);
  self.scvB.value = @(1.50);
  [self.uisv addSubview:self.scvB];
  
  //
  self.scvC = [[StepperComponentView alloc] initWithFrame:CGRectMake(20.0f,
                                                                     CGRectGetMinY(self.scvB.frame) + self.scvB.height + 30.0f,
                                                                     CGRectGetWidth(self.view.frame) - 40.0f,
                                                                     100.0f)];
  self.scvC.numericType = Numeric;
  self.scvC.key = @"bedBugIncidents";
  self.scvC.title = NSLocalizedString(@"Form6 Question3", nil);
  self.scvC.value = @(8);
  [self.uisv addSubview:self.scvC];
  
  //
  self.scvD = [[StepperComponentView alloc] initWithFrame:CGRectMake(20.0f,
                                                                     CGRectGetMinY(self.scvC.frame) + self.scvC.height + 30.0f,
                                                                     CGRectGetWidth(self.view.frame) - 40.0f,
                                                                     160.0f)];
  self.scvD.numericType = Currency;
  self.scvD.key = @"grievanceCosts";
  self.scvD.title = NSLocalizedString(@"Form6 Question4", nil);
  self.scvD.value = @(1000);
  [self.uisv addSubview:self.scvD];
  
  self.uisv.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame),
                                     CGRectGetMinY(self.scvD.frame) + self.scvD.height + 20.0f);
}

@end