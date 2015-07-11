#import "SuperViewController.h"

@interface SuperViewController ()
@end

@implementation SuperViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  // UI customizations
  UIImageView *background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bkg"]];
  background.contentMode = UIViewContentModeScaleAspectFill;
  [self.view addSubview:background];
}

@end