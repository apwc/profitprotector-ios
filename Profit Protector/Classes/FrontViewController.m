#import "FrontViewController.h"

@interface FrontViewController ()
@end

@implementation FrontViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  // UI customizations
  self.view.backgroundColor = [UIColor redColor];

  self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction
                                                                                        target:self
                                                                                        action:@selector(showLeftViewController:)];
}

- (void)showLeftViewController:(UIBarButtonItem *)uibbi
{
}

@end