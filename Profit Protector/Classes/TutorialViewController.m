#import "TutorialViewController.h"
#import "Constants.h"

@interface TutorialViewController ()
{
  UIPageControl *uipc_;
  
  UIButton      *next_;
}
@end

@implementation TutorialViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  // UI customizations
  self.view.backgroundColor = [UIColor whiteColor];
  
  CGFloat buttonHeight = 60.0f;
  
  UIScrollView *uisv = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0,
                                                                      20.0f,
                                                                      CGRectGetWidth(self.view.bounds),
                                                                      CGRectGetHeight(self.view.bounds) - buttonHeight - 20.0f)];
  [self.view addSubview:uisv];
  
  uipc_ = [[UIPageControl alloc] initWithFrame:CGRectMake(0.0f,
                                                          40.0f,
                                                          CGRectGetWidth(self.view.bounds),
                                                          32.0f)];
  uipc_.pageIndicatorTintColor = [UIColor colorWithWhite:0.7f alpha:1.0f];
  uipc_.currentPageIndicatorTintColor = [UIColor colorWithRed:0 green:0.68 blue:0.95 alpha:1];
  uipc_.numberOfPages = 4;
  [self.view addSubview:uipc_];
  
  // signup
  next_ = [[UIButton alloc] initWithFrame:CGRectMake(0.0f,
                                                     CGRectGetHeight(self.view.bounds) - buttonHeight,
                                                     CGRectGetWidth(self.view.bounds),
                                                     buttonHeight)];
  next_.backgroundColor = [UIColor colorWithRed:0 green:0.68 blue:0.95 alpha:1];
  next_.showsTouchWhenHighlighted = YES;
  [next_ setTitle:@"Next" forState:UIControlStateNormal];
  [next_ addTarget:self
            action:@selector(next:)
  forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:next_];
}

- (void)next:(UIButton *)uib
{
  [[NSNotificationCenter defaultCenter] postNotificationName:displayMainViewControllerNotification
                                                      object:nil];
}

@end