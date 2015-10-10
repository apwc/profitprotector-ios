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
  [[NSNotificationCenter defaultCenter] removeObserver:self];
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
                                                     CGRectGetMinY(self.scvA.frame) + self.scvA.height + 30.0f,
                                                     CGRectGetWidth(self.view.frame),
                                                     130.0f)];
  label_.backgroundColor = [UIColor whiteColor];
  label_.numberOfLines = 0;
  label_.textAlignment = NSTextAlignmentCenter;
  [self.uisv addSubview:label_];
  
  [self updateField];
  
  //
  self.uisv.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame),
                                     CGRectGetMinY(self.scvA.frame) + self.scvA.height + 20.0f);
  
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(updateField)
                                               name:self.scvA.key
                                             object:nil];
  
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(updateField)
                                               name:@"costOfReplaceMattressesAndBoxSpring"
                                             object:nil];
  
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(updateField)
                                               name:@"bedsNumber"
                                             object:nil];
}

- (void)updateField
{
  GlobalData *gd = [GlobalData singleton];
  
  if (gd.numberOfBeds != -1.0f && gd.percentage != -1.0f && gd.costPerBed != -1.0f)
  {
    CGFloat res = gd.numberOfBeds * (gd.percentage / 100.0f) * gd.costPerBed;
    CGFloat res2 = res * 10.0;
    
    NSString *composedString = [NSString stringWithFormat:@"Total savings from spoilage alone:\n$%.2f\n\nLifetime savings from loss due\nto spoilage:\n$%.2f",
                                res,
                                res2];
    
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
                            range:NSMakeRange(startRange, [composedString length] - startRange)];
    
    label_.attributedText = attributedText;
  }
}

@end