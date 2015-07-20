#import "NewPropertyForm1ViewController.h"

@interface NewPropertyForm1ViewController () <UITextFieldDelegate>
@end

@implementation NewPropertyForm1ViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  //
  UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0.0f,
                                                             0.0f,
                                                             CGRectGetWidth(self.view.frame),
                                                             48.0f)];
  title.font = [UIFont fontWithName:@"HelveticaNeue" size:14.0f];
  title.textColor = [UIColor colorWithRed:0 green:0.68 blue:0.95 alpha:1];
  title.textAlignment = NSTextAlignmentCenter;
  title.text = @"Property name";
  [self.uisv addSubview:title];
  
  //
  self.textField = [[UITextField alloc] initWithFrame:CGRectMake(40.0f,
                                                                 CGRectGetMaxY(title.frame),
                                                                 CGRectGetWidth(self.view.frame) - 80.0f,
                                                                 38.0f)];
  self.textField.delegate = self;
  self.textField.textAlignment = NSTextAlignmentCenter;
  self.textField.font = [UIFont fontWithName:@"HelveticaNeue" size:16.0f];
  self.textField.textColor = [UIColor darkGrayColor];
  self.textField.backgroundColor = [UIColor whiteColor];
  self.textField.clearsOnBeginEditing = YES;
  self.textField.layer.cornerRadius = 0.0f;
  self.textField.layer.masksToBounds = YES;
  self.textField.layer.borderWidth = 1.0f;
  self.textField.layer.borderColor = [[UIColor colorWithRed:0 green:0.68 blue:0.95 alpha:1] CGColor];
  self.textField.autocorrectionType = UITextAutocorrectionTypeNo;
  [self.uisv addSubview:self.textField];
  
  
  self.propertyType = [UIButton buttonWithType:UIButtonTypeCustom];
  self.propertyType.frame = CGRectMake(40.0f,
                                       CGRectGetMaxY(self.textField.frame) + 20.0f,
                                       CGRectGetWidth(self.view.frame) - 80.0f,
                                       38.0f);
  self.propertyType.showsTouchWhenHighlighted = YES;
  self.propertyType.backgroundColor = [UIColor whiteColor];
  self.propertyType.layer.cornerRadius = 0.0f;
  self.propertyType.layer.masksToBounds = YES;
  self.propertyType.layer.borderWidth = 1.0f;
  self.propertyType.layer.borderColor = [[UIColor colorWithRed:0 green:0.68 blue:0.95 alpha:1] CGColor];
  [self.propertyType setTitle:@"Property Type" forState:UIControlStateNormal];
  [self.propertyType setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
  [self.view addSubview:self.propertyType];
  
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