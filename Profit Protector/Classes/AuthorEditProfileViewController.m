#import "AuthorEditProfileViewController.h"
#import "API.h"
#import "GlobalData.h"
#import "GlobalMethods.h"
#import "CoreDataStoring.h"

@interface AuthorEditProfileViewController () <UITextFieldDelegate>
{
  UIScrollView *uisv_;
  
  UITextField *firstname_,
              *lastname_,
              *phone_,
              *company_,
              *role_;
  
  UIImageView *firstnameAsterix_,
              *lastnameAsterix_,
              *phoneAsterix_,
              *companyAsterix_,
              *roleAsterix_;
}
@end

@implementation AuthorEditProfileViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:[GlobalMethods localizedStringWithKey:@"Close"]
                                                                           style:UIBarButtonItemStylePlain
                                                                          target:self
                                                                          action:@selector(close:)];
  
  uisv_ = [[UIScrollView alloc] initWithFrame:self.view.bounds];
  uisv_.autoresizingMask = (UIViewAutoresizingFlexibleWidth |
                            UIViewAutoresizingFlexibleHeight);
  [self.view addSubview:uisv_];

  CGFloat textFieldWidth = CGRectGetWidth(self.view.bounds) - 100.0f;
  CGFloat textFieldHeight = 37.0f;
  CGFloat textFieldFontsize = 16.0f;
  CGFloat buttonHeight = 60.0f;
  
  NSManagedObject *authorMO = [CoreDataRetrieving authorWithID:[GlobalData authorID]];
  
  // firstname
  firstname_ = [[UITextField alloc] initWithFrame:CGRectMake(60.0f,
                                                             14.0f,
                                                             textFieldWidth,
                                                             textFieldHeight)];
  firstname_.delegate = self;
  firstname_.font = [UIFont fontWithName:@"HelveticaNeue" size:textFieldFontsize];
  firstname_.textColor = [UIColor blackColor];
  firstname_.autocorrectionType = UITextAutocorrectionTypeNo;
  firstname_.autocapitalizationType = UITextAutocapitalizationTypeNone;
  firstname_.placeholder = [GlobalMethods localizedStringWithKey:@"First Name"];
  firstname_.clipsToBounds = NO;
  firstname_.text = [authorMO valueForKey:@"firstname"];
  [uisv_ addSubview:firstname_];
  
  UIImageView *firstnameIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"username"]];
  firstnameIcon.frame = CGRectMake(20.0f,
                                   CGRectGetMinY(firstname_.frame) + 10.0f,
                                   firstnameIcon.image.size.width,
                                   firstnameIcon.image.size.height);
  [uisv_ addSubview:firstnameIcon];
  
  firstnameAsterix_ = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"asterix"]];
  firstnameAsterix_.center = CGPointMake(CGRectGetWidth(firstname_.bounds) + 15.0f, CGRectGetMidY(firstname_.bounds));
  [firstname_ addSubview:firstnameAsterix_];
  
  // division line
  UIView *divisionLine3 = [[UIView alloc] initWithFrame:CGRectMake(0.0f,
                                                                   CGRectGetMaxY(firstname_.frame),
                                                                   CGRectGetWidth(self.view.bounds),
                                                                   1.0f)];
  divisionLine3.backgroundColor = [UIColor colorWithWhite:0.7f alpha:1.0f];
  [uisv_ addSubview:divisionLine3];
  
  // lastname
  lastname_ = [[UITextField alloc] initWithFrame:CGRectMake(60.0f,
                                                            CGRectGetMaxY(firstname_.frame),
                                                            textFieldWidth,
                                                            textFieldHeight)];
  lastname_.delegate = self;
  lastname_.font = [UIFont fontWithName:@"HelveticaNeue" size:textFieldFontsize];
  lastname_.textColor = [UIColor blackColor];
  lastname_.autocorrectionType = UITextAutocorrectionTypeNo;
  lastname_.autocapitalizationType = UITextAutocapitalizationTypeNone;
  lastname_.placeholder = [GlobalMethods localizedStringWithKey:@"Last Name"];
  lastname_.clipsToBounds = NO;
  lastname_.text = [authorMO valueForKey:@"lastname"];
  [uisv_ addSubview:lastname_];
  
  UIImageView *lastnameIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"username"]];
  lastnameIcon.frame = CGRectMake(20.0f,
                                  CGRectGetMinY(lastname_.frame) + 10.0f,
                                  firstnameIcon.image.size.width,
                                  firstnameIcon.image.size.height);
  [uisv_ addSubview:lastnameIcon];
  
  lastnameAsterix_ = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"asterix"]];
  lastnameAsterix_.center = CGPointMake(CGRectGetWidth(lastname_.bounds) + 15.0f, CGRectGetMidY(lastname_.bounds));
  [lastname_ addSubview:lastnameAsterix_];
  
  // division line
  UIView *divisionLine4 = [[UIView alloc] initWithFrame:CGRectMake(0.0f,
                                                                   CGRectGetMaxY(lastname_.frame),
                                                                   CGRectGetWidth(self.view.bounds),
                                                                   1.0f)];
  divisionLine4.backgroundColor = [UIColor colorWithWhite:0.7f alpha:1.0f];
  [uisv_ addSubview:divisionLine4];
  
  // phone
  phone_ = [[UITextField alloc] initWithFrame:CGRectMake(60.0f,
                                                         CGRectGetMaxY(lastname_.frame),
                                                         textFieldWidth,
                                                         textFieldHeight)];
  phone_.delegate = self;
  phone_.font = [UIFont fontWithName:@"HelveticaNeue" size:textFieldFontsize];
  phone_.textColor = [UIColor blackColor];
  phone_.autocorrectionType = UITextAutocorrectionTypeNo;
  phone_.autocapitalizationType = UITextAutocapitalizationTypeNone;
  phone_.placeholder = [GlobalMethods localizedStringWithKey:@"Phone"];
  phone_.clipsToBounds = NO;
  phone_.text = [authorMO valueForKey:@"phone"];
  [uisv_ addSubview:phone_];
  
  UIImageView *phoneIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"phone"]];
  phoneIcon.frame = CGRectMake(20.0f,
                               CGRectGetMinY(phone_.frame) + 10.0f,
                               phoneIcon.image.size.width,
                               phoneIcon.image.size.height);
  [uisv_ addSubview:phoneIcon];
  
  phoneAsterix_ = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"asterix"]];
  phoneAsterix_.center = CGPointMake(CGRectGetWidth(phone_.bounds) + 15.0f, CGRectGetMidY(phone_.bounds));
  [phone_ addSubview:phoneAsterix_];
  
  // division line
  UIView *divisionLine5 = [[UIView alloc] initWithFrame:CGRectMake(0.0f,
                                                                   CGRectGetMaxY(phone_.frame),
                                                                   CGRectGetWidth(self.view.bounds),
                                                                   1.0f)];
  divisionLine5.backgroundColor = [UIColor colorWithWhite:0.7f alpha:1.0f];
  [uisv_ addSubview:divisionLine5];
  
  // company
  company_ = [[UITextField alloc] initWithFrame:CGRectMake(60.0f,
                                                           CGRectGetMaxY(phone_.frame),
                                                           textFieldWidth,
                                                           textFieldHeight)];
  company_.delegate = self;
  company_.font = [UIFont fontWithName:@"HelveticaNeue" size:textFieldFontsize];
  company_.textColor = [UIColor blackColor];
  company_.autocorrectionType = UITextAutocorrectionTypeNo;
  company_.autocapitalizationType = UITextAutocapitalizationTypeNone;
  company_.placeholder = [GlobalMethods localizedStringWithKey:@"Company"];
  company_.clipsToBounds = NO;
  company_.text = [authorMO valueForKey:@"company"];
  [uisv_ addSubview:company_];
  
  UIImageView *companyIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"company"]];
  companyIcon.frame = CGRectMake(20.0f,
                                 CGRectGetMinY(company_.frame) + 10.0f,
                                 firstnameIcon.image.size.width,
                                 firstnameIcon.image.size.height);
  [uisv_ addSubview:companyIcon];
  
  companyAsterix_ = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"asterix"]];
  companyAsterix_.center = CGPointMake(CGRectGetWidth(company_.bounds) + 15.0f, CGRectGetMidY(company_.bounds));
  [company_ addSubview:companyAsterix_];
  
  // division line
  UIView *divisionLine6 = [[UIView alloc] initWithFrame:CGRectMake(0.0f,
                                                                   CGRectGetMaxY(company_.frame),
                                                                   CGRectGetWidth(self.view.bounds),
                                                                   1.0f)];
  divisionLine6.backgroundColor = [UIColor colorWithWhite:0.7f alpha:1.0f];
  [uisv_ addSubview:divisionLine6];
  
  // username
  role_ = [[UITextField alloc] initWithFrame:CGRectMake(60.0f,
                                                        CGRectGetMaxY(company_.frame),
                                                        textFieldWidth,
                                                        textFieldHeight)];
  role_.delegate = self;
  role_.font = [UIFont fontWithName:@"HelveticaNeue" size:textFieldFontsize];
  role_.textColor = [UIColor blackColor];
  role_.autocorrectionType = UITextAutocorrectionTypeNo;
  role_.autocapitalizationType = UITextAutocapitalizationTypeNone;
  role_.enabled = YES;
  role_.placeholder = [GlobalMethods localizedStringWithKey:@"Type"];
  role_.clipsToBounds = NO;
  role_.text = [authorMO valueForKey:@"role"];
  [uisv_ addSubview:role_];
  
  UIImageView *typeIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"job"]];
  typeIcon.frame = CGRectMake(20.0f,
                              CGRectGetMinY(role_.frame) + 10.0f,
                              firstnameIcon.image.size.width,
                              firstnameIcon.image.size.height);
  [uisv_ addSubview:typeIcon];
  
  roleAsterix_ = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"asterix"]];
  roleAsterix_.center = CGPointMake(CGRectGetWidth(role_.bounds) + 15.0f, CGRectGetMidY(role_.bounds));
  [role_ addSubview:roleAsterix_];
  
  // division line
  UIView *divisionLine7 = [[UIView alloc] initWithFrame:CGRectMake(0.0f,
                                                                   CGRectGetMaxY(role_.frame),
                                                                   CGRectGetWidth(self.view.bounds),
                                                                   1.0f)];
  divisionLine7.backgroundColor = [UIColor colorWithWhite:0.7f alpha:1.0f];
  [uisv_ addSubview:divisionLine7];
  
  // signup
  UIButton *update = [[UIButton alloc] initWithFrame:CGRectMake(0.0f,
                                                                CGRectGetMaxY(role_.frame) + 40.0f,
                                                                CGRectGetWidth(self.view.bounds),
                                                                buttonHeight)];
  update.backgroundColor = [UIColor colorWithRed:0 green:0.68 blue:0.95 alpha:1];
  update.showsTouchWhenHighlighted = YES;
  [update setTitle:[GlobalMethods localizedStringWithKey:@"Update"] forState:UIControlStateNormal];
  [update addTarget:self
             action:@selector(update:)
   forControlEvents:UIControlEventTouchUpInside];
  [uisv_ addSubview:update];
  
  uisv_.contentSize = CGSizeMake(0.0f, CGRectGetMaxY(update.frame) + 10.0f);
  
  //
  UITapGestureRecognizer *tapper = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                           action:@selector(handleSingleTap:)];
  tapper.cancelsTouchesInView = NO;
  [uisv_ addGestureRecognizer:tapper];
  
  //
  [self disactivateAllAsterixes];
}

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  
  //
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(apiUserUpdateSuccessful:)
                                               name:apiUserUpdateSuccessfulNotification
                                             object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
  [super viewWillDisappear:animated];
  
  //
  [[NSNotificationCenter defaultCenter] removeObserver:self
                                                  name:apiUserUpdateSuccessfulNotification
                                                object:nil];
}

