#import "NewPropertyForm5ViewController.h"

@implementation NewPropertyForm5ViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  //
  StepperComponentView *scvA = [[StepperComponentView alloc] initWithFrame:CGRectMake(20.0f,
                                                                                      20.0f,
                                                                                      CGRectGetWidth(self.view.frame) - 40.0f,
                                                                                      100.0f)];
  scvA.numericType = Percentage;
  scvA.title = @"What percentage of mattresses do\nyour replace each year due to spoilage?";
  [self.uisv addSubview:scvA];
  
  self.uisv.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame),
                                     CGRectGetMaxY(scvA.frame) + 20.0f);
}

@end