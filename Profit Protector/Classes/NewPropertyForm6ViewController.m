#import "NewPropertyForm6ViewController.h"

@implementation NewPropertyForm6ViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  //
  UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(10.0f,
                                                             20.0f,
                                                             CGRectGetWidth(self.view.frame) - 20.0f,
                                                             120.0f)];
  title.numberOfLines = 0;
  title.font = [UIFont fontWithName:@"HelveticaNeue" size:16.0f];
  title.textColor = [UIColor darkGrayColor];
  title.textAlignment = NSTextAlignmentCenter;
  title.text = @"This section is designed to collect the costs associated with properly maintaining your encasements as well as hiring a professional pest control company to help train your staff and conduct routine inspections.";
  [self.uisv addSubview:title];
  
  //
  self.scvA = [[StepperComponentView alloc] initWithFrame:CGRectMake(20.0f,
                                                                     CGRectGetMaxY(title.frame) + 30.0f,
                                                                     CGRectGetWidth(self.view.frame) - 40.0f,
                                                                     140.0f)];
  self.scvA.numericType = Numeric;
  self.scvA.key = @"timesPerYearBedClean";
  self.scvA.title = @"CleanBrands suggests washing your encasements twice a year, adjust this value to represent your property's protocol.";
  [self.uisv addSubview:self.scvA];
  
  //
  self.scvB = [[StepperComponentView alloc] initWithFrame:CGRectMake(20.0f,
                                                                     CGRectGetMaxY(self.scvA.frame) + 30.0f,
                                                                     CGRectGetWidth(self.view.frame) - 40.0f,
                                                                     200.0f)];
  self.scvB.numericType = Currency;
  self.scvB.key = @"costToCleanAndReinstallEncasements";
  self.scvB.title = @"CleanBrands estimates it will cost $1.50 to remove, launder and install the typical mattress encasement. Note it is not necessary to launder box spring encasements as they do not come in contact with the guest.";
  self.scvB.value = @(1.50);
  [self.uisv addSubview:self.scvB];
  
  self.uisv.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame),
                                     CGRectGetMaxY(self.scvB.frame) + 20.0f);

  //
  self.scvC = [[StepperComponentView alloc] initWithFrame:CGRectMake(20.0f,
                                                                     CGRectGetMaxY(self.scvB.frame) + 20.0f,
                                                                     CGRectGetWidth(self.view.frame) - 40.0f,
                                                                     100.0f)];
  self.scvC.numericType = Numeric;
  self.scvC.key = @"bedBugIncidents";
  self.scvC.title = @"How many bed bugs incidents did you\nhave this year?";
  [self.uisv addSubview:self.scvC];
  
  //
  self.scvD = [[StepperComponentView alloc] initWithFrame:CGRectMake(20.0f,
                                                                     CGRectGetMaxY(self.scvC.frame) + 20.0f,
                                                                     CGRectGetWidth(self.view.frame) - 40.0f,
                                                                     100.0f)];
  self.scvD.numericType = Currency;
  self.scvD.key = @"grevianceCostsPerInfestation";
  self.scvD.title = @"What is your customer greviance costs\nper infestation?";
  //[self.uisv addSubview:self.scvD];
  
  self.uisv.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame),
                                     CGRectGetMaxY(self.scvC.frame) + 20.0f);
}

@end