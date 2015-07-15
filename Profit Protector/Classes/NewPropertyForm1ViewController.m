#import "NewPropertyForm1ViewController.h"
#import "StepperComponentView.h"

@interface NewPropertyForm1ViewController ()
@end

@implementation NewPropertyForm1ViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  StepperComponentView *scv = [[StepperComponentView alloc] initWithFrame:CGRectMake(20.0f,
                                                                                     20.0f,
                                                                                     CGRectGetWidth(self.view.frame) - 40.0f,
                                                                                     100.0f)];
  scv.title = @"How many rooms do you have\nin your property?";
  [self.view addSubview:scv];
}

@end