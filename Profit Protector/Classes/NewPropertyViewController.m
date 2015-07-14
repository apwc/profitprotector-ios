#import "NewPropertyViewController.h"
#import "NewPropertyForm1ViewController.h"
#import "NewPropertyForm2ViewController.h"
#import "NewPropertyForm3ViewController.h"
#import "NewPropertyForm4ViewController.h"
#import "NewPropertyForm5ViewController.h"
#import "NewPropertyForm6ViewController.h"

@interface NewPropertyViewController ()
{
  UIPageControl *uipc_;
}
@end

@implementation NewPropertyViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  // UI customizations
  self.view.backgroundColor = [UIColor whiteColor];
  
  //
  UIToolbar *uit = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0f,
                                                               0.0f,
                                                               CGRectGetWidth(self.view.frame),
                                                               64.0f)];
  uit.items = @[[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                              target:nil
                                                              action:nil],
                [[UIBarButtonItem alloc] initWithTitle:@"Close"
                                                 style:UIBarButtonItemStylePlain
                                                target:self
                                                action:@selector(close:)]];
  [self.view addSubview:uit];
  
  // ivars
  CGFloat buttonWidth = 90.0f;
  CGFloat buttonHeight = 60.0f;
  
  //
  UIScrollView *uisv = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0,
                                                                      CGRectGetMaxY(uit.frame),
                                                                      CGRectGetWidth(self.view.bounds),
                                                                      CGRectGetHeight(self.view.bounds) - buttonHeight - CGRectGetMaxY(uit.frame))];
  uisv.pagingEnabled = YES;
  [self.view addSubview:uisv];
  
  for (int i = 0; i<6; i++)
  {
    NSString *class = [NSString stringWithFormat:@"NewPropertyForm%dViewController", i + 1];
    
    id abstract = NSClassFromString(class);
    
    id vc = [[abstract alloc] initWithNibName:nil bundle:nil];
    
    [[vc view] setFrame:CGRectMake(CGRectGetWidth(uisv.bounds) * i,
                                   0.0f,
                                   CGRectGetWidth(uisv.bounds),
                                   CGRectGetHeight(uisv.bounds))];
    
    [uisv addSubview:[vc view]];
  }
  
  uisv.contentSize = CGSizeMake(CGRectGetWidth(uisv.bounds) * 6.0f,
                                CGRectGetHeight(uisv.bounds));
  
  //
  UIView *bottomBand = [[UIView alloc] initWithFrame:CGRectMake(0.0f,
                                                                CGRectGetHeight(self.view.bounds) - buttonHeight,
                                                                CGRectGetWidth(self.view.bounds),
                                                                buttonHeight)];
  bottomBand.backgroundColor = [UIColor colorWithRed:0 green:0.68 blue:0.95 alpha:1];
  [self.view addSubview:bottomBand];
  
  // back
  UIButton *back = [[UIButton alloc] initWithFrame:CGRectMake(0.0f,
                                                              0.0f,
                                                              buttonWidth,
                                                              CGRectGetHeight(bottomBand.frame))];
  back.showsTouchWhenHighlighted = YES;
  [back setTitle:@"Back" forState:UIControlStateNormal];
  [back addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
  [bottomBand addSubview:back];
  
  // next
  UIButton *next = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth(bottomBand.bounds) - buttonWidth,
                                                              0.0f,
                                                              buttonWidth,
                                                              CGRectGetHeight(bottomBand.frame))];
  next.showsTouchWhenHighlighted = YES;
  [next setTitle:@"Next" forState:UIControlStateNormal];
  [next addTarget:self action:@selector(next:) forControlEvents:UIControlEventTouchUpInside];
  [bottomBand addSubview:next];

  //
  uipc_ = [[UIPageControl alloc] initWithFrame:CGRectMake(buttonWidth,
                                                          0.0f,
                                                          CGRectGetWidth(self.view.bounds) - (buttonWidth * 2.0f),
                                                          CGRectGetHeight(bottomBand.frame))];
  uipc_.pageIndicatorTintColor = [UIColor colorWithWhite:0.0f alpha:0.3f];
  uipc_.currentPageIndicatorTintColor = [UIColor whiteColor];
  uipc_.numberOfPages = 6;
  [bottomBand addSubview:uipc_];
}

- (void)close:(UIBarButtonItem *)uibbi
{
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)back:(UIButton *)uib
{
}

- (void)next:(UIButton *)uib
{
}

@end