#import "NewPropertyForm6ViewController.h"

@implementation NewPropertyForm6ViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  //
  StepperComponentView *scvA = [[StepperComponentView alloc] initWithFrame:CGRectMake(20.0f,
                                                                                      20.0f,
                                                                                      CGRectGetWidth(self.view.frame) - 40.0f,
                                                                                      100.0f)];
  scvA.numericType = Numeric;
  scvA.title = @"How many times per year do you\nclean bedding encasements?";
  [self.uisv addSubview:scvA];
  
  //
  StepperComponentView *scvB = [[StepperComponentView alloc] initWithFrame:CGRectMake(20.0f,
                                                                                      CGRectGetMaxY(scvA.frame) + 20.0f,
                                                                                      CGRectGetWidth(self.view.frame) - 40.0f,
                                                                                      100.0f)];
  scvB.numericType = Currency;
  scvB.title = @"How much does it cost to clean and\nreinstall encasements?";
  [self.uisv addSubview:scvB];
  
  //
  StepperComponentView *scvC = [[StepperComponentView alloc] initWithFrame:CGRectMake(20.0f,
                                                                                      CGRectGetMaxY(scvB.frame) + 20.0f,
                                                                                      CGRectGetWidth(self.view.frame) - 40.0f,
                                                                                      100.0f)];
  scvA.numericType = Numeric;
  scvC.title = @"How many bed bugs incidents did you\nhave this year?";
  [self.uisv addSubview:scvC];
  
  //
  StepperComponentView *scvD = [[StepperComponentView alloc] initWithFrame:CGRectMake(20.0f,
                                                                                      CGRectGetMaxY(scvC.frame) + 20.0f,
                                                                                      CGRectGetWidth(self.view.frame) - 40.0f,
                                                                                      100.0f)];
  scvD.numericType = Currency;
  scvD.title = @"What is your customer greviance costs\nper infestation?";
  [self.uisv addSubview:scvD];
  
  self.uisv.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame),
                                     CGRectGetMaxY(scvD.frame) + 20.0f);
}

@end