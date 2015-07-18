#import "NewPropertyFormSuperViewController.h"

@implementation NewPropertyFormSuperViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  self.uisv = [[UIScrollView alloc] initWithFrame:self.view.bounds];
  self.uisv.autoresizingMask = (UIViewAutoresizingFlexibleWidth |
                                UIViewAutoresizingFlexibleHeight);
  [self.view addSubview:self.uisv];
}

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  
  // register the UIKeyboard notifications
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(keyboardWillShow:)
                                               name:UIKeyboardWillShowNotification
                                             object:nil];
  
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(keyboardWillHide:)
                                               name:UIKeyboardWillHideNotification
                                             object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
  [super viewWillDisappear:animated];
  
  // register the UIKeyboard notifications
  [[NSNotificationCenter defaultCenter] removeObserver:self
                                                  name:UIKeyboardWillShowNotification
                                                object:nil];
  
  [[NSNotificationCenter defaultCenter] removeObserver:self
                                                  name:UIKeyboardWillHideNotification
                                                object:nil];
}

#pragma mark - UIKeyboard delegate methods implementation

- (void)keyboardWillShow:(NSNotification *)notification
{
  NSDictionary *info = [notification userInfo];
  
  CGSize keyboardSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
  
  self.uisv.contentInset = UIEdgeInsetsMake(0.0f,
                                            0.0f,
                                            keyboardSize.height - 64.0f,
                                            0.0f);
}

- (void)keyboardWillHide:(NSNotification *)notification
{
  self.uisv.contentInset = UIEdgeInsetsZero;
}

@end