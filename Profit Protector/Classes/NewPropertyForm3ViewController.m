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
  self.scvA.title = @"What is your average\nroom revenue per night?";
  [self.uisv addSubview:self.scvA];
  
  //
  self.scvB = [[StepperComponentView alloc] initWithFrame:CGRectMake(20.0f,
                                                                     CGRectGetMinY(self.scvA.frame) + self.scvA.height + 30.0f,
                                                                     CGRectGetWidth(self.view.frame) - 40.0f,
                                                                     120.0f)];
  self.scvB.numericType = Currency;
  self.scvB.key = @"foodBeverageSalesPerRoomPerNight";
  self.scvB.title = @"What is your average food and beverage sales per room per night?";
  [self.uisv addSubview:self.scvB];
  
  //
  self.scvC = [[StepperComponentView alloc] initWithFrame:CGRectMake(20.0f,
                                                                     CGRectGetMinY(self.scvB.frame) + self.scvB.height + 30.0f,
                                                                     CGRectGetWidth(self.view.frame) - 40.0f,
                                                                     100.0f)];
  self.scvC.numericType = Currency;
  self.scvC.key = @"ancillariesRevenuePerRoomPerNight";
  self.scvC.title = @"What is your total ancillaries revenues per room per night?";
  [self.uisv addSubview:self.scvC];
  
  self.uisv.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame),
                                     CGRectGetMinY(self.scvC.frame) + self.scvC.height + 20.0f);
}

@end