- (void)handleSingleTap:(UITapGestureRecognizer *) sender
{
  [self.view endEditing:YES];
}

- (void)close:(id)sender
{
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)update:(id)sender
{
  if ([self checkAndActivateAsterixesForMissingFields])
  {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil
                                                                   message:@"Please fill all the missing fields"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Ok"
                                                 style:UIAlertActionStyleCancel
                                               handler:nil];
    
    [alert addAction:ok];
    
    [self presentViewController:alert animated:YES completion:nil];
    
    return;
  }
  
  NSString *role = @"";
  
  if (![role_.text isEqualToString:@""])
  {
    if ([role_.text isEqualToString:[GlobalMethods localizedStringWithKey:@"Distributor"]])
      role = @"distributor";
    
    if ([role_.text isEqualToString:[GlobalMethods localizedStringWithKey:@"Hotel Owner"]])
      role = @"hotel_owner";
    
    if ([role_.text isEqualToString:[GlobalMethods localizedStringWithKey:@"PCO"]])
      role = @"pco";
  }
  
  [API updateUserWithFirstname:firstname_.text
                      lastname:lastname_.text
                         phone:(NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                                                     (CFStringRef)phone_.text,
                                                                                                     NULL,
                                                                                                     CFSTR("!*'();:@&=+$,/?%#[]\" "),
                                                                                                     kCFStringEncodingUTF8))
                       company:company_.text
                          role:role];
}

