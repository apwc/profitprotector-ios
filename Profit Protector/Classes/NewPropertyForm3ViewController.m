#import "NewPropertyForm3ViewController.h"
#import "GlobalData.h"
#import "TypeDefEnumerators.h"

@implementation NewPropertyForm3ViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  //
  self.scvA = [[StepperComponentView alloc] initWithFrame:CGRectMake(20.0f,
                                                                     20.0f,
                                                                     CGRectGetWidth(self.view.frame) - 40.0f,
                                                                     100.0f)];
  self.scvA.numericType = Currency;
  self.scvA.key = @"roomRevenuePerNight";
  self.scvA.title = [GlobalMethods localizedStringWithKey:@"Form3 Question1"];
  [self.uisv addSubview:self.scvA];
  
  //
  self.scvB = [[StepperComponentView alloc] initWithFrame:CGRectMake(20.0f,
                                                                     CGRectGetMinY(self.scvA.frame) + self.scvA.height + 30.0f,
                                                                     CGRectGetWidth(self.view.frame) - 40.0f,
                                                                     120.0f)];
  self.scvB.numericType = Currency;
  self.scvB.key = @"foodBeverageSalesPerRoomPerNight";
  self.scvB.title = [GlobalMethods localizedStringWithKey:@"Form3 Question2"];
  [self.uisv addSubview:self.scvB];
  
  //
  self.scvC = [[StepperComponentView alloc] initWithFrame:CGRectMake(20.0f,
                                                                     CGRectGetMinY(self.scvB.frame) + self.scvB.height + 30.0f,
                                                                     CGRectGetWidth(self.view.frame) - 40.0f,
                                                                     100.0f)];
  self.scvC.numericType = Currency;
  self.scvC.key = @"ancillariesRevenuePerRoomPerNight";
  self.scvC.title = [GlobalMethods localizedStringWithKey:@"Form3 Question3"];
  [self.uisv addSubview:self.scvC];
  
  self.uisv.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame),
                                     CGRectGetMinY(self.scvC.frame) + self.scvC.height + 20.0f);
}

@end