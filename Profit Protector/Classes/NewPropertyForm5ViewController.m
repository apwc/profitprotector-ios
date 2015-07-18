#import "NewPropertyForm5ViewController.h"

@implementation NewPropertyForm5ViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  //
  self.scvA = [[StepperComponentView alloc] initWithFrame:CGRectMake(20.0f,
                                                                     20.0f,
                                                                     CGRectGetWidth(self.view.frame) - 40.0f,
                                                                     100.0f)];
  self.scvA.numericType = Percentage;
  self.scvA.key = @"percentageOfMattressesReplaceEachYear";
  self.scvA.title = @"What percentage of mattresses do\nyour replace each year due to spoilage?";
  [self.uisv addSubview:self.scvA];
  
  self.uisv.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame),
                                     CGRectGetMaxY(self.scvA.frame) + 20.0f);
}

@end