- (void)disactivateAllAsterixes
{
  firstnameAsterix_.hidden = YES;
  lastnameAsterix_.hidden = YES;
  phoneAsterix_.hidden = YES;
  companyAsterix_.hidden = YES;
  roleAsterix_.hidden = YES;
}

- (BOOL)checkAndActivateAsterixesForMissingFields
{
  BOOL flag = NO;

  if ([firstname_.text isEqualToString:@""])
  {
    flag = YES;
    firstnameAsterix_.hidden = NO;
  }
  else
    firstnameAsterix_.hidden = YES;
  
  if ([lastname_.text isEqualToString:@""])
  {
    flag = YES;
    lastnameAsterix_.hidden = NO;
  }
  else
    lastnameAsterix_.hidden = YES;
  
  if ([phone_.text isEqualToString:@""])
  {
    flag = YES;
    phoneAsterix_.hidden = NO;
  }
  else
    phoneAsterix_.hidden = YES;
  
  if ([company_.text isEqualToString:@""])
  {
    flag = YES;
    companyAsterix_.hidden = NO;
  }
  else
    companyAsterix_.hidden = YES;
  
  if ([role_.text isEqualToString:@""])
  {
    flag = YES;
    roleAsterix_.hidden = NO;
  }
  else
    roleAsterix_.hidden = YES;
  
  return flag;
}

