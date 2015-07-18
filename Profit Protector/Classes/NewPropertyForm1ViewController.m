#import "NewPropertyForm1ViewController.h"

@interface NewPropertyForm1ViewController () <UITextFieldDelegate>
{
  UITextField *textField_;
}
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
  textField_ = [[UITextField alloc] initWithFrame:CGRectMake(40.0f,
                                                             CGRectGetMaxY(title.frame),
                                                             CGRectGetWidth(self.view.frame) - 80.0f,
                                                             38.0f)];
  textField_.delegate = self;
  textField_.textAlignment = NSTextAlignmentCenter;
  textField_.font = [UIFont fontWithName:@"HelveticaNeue" size:16.0f];
  textField_.textColor = [UIColor darkGrayColor];
  textField_.backgroundColor = [UIColor whiteColor];
  textField_.clearsOnBeginEditing = YES;
  textField_.layer.cornerRadius = 0.0f;
  textField_.layer.masksToBounds = YES;
  textField_.layer.borderWidth = 1.0f;
  textField_.layer.borderColor = [[UIColor colorWithRed:0 green:0.68 blue:0.95 alpha:1] CGColor];
  textField_.autocorrectionType = UITextAutocorrectionTypeNo;
  [self.uisv addSubview:textField_];
  
  self.uisv.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame),
                                     CGRectGetMaxY(textField_.frame));
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