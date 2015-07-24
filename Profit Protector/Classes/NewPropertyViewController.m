#import "NewPropertyViewController.h"
#import "CoreDataStoring.h"
#import "PropertyTypeTableViewController.h"
#import "NewPropertyForm1ViewController.h"
#import "NewPropertyForm2ViewController.h"
#import "NewPropertyForm3ViewController.h"
#import "NewPropertyForm4ViewController.h"
#import "NewPropertyForm5ViewController.h"
#import "NewPropertyForm6ViewController.h"
#import "NewPropertyForm7ViewController.h"

@interface NewPropertyViewController () <PropertyTypeDelegate,
                                         UIScrollViewDelegate>
{
  UIScrollView  *uisv_;
  UIPageControl *uipc_;
  
  NewPropertyForm1ViewController *npf1vc_;
  NewPropertyForm2ViewController *npf2vc_;
  NewPropertyForm3ViewController *npf3vc_;
  NewPropertyForm4ViewController *npf4vc_;
  NewPropertyForm5ViewController *npf5vc_;
  NewPropertyForm6ViewController *npf6vc_;
  NewPropertyForm7ViewController *npf7vc_;
}
@end

@implementation NewPropertyViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  // UI customizations
  self.view.backgroundColor = [UIColor whiteColor];
  
  self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Save"
                                                                            style:UIBarButtonItemStylePlain
                                                                           target:self
                                                                           action:@selector(save:)];
  
  // ivars
  CGFloat buttonWidth = 90.0f;
  CGFloat buttonHeight = 60.0f;
  
  //
  uisv_ = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0,
                                                         0.0f,
                                                         CGRectGetWidth(self.view.bounds),
                                                         CGRectGetHeight(self.view.bounds) - buttonHeight)];
  uisv_.delegate = self;
  uisv_.pagingEnabled = YES;
  [self.view addSubview:uisv_];
  
  //
  npf1vc_ = [[NewPropertyForm1ViewController alloc] initWithNibName:nil
                                                             bundle:nil];
  npf1vc_.view.frame = CGRectMake(CGRectGetWidth(uisv_.bounds) * 0,
                                  0.0f,
                                  CGRectGetWidth(uisv_.bounds),
                                  CGRectGetHeight(uisv_.bounds) - buttonHeight);
  [npf1vc_.propertyType addTarget:self action:@selector(propertyType:) forControlEvents:UIControlEventTouchUpInside];
  [uisv_ addSubview:npf1vc_.view];
  
  //
  npf2vc_ = [[NewPropertyForm2ViewController alloc] initWithNibName:nil
                                                             bundle:nil];
  npf2vc_.view.frame = CGRectMake(CGRectGetWidth(uisv_.bounds) * 1.0f,
                                  0.0f,
                                  CGRectGetWidth(uisv_.bounds),
                                  CGRectGetHeight(uisv_.bounds) - buttonHeight);
  [uisv_ addSubview:npf2vc_.view];
  
  //
  npf3vc_ = [[NewPropertyForm3ViewController alloc] initWithNibName:nil
                                                             bundle:nil];
  npf3vc_.view.frame = CGRectMake(CGRectGetWidth(uisv_.bounds) * 2.0f,
                                  0.0f,
                                  CGRectGetWidth(uisv_.bounds),
                                  CGRectGetHeight(uisv_.bounds) - buttonHeight);
  [uisv_ addSubview:npf3vc_.view];
  
  //
  npf4vc_ = [[NewPropertyForm4ViewController alloc] initWithNibName:nil
                                                             bundle:nil];
  npf4vc_.view.frame = CGRectMake(CGRectGetWidth(uisv_.bounds) * 3.0f,
                                  0.0f,
                                  CGRectGetWidth(uisv_.bounds),
                                  CGRectGetHeight(uisv_.bounds) - buttonHeight);
  [uisv_ addSubview:npf4vc_.view];
  
  //
  npf5vc_ = [[NewPropertyForm5ViewController alloc] initWithNibName:nil
                                                             bundle:nil];
  npf5vc_.view.frame = CGRectMake(CGRectGetWidth(uisv_.bounds) * 4.0f,
                                  0.0f,
                                  CGRectGetWidth(uisv_.bounds),
                                  CGRectGetHeight(uisv_.bounds) - buttonHeight);
  [uisv_ addSubview:npf5vc_.view];
  
  //
  npf6vc_ = [[NewPropertyForm6ViewController alloc] initWithNibName:nil
                                                             bundle:nil];
  npf6vc_.view.frame = CGRectMake(CGRectGetWidth(uisv_.bounds) * 5.0f,
                                  0.0f,
                                  CGRectGetWidth(uisv_.bounds),
                                  CGRectGetHeight(uisv_.bounds) - buttonHeight);
  [uisv_ addSubview:npf6vc_.view];
  
  //
  npf7vc_ = [[NewPropertyForm7ViewController alloc] initWithNibName:nil
                                                             bundle:nil];
  npf7vc_.view.frame = CGRectMake(CGRectGetWidth(uisv_.bounds) * 6.0f,
                                  0.0f,
                                  CGRectGetWidth(uisv_.bounds),
                                  CGRectGetHeight(uisv_.bounds) - buttonHeight);
  [uisv_ addSubview:npf7vc_.view];
  
  uisv_.contentSize = CGSizeMake(CGRectGetWidth(uisv_.bounds) * 7.0f,
                                 1.0f);
  
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
  uipc_.numberOfPages = 7;
  [bottomBand addSubview:uipc_];
}