#pragma mark - API notifications callbacks

- (void)apiUserUpdateSuccessful:(NSNotification *)notification
{
  NSDictionary *json = (NSDictionary *)notification.object;
  
  //
  [CoreDataStoring storeAuthor:@{@"authorID": [GlobalData authorID],//json[@"ID"],
                                 @"company": company_.text,
                                 @"firstname": firstname_.text,
                                 @"lastname": lastname_.text,
                                 @"phone": phone_.text,
                                 @"role": role_.text}];
  
  //
  [self close:nil];
}

#pragma mark - UITextField delegate methods implementation

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
  if (textField == role_)
  {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil
                                                                   message:nil
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *distributor = [UIAlertAction actionWithTitle:@"Distributor"
                                                          style:UIAlertActionStyleDefault
                                                        handler:^(UIAlertAction *action) {
                                                          role_.text = @"Distributor";
                                                        }];
    
    [alert addAction:distributor];
    
    UIAlertAction *hotelOwner = [UIAlertAction actionWithTitle:@"Hotel Owner"
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction *action) {
                                                         role_.text = @"Hotel Owner";
                                                       }];
    
    [alert addAction:hotelOwner];
    
    UIAlertAction *pco = [UIAlertAction actionWithTitle:@"PCO"
                                                  style:UIAlertActionStyleDefault
                                                handler:^(UIAlertAction *action) {
                                                  role_.text = @"PCO";
                                                }];
    
    [alert addAction:pco];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:[GlobalMethods localizedStringWithKey:@"Cancel"]
                                                     style:UIAlertActionStyleDestructive
                                                   handler:nil];
    
    [alert addAction:cancel];
    
    [self presentViewController:alert animated:YES completion:nil];
    
    return NO;
  }
  
  return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
  return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
  [textField resignFirstResponder];
  
  return YES;
}

@end