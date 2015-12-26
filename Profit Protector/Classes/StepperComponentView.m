#import "StepperComponentView.h"
#import "GlobalData.h"

@interface StepperComponentView () <UITextFieldDelegate>
{
  UILabel           *title_;
  UITextField       *textField_;
  
  NSNumberFormatter *formatter_;
  
  NSTimer           *timer_;
}
@end

@implementation StepperComponentView

- (instancetype)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self)
  {
    self.backgroundColor = [UIColor clearColor];
    self.value = @(-1);
    
    // Create formatter
    formatter_ = [[NSNumberFormatter alloc] init];
    self.stepByValue = 1;
    
    //
    title_ = [[UILabel alloc] initWithFrame:CGRectMake(0.0f,
                                                       0.0f,
                                                       CGRectGetWidth(self.frame),
                                                       48.0f)];
    title_.font = [UIFont fontWithName:@"HelveticaNeue" size:18.0f];
    title_.textColor = [UIColor colorWithRed:0 green:0.68 blue:0.95 alpha:1];
    title_.textAlignment = NSTextAlignmentCenter;
    title_.numberOfLines = 0;
    [self addSubview:title_];
  }
  return self;
}

- (void)setTitle:(NSString *)title
{
  _title = title;
  title_.text = title;
  
  [title_ sizeToFit];
  
  title_.frame = CGRectMake(0.0f,
                            0.0f,
                            CGRectGetWidth(self.frame),
                            CGRectGetHeight(title_.frame));
  
  CGFloat y = CGRectGetMaxY(title_.frame);
  
  //
  if (self.url)
  {
    UIButton *url = [[UIButton alloc] initWithFrame:CGRectMake(0.0f,
                                                               y + 10.0f,
                                                               CGRectGetWidth(self.frame),
                                                               37.0f)];
    url.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:18.0f];
    [url setTitleColor:[UIColor colorWithRed:0 green:0.68 blue:0.95 alpha:1] forState:UIControlStateNormal];
    [url setTitle:@"TripAdvisor Example >" forState:UIControlStateNormal];
    [url addTarget:self action:@selector(openURL:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:url];
    
    y = CGRectGetMaxY(url.frame) + 10.0f;
  }
  
  //
  UIButton *minus = [UIButton buttonWithType:UIButtonTypeCustom];
  minus.showsTouchWhenHighlighted = YES;
  minus.frame = CGRectMake(0.0f,
                           y + 10.0f,
                           40.0f,
                           40.0f);
  minus.backgroundColor = [UIColor colorWithRed:0 green:0.68 blue:0.95 alpha:1];
  minus.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:32.0f];
  minus.titleEdgeInsets = UIEdgeInsetsMake(-5.0f,
                                           0.0f,
                                           0.0f,
                                           0.0f);
  [minus setTitle:@"-" forState:UIControlStateNormal];
  [minus addTarget:self action:@selector(startMinusTimer) forControlEvents:UIControlEventTouchDown];
  [minus addTarget:self action:@selector(stopTimer) forControlEvents:UIControlEventTouchUpInside];
  [minus addTarget:self action:@selector(stopTimer) forControlEvents:UIControlEventTouchUpOutside];
  [self addSubview:minus];
  
  //
  UIButton *plus = [UIButton buttonWithType:UIButtonTypeCustom];
  plus.showsTouchWhenHighlighted = YES;
  plus.frame = CGRectMake(CGRectGetWidth(self.frame) - 40.0f,
                          y + 10.0f,
                          40.0f,
                          40.0f);
  plus.backgroundColor = [UIColor colorWithRed:0 green:0.68 blue:0.95 alpha:1];
  plus.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:32.0f];
  plus.titleEdgeInsets = UIEdgeInsetsMake(-5.0f,
                                          0.0f,
                                          0.0f,
                                          0.0f);
  [plus setTitle:@"+" forState:UIControlStateNormal];
  [plus addTarget:self action:@selector(startPlusTimer) forControlEvents:UIControlEventTouchDown];
  [plus addTarget:self action:@selector(stopTimer) forControlEvents:UIControlEventTouchUpInside];
  [plus addTarget:self action:@selector(stopTimer) forControlEvents:UIControlEventTouchUpOutside];
  [self addSubview:plus];
  
  //
  UIView *topLine = [[UIView alloc] initWithFrame:CGRectMake(0.0f,
                                                             y + 10.0f,
                                                             CGRectGetWidth(self.frame),
                                                             1.0f)];
  topLine.backgroundColor = [UIColor colorWithRed:0 green:0.68 blue:0.95 alpha:1];
  [self addSubview:topLine];
  
  //
  UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0.0f,
                                                                CGRectGetMaxY(minus.frame),
                                                                CGRectGetWidth(self.frame),
                                                                1.0f)];
  bottomLine.backgroundColor = [UIColor colorWithRed:0 green:0.68 blue:0.95 alpha:1];
  [self addSubview:bottomLine];
  
  //
  textField_ = [[UITextField alloc] initWithFrame:CGRectMake(40.0f,
                                                             y + 11.0f,
                                                             CGRectGetWidth(self.frame) - 80.0f,
                                                             38.0f)];
  textField_.delegate = self;
  textField_.textAlignment = NSTextAlignmentCenter;
  textField_.font = [UIFont fontWithName:@"HelveticaNeue" size:18.0f];
  textField_.textColor = [UIColor darkGrayColor];
  textField_.backgroundColor = [UIColor whiteColor];
  textField_.keyboardType = UIKeyboardTypeDecimalPad;
  textField_.returnKeyType = UIReturnKeyDefault;
  textField_.enablesReturnKeyAutomatically = YES;
  textField_.autocorrectionType = UITextAutocorrectionTypeNo;
  textField_.clearsOnBeginEditing = YES;
  [self addSubview:textField_];

  self.height = CGRectGetMaxY(bottomLine.frame);
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

