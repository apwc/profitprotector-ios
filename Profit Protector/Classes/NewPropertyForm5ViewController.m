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
                                                                     180.0f)];
  self.scvA.numericType = Numeric;
  self.scvA.key = @"percentageOfMattressesReplaceEachYear";
  self.scvA.title = @"According to mattress manufacturers, most hotels lose 5% of their mattresses annually due to spoilage from spills and stains, adjust this value to best represent your property.";
  [self.uisv addSubview:self.scvA];
  
  //
  label_ = [[UILabel alloc] initWithFrame:CGRectMake(0.0f,
                                                     CGRectGetMaxY(self.scvA.frame) + 30.0f,
                                                     CGRectGetWidth(self.view.frame),
                                                     130.0f)];
  label_.backgroundColor = [UIColor whiteColor];
  label_.numberOfLines = 0;
  label_.textAlignment = NSTextAlignmentCenter;
  [self.uisv addSubview:label_];
  
  [self updateField];
  
  //
  /*self.scvB = [[StepperComponentView alloc] initWithFrame:CGRectMake(20.0f,
                                                                     CGRectGetMaxY(label_.frame) + 30.0f,
                                                                     CGRectGetWidth(self.view.frame) - 40.0f,
                                                                     200.0f)];
  self.scvB.numericType = Numeric;
  self.scvB.key = @"";
  self.scvB.title = @"CleanBrands estimates it will cost $1.50 to remove, launder and install the typical mattress encasement. Note it is not necessary to launder box spring encasements as they do not come in contact with the guest.";
  [self.uisv addSubview:self.scvB];*/
  
  self.uisv.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame),
                                     CGRectGetMaxY(self.scvA.frame) + 20.0f);
  
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(updateField)
                                               name:self.scvA.key
                                             object:nil];
}

- (void)updateField
{
  GlobalData *gd = [GlobalData singleton];
  
  if (gd.numberOfBeds != -1.0f && gd.percentage!= -1.0f)
  {
    CGFloat res = gd.numberOfBeds * (gd.percentage / 100.0f) * 80.0f;
    
    NSString *composedString = [NSString stringWithFormat:@"Total savings from spoilage alone:\n$%.2f\n\nLifetime savings from loss due\nto spoilage:\n$%.2f",
                                res,
                                9999.99f];
    
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:composedString];
    
    int startRange = 0;
    
    [attributedText setAttributes:@{NSForegroundColorAttributeName: [UIColor darkGrayColor],
                                    NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:16.0f]}
                            range:NSMakeRange(startRange, 35)];
    
    startRange += 35;
    
    [attributedText setAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:0 green:0.68 blue:0.95 alpha:1],
                                    NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:16.0f]}
                            range:NSMakeRange(startRange, [[NSString stringWithFormat:@"%.2f", res] length] + 1)];
    
    startRange += [[NSString stringWithFormat:@"%.2f", res] length] + 1;
    
    [attributedText setAttributes:@{NSForegroundColorAttributeName: [UIColor darkGrayColor],
                                    NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:16.0f]}
                            range:NSMakeRange(startRange, 45)];
    
    startRange += 45;
    
    [attributedText setAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:0 green:0.68 blue:0.95 alpha:1],
                                    NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:16.0f]}
                            range:NSMakeRange(startRange, 9)];
    
    label_.attributedText = attributedText;
  }
}

@end