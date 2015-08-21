#import "SuperViewController.h"

@interface SuperViewController ()
@end

@implementation SuperViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  self.view.clipsToBounds = YES;
  self.view.backgroundColor = [UIColor colorWithRed:0.91 green:0.9 blue:0.9 alpha:1];
}

@end