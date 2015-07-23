#import "StepperComponentView.h"

@interface StepperComponentView () <UITextFieldDelegate>
{
  UILabel           *title_;
  UITextField       *textField_;
  
  NSNumberFormatter *formatter_;
}
@end

@implementation StepperComponentView

- (instancetype)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self)
  {
    self.value = @(0);
    
    // Create formatter
    formatter_ = [[NSNumberFormatter alloc] init];
    self.stepByValue = 1;
    
    //
    title_ = [[UILabel alloc] initWithFrame:CGRectMake(0.0f,
                                                       0.0f,
                                                       CGRectGetWidth(self.frame),
                                                       48.0f)];
    title_.font = [UIFont fontWithName:@"HelveticaNeue" size:13.0f];
    title_.textColor = [UIColor colorWithRed:0 green:0.68 blue:0.95 alpha:1];
    title_.textAlignment = NSTextAlignmentCenter;
    title_.numberOfLines = 0;
    [self addSubview:title_];
    
    //
    UIButton *minus = [UIButton buttonWithType:UIButtonTypeCustom];
    minus.showsTouchWhenHighlighted = YES;
    minus.frame = CGRectMake(0.0f,
                             CGRectGetHeight(self.frame) - 40.0f,
                             40.0f,
                             40.0f);
    minus.backgroundColor = [UIColor colorWithRed:0 green:0.68 blue:0.95 alpha:1];
    minus.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:32.0f];
    minus.titleEdgeInsets = UIEdgeInsetsMake(-5.0f,
                                             0.0f,
                                             0.0f,
                                             0.0f);
    [minus setTitle:@"-" forState:UIControlStateNormal];
    [minus addTarget:self action:@selector(minus:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:minus];
    
    //
    UIButton *plus = [UIButton buttonWithType:UIButtonTypeCustom];
    plus.showsTouchWhenHighlighted = YES;
    plus.frame = CGRectMake(CGRectGetWidth(self.frame) - 40.0f,
                            CGRectGetHeight(self.frame) - 40.0f,
                            40.0f,
                            40.0f);
    plus.backgroundColor = [UIColor colorWithRed:0 green:0.68 blue:0.95 alpha:1];
    plus.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:32.0f];
    plus.titleEdgeInsets = UIEdgeInsetsMake(-5.0f,
                                            0.0f,
                                            0.0f,
                                            0.0f);
    [plus setTitle:@"+" forState:UIControlStateNormal];
    [plus addTarget:self action:@selector(plus:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:plus];
    
    //
    UIView *topLine = [[UIView alloc] initWithFrame:CGRectMake(0.0f,
                                                               CGRectGetHeight(self.frame) - 40.0f,
                                                               CGRectGetWidth(self.frame),
                                                               1.0f)];
    topLine.backgroundColor = [UIColor colorWithRed:0 green:0.68 blue:0.95 alpha:1];
    [self addSubview:topLine];
    
    //
    UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0.0f,
                                                                  CGRectGetHeight(self.frame) - 1.0f,
                                                                  CGRectGetWidth(self.frame),
                                                                  1.0f)];
    bottomLine.backgroundColor = [UIColor colorWithRed:0 green:0.68 blue:0.95 alpha:1];
    [self addSubview:bottomLine];
    
    //
    textField_ = [[UITextField alloc] initWithFrame:CGRectMake(40.0f,
                                                               CGRectGetHeight(self.frame) - 39.0f,
                                                               CGRectGetWidth(self.frame) - 80.0f,
                                                               38.0f)];
    textField_.delegate = self;
    textField_.textAlignment = NSTextAlignmentCenter;
    textField_.font = [UIFont fontWithName:@"HelveticaNeue" size:16.0f];
    textField_.textColor = [UIColor darkGrayColor];
    textField_.backgroundColor = [UIColor whiteColor];
    textField_.clearsOnBeginEditing = YES;
    textField_.autocorrectionType = UITextAutocorrectionTypeNo;
    [self addSubview:textField_];
  }
  return self;
}

- (void)setTitle:(NSString *)title
{
  _title = title;
  title_.text = title;
}

- (void)setNumericType:(NumericType)numericType
{
  _numericType = numericType;

  if (numericType == Numeric)
    [formatter_ setNumberStyle:NSNumberFormatterDecimalStyle];
  
  if (numericType == Currency)
    [formatter_ setNumberStyle:NSNumberFormatterCurrencyStyle];
  
  if (numericType == Percentage)
    [formatter_ setNumberStyle:NSNumberFormatterPercentStyle];
}

- (void)minus:(UIButton *)uib
{
  NSNumber *number = [formatter_ numberFromString:textField_.text];
  textField_.text = [formatter_ stringFromNumber:@([number floatValue] - self.stepByValue)];
  
  /*if (formatter_.numberStyle == NSNumberFormatterPercentStyle)
  {
    NSNumber *number = [formatter_ numberFromString:textField_.text];
    NSLog(@"%@", number);
   // number = @([number integerValue] * 100);

    textField_.text = [formatter_ stringFromNumber:@([number floatValue] - self.stepByValue)];
  }
  else
  {
    NSNumber *number = [formatter_ numberFromString:textField_.text];
    //textField_.text = [formatter_ stringFromNumber:@([number floatValue] - self.stepByValue)];
  }*/
  
  self.value = [formatter_ numberFromString:textField_.text];
}

- (void)plus:(UIButton *)uib
{
  NSNumber *number = [formatter_ numberFromString:textField_.text];
  textField_.text = [formatter_ stringFromNumber:@([number floatValue] + self.stepByValue)];
  
  /*if (formatter_.numberStyle == NSNumberFormatterPercentStyle)
  {
    NSNumber *number = [formatter_ numberFromString:textField_.text];
    NSLog(@"%@", number);
   // number = @([number integerValue] * 100);
    textField_.text = [formatter_ stringFromNumber:@([number floatValue] + self.stepByValue)];
    //textField_.text = [formatter_ stringFromNumber:@(([number floatValue] + self.stepByValue) / 100.0f)];
  }
  else
  {
    //textField_.text = [formatter_ stringFromNumber:@([number floatValue] + self.stepByValue)];
  }*/
  
  self.value = [formatter_ numberFromString:textField_.text];
}

- (void)formatTextField
{
  textField_.text = [formatter_ stringFromNumber:@([textField_.text floatValue])];

  self.value = [formatter_ numberFromString:textField_.text];
}

#pragma mark - UITextField delegate methods implementation

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
  [self formatTextField];
  
  return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
  [textField resignFirstResponder];
  
  return YES;
}

@end