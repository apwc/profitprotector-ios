#import "NewPropertyForm5ViewController.h"
#import "GlobalData.h"

@interface NewPropertyForm5ViewController ()
{
  UILabel *label_;
}
@end

@implementation NewPropertyForm5ViewController

- (void)dealloc
{
  [[NSNotificationCenter defaultCenter] removeObserver:self
                                                  name:@"percentageOfMattressesReplaceEachYear"
                                                object:nil];
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  //
  self.scvA = [[StepperComponentView alloc] initWithFrame:CGRectMake(20.0f,
                                                                     20.0f,
                                                                     CGRectGetWidth(self.view.frame) - 40.0f,
                                                                     100.0f)];
  self.scvA.numericType = Numeric;
  self.scvA.key = @"percentageOfMattressesReplaceEachYear";
  self.scvA.title = @"What percentage of mattresses do\nyour replace each year due to spoilage?";
  [self.uisv addSubview:self.scvA];
  
  self.uisv.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame),
                                     CGRectGetMaxY(self.scvA.frame) + 20.0f);
  
  //
  label_ = [[UILabel alloc] initWithFrame:CGRectMake(20.0f,
                                                     CGRectGetMaxY(self.scvA.frame) + 20.0f,
                                                     CGRectGetWidth(self.view.frame) - 40.0f,
                                                     21.0f)];
  label_.font = [UIFont fontWithName:@"HelveticaNeue" size:13.0f];
  label_.textColor = [UIColor colorWithRed:0 green:0.68 blue:0.95 alpha:1];
  [self.uisv addSubview:label_];
  
  [self updateField];
  
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(updateField)
                                               name:self.scvA.key
                                             object:nil];
}

- (void)updateField
{
  GlobalData *gb = [GlobalData singleton];
  
  if (gb.numberOfBeds != -1.0f && gb.percentage!= -1.0f)
    label_.text = [NSString stringWithFormat:@"Total savings from spoilage alone: $%.2f",
                   gb.numberOfBeds * gb.percentage * 80.0f * 8.0f];
}

@end