- (void)setValue:(NSNumber *)value
{
  _value = value;
  
  textField_.text = [formatter_ stringFromNumber:_value];
  
  [self updateGlobalValues];
}

- (void)minus:(UIButton *)uib
{
  NSNumber *number = [formatter_ numberFromString:textField_.text];
  textField_.text = [formatter_ stringFromNumber:@([number floatValue] - self.stepByValue)];
  
  self.value = [formatter_ numberFromString:textField_.text];
  
  [self updateGlobalValues];
}

- (void)plus:(UIButton *)uib
{
  NSNumber *number = [formatter_ numberFromString:textField_.text];
  textField_.text = [formatter_ stringFromNumber:@([number floatValue] + self.stepByValue)];
  
  self.value = [formatter_ numberFromString:textField_.text];
  
  [self updateGlobalValues];
}

- (void)startMinusTimer
{
  if (timer_)
  {
    [self stopTimer];
    return;
  }
  
  [self minus:nil];
  timer_ = [NSTimer scheduledTimerWithTimeInterval:0.15f
                                            target:self
                                          selector:@selector(minus:)
                                          userInfo:nil
                                           repeats:YES];
}

- (void)startPlusTimer
{
  if (timer_)
  {
    [self stopTimer];
    return;
  }
  
  [self plus:nil];
  timer_ = [NSTimer scheduledTimerWithTimeInterval:0.15f
                                            target:self
                                          selector:@selector(plus:)
                                          userInfo:nil
                                           repeats:YES];
}

- (void)stopTimer
{
  [timer_ invalidate];
  timer_ = nil;
}

- (void)formatTextField
{
  textField_.text = [formatter_ stringFromNumber:@([textField_.text floatValue])];

  self.value = [formatter_ numberFromString:textField_.text];
  
  [self updateGlobalValues];
}

- (void)updateGlobalValues
{
  if ([self.key isEqualToString:@"bedsNumber"])
  {
    GlobalData *gb = [GlobalData singleton];
    gb.numberOfBeds = [self.value floatValue];
  }
  
  if ([self.key isEqualToString:@"costOfReplaceMattressesAndBoxSpring"])
  {
    GlobalData *gb = [GlobalData singleton];
    gb.costPerBed = [self.value floatValue];
  }
  
  if ([self.key isEqualToString:@"percentageOfMattressesReplaceEachYear"])
  {
    GlobalData *gd = [GlobalData singleton];
    gd.percentage = [self.value floatValue];
  }
  
  [[NSNotificationCenter defaultCenter] postNotificationName:self.key
                                                      object:self.value];
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

- (void)openURL:(id)sender
{
  [[UIApplication sharedApplication] openURL:self.url];
}

@end