- (void)save:(UIBarButtonItem *)uibbi
{
  [CoreDataStoring storeProperty:@{@"name": npf1vc_.textField.text,
                                   @"propertyType": npf1vc_.propertyType.titleLabel.text,
                                   
                                   npf2vc_.scvA.key: npf2vc_.scvA.value,
                                   npf2vc_.scvB.key: npf2vc_.scvB.value,
                                   
                                   npf3vc_.scvA.key: npf3vc_.scvA.value,
                                   npf3vc_.scvB.key: npf3vc_.scvB.value,
                                   npf3vc_.scvC.key: npf3vc_.scvC.value,
                                   
                                   npf4vc_.scvA.key: npf4vc_.scvA.value,
                                   npf4vc_.scvB.key: npf4vc_.scvB.value,
                                   
                                   npf5vc_.scvA.key: npf5vc_.scvA.value,
                                   
                                   npf6vc_.scvA.key: npf6vc_.scvA.value,
                                   npf6vc_.scvB.key: npf6vc_.scvB.value,
                                   npf6vc_.scvC.key: npf6vc_.scvC.value,
                                   //npf6vc_.scvD.key: npf6vc_.scvD.value,
                                   
                                   npf7vc_.scvA.key: npf7vc_.scvA.value,
                                   npf7vc_.scvB.key: npf7vc_.scvB.value}];
  
  [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)back:(UIButton *)uib
{
  [uisv_ scrollRectToVisible:CGRectMake(CGRectGetWidth(self.view.bounds) * (uipc_.currentPage - 1),
                                        0.0f,
                                        CGRectGetWidth(self.view.bounds),
                                        1.0f)
                    animated:YES];
}

- (void)next:(UIButton *)uib
{
  [uisv_ scrollRectToVisible:CGRectMake(CGRectGetWidth(self.view.bounds) * (uipc_.currentPage + 1),
                                        0.0f,
                                        CGRectGetWidth(self.view.bounds),
                                        1.0f)
                    animated:YES];
}

- (void)propertyType:(UIButton *)uib
{
  PropertyTypeTableViewController *ptvc = [[PropertyTypeTableViewController alloc] initWithStyle:UITableViewStylePlain];
  ptvc.delegate = self;
  
  [self.navigationController pushViewController:ptvc animated:YES];
}

#pragma mark - PropertyTypeDelegate delegate methods implementation

- (void)propertyTypeDidSelect:(NSString *)propertyType
{
  [npf1vc_.propertyType setTitle:propertyType forState:UIControlStateNormal];
}

#pragma mark - UIScrollView delegate methods implementation

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
  uipc_.currentPage = scrollView.contentOffset.x / CGRectGetWidth(self.view.bounds);
}

@end