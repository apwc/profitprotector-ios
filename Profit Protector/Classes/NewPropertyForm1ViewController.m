#import "NewPropertyForm1ViewController.h"

@interface NewPropertyForm1ViewController () <UITextFieldDelegate>
@end

@implementation NewPropertyForm1ViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  //
  UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0.0f,
                                                             10.0f,
                                                             CGRectGetWidth(self.view.frame) + 10.0f,
                                                             48.0f)];
  title.font = [UIFont fontWithName:@"HelveticaNeue" size:18.0f];
  title.textColor = [UIColor colorWithRed:0 green:0.68 blue:0.95 alpha:1];
  title.textAlignment = NSTextAlignmentCenter;
  title.text = [GlobalMethods localizedStringWithKey:@"Form1 Question1"];
  [self.uisv addSubview:title];
  
  //
  self.textField = [[UITextField alloc] initWithFrame:CGRectMake(40.0f,
                                                                 CGRectGetMaxY(title.frame),
                                                                 CGRectGetWidth(self.view.frame) - 80.0f,
                                                                 38.0f)];
  self.textField.delegate = self;
  self.textField.textAlignment = NSTextAlignmentCenter;
  self.textField.font = [UIFont fontWithName:@"HelveticaNeue" size:18.0f];
  self.textField.textColor = [UIColor darkGrayColor];
  self.textField.backgroundColor = [UIColor whiteColor];
  self.textField.clearsOnBeginEditing = YES;
  self.textField.layer.cornerRadius = 0.0f;
  self.textField.layer.masksToBounds = YES;
  self.textField.layer.borderWidth = 1.0f;
  self.textField.layer.borderColor = [[UIColor colorWithRed:0 green:0.68 blue:0.95 alpha:1] CGColor];
  self.textField.autocorrectionType = UITextAutocorrectionTypeNo;
  [self.uisv addSubview:self.textField];
  
  //
  UILabel *title2 = [[UILabel alloc] initWithFrame:CGRectMake(0.0f,
                                                              CGRectGetMaxY(self.textField.frame) + 20.0f,
                                                              CGRectGetWidth(self.view.frame),
                                                              48.0f)];
  title2.font = [UIFont fontWithName:@"HelveticaNeue" size:18.0f];
  title2.textColor = [UIColor colorWithRed:0 green:0.68 blue:0.95 alpha:1];
  title2.textAlignment = NSTextAlignmentCenter;
  title2.text = [GlobalMethods localizedStringWithKey:@"Form1 Question2"];
  [self.uisv addSubview:title2];
  
  self.propertyType = [UIButton buttonWithType:UIButtonTypeCustom];
  self.propertyType.frame = CGRectMake(40.0f,
                                       CGRectGetMaxY(title2.frame),
                                       CGRectGetWidth(self.view.frame) - 80.0f,
                                       38.0f);
  self.propertyType.showsTouchWhenHighlighted = YES;
  self.propertyType.backgroundColor = [UIColor whiteColor];
  self.propertyType.layer.cornerRadius = 0.0f;
  self.propertyType.layer.masksToBounds = YES;
  self.propertyType.layer.borderWidth = 1.0f;
  self.propertyType.layer.borderColor = [[UIColor colorWithRed:0 green:0.68 blue:0.95 alpha:1] CGColor];
  [self.propertyType setTitle:[GlobalMethods localizedStringWithKey:@"Property Type"] forState:UIControlStateNormal];
  [self.propertyType setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
  [self.view addSubview:self.propertyType];
  
  //
  UILabel *extra = [[UILabel alloc] initWithFrame:CGRectMake(0.0f,
                                                             CGRectGetMaxY(self.propertyType.frame) + 100.f,
                                                             CGRectGetWidth(self.view.frame),
                                                             64)];
  extra.font = [UIFont fontWithName:@"HelveticaNeue" size:18.0f];
  extra.textColor = [UIColor darkGrayColor];
  extra.textAlignment = NSTextAlignmentCenter;
  extra.text = [GlobalMethods localizedStringWithKey:@"industry average"];
  extra.numberOfLines = 0;
  [self.uisv addSubview:extra];
  
  self.uisv.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame),
                                     CGRectGetMaxY(self.textField.frame));
}

#pragma mark - UITextField delegate methods implementation

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
  [textField resignFirstResponder];
  
  return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
  [textField resignFirstResponder];
  
  return YES;
}

@end