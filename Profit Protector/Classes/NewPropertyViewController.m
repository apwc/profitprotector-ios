#import "NewPropertyViewController.h"
#import "CoreDataStoring.h"
#import "GlobalData.h"
#import "API.h"
#import "PropertyTypeTableViewController.h"
#import "NewPropertyForm1ViewController.h"
#import "NewPropertyForm2ViewController.h"
#import "NewPropertyForm3ViewController.h"
#import "NewPropertyForm4ViewController.h"
#import "NewPropertyForm5ViewController.h"
#import "NewPropertyForm6ViewController.h"
#import "NewPropertyForm7ViewController.h"
#import "NewPropertyForm8ViewController.h"

@interface NewPropertyViewController () <PropertyTypeDelegate,
                                         UIScrollViewDelegate>
{
  UIScrollView                    *uisv_;
  UIPageControl                   *uipc_;
  
  NewPropertyForm1ViewController  *npf1vc_;
  NewPropertyForm2ViewController  *npf2vc_;
  NewPropertyForm3ViewController  *npf3vc_;
  NewPropertyForm4ViewController  *npf4vc_;
  NewPropertyForm5ViewController  *npf5vc_;
  NewPropertyForm6ViewController  *npf6vc_;
  NewPropertyForm7ViewController  *npf7vc_;
  NewPropertyForm8ViewController  *npf8vc_;
  
  UIButton                        *back_,
                                  *next_;
}
@end

@implementation NewPropertyViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  // UI customizations
  self.view.backgroundColor = [UIColor whiteColor];
  
  if ([self.navigationController.viewControllers count] == 1)
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:[GlobalMethods localizedStringWithKey:@"Cancel"]
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(cancel:)];
  else
  {
    [self.navigationItem hidesBackButton];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:[GlobalMethods localizedStringWithKey:@"Exit"]
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(exit:)];
  }
  
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
  
  if (self.property)
  {
    npf1vc_.textField.text = [self.property valueForKey:@"name"];
    [npf1vc_.propertyType setTitle:[self.property valueForKey:@"propertyType"] forState:UIControlStateNormal];
  }
  
  [uisv_ addSubview:npf1vc_.view];
  
  //
  npf2vc_ = [[NewPropertyForm2ViewController alloc] initWithNibName:nil
                                                             bundle:nil];
  npf2vc_.view.frame = CGRectMake(CGRectGetWidth(uisv_.bounds) * 1.0f,
                                  0.0f,
                                  CGRectGetWidth(uisv_.bounds),
                                  CGRectGetHeight(uisv_.bounds) - buttonHeight);
  
  if (self.property)
  {
    npf2vc_.scvA.value = [self.property valueForKey:@"roomsNumber"];
    npf2vc_.scvB.value = [self.property valueForKey:@"bedsNumber"];
    npf2vc_.scvC.value = [self.property valueForKey:@"occupancyRate"];
  }
  
  [uisv_ addSubview:npf2vc_.view];
  
  //
  npf3vc_ = [[NewPropertyForm3ViewController alloc] initWithNibName:nil
                                                             bundle:nil];
  npf3vc_.view.frame = CGRectMake(CGRectGetWidth(uisv_.bounds) * 2.0f,
                                  0.0f,
                                  CGRectGetWidth(uisv_.bounds),
                                  CGRectGetHeight(uisv_.bounds) - buttonHeight);
  
  if (self.property)
  {
    npf3vc_.scvA.value = [self.property valueForKey:@"roomRevenuePerNight"];
    npf3vc_.scvB.value = [self.property valueForKey:@"foodBeverageSalesPerRoomPerNight"];
    npf3vc_.scvC.value = [self.property valueForKey:@"ancillariesRevenuePerRoomPerNight"];
  }
  
  [uisv_ addSubview:npf3vc_.view];
  
  //
  npf4vc_ = [[NewPropertyForm4ViewController alloc] initWithNibName:nil
                                                             bundle:nil];
  npf4vc_.view.frame = CGRectMake(CGRectGetWidth(uisv_.bounds) * 3.0f,
                                  0.0f,
                                  CGRectGetWidth(uisv_.bounds),
                                  CGRectGetHeight(uisv_.bounds) - buttonHeight);
  
  if (self.property)
  {
    npf4vc_.scvA.value = [self.property valueForKey:@"costOfReplaceMattressesAndBoxSpring"];
    npf4vc_.scvB.value = [self.property valueForKey:@"costOfReplaceFurnishings"];
  }
  
  [uisv_ addSubview:npf4vc_.view];
  
  //
  npf5vc_ = [[NewPropertyForm5ViewController alloc] initWithNibName:nil
                                                             bundle:nil];
  npf5vc_.view.frame = CGRectMake(CGRectGetWidth(uisv_.bounds) * 4.0f,
                                  0.0f,
                                  CGRectGetWidth(uisv_.bounds),
                                  CGRectGetHeight(uisv_.bounds) - buttonHeight);
  
  if (self.property)
    npf5vc_.scvA.value = [self.property valueForKey:@"percentageOfMattressesReplaceEachYear"];
  
  [uisv_ addSubview:npf5vc_.view];
  
  //
  npf6vc_ = [[NewPropertyForm6ViewController alloc] initWithNibName:nil
                                                             bundle:nil];
  npf6vc_.view.frame = CGRectMake(CGRectGetWidth(uisv_.bounds) * 5.0f,
                                  0.0f,
                                  CGRectGetWidth(uisv_.bounds),
                                  CGRectGetHeight(uisv_.bounds) - buttonHeight);
  
  if (self.property)
  {
    npf6vc_.scvA.value = [self.property valueForKey:@"timesPerYearBedClean"];
    npf6vc_.scvB.value = [self.property valueForKey:@"costToCleanAndReinstallEncasements"];
    npf6vc_.scvC.value = [self.property valueForKey:@"bedBugIncidents"];
    npf6vc_.scvD.value = [self.property valueForKey:@"grievanceCosts"];
  }
  
  [uisv_ addSubview:npf6vc_.view];
  
  //
  npf7vc_ = [[NewPropertyForm7ViewController alloc] initWithNibName:nil
                                                             bundle:nil];
  npf7vc_.view.frame = CGRectMake(CGRectGetWidth(uisv_.bounds) * 6.0f,
                                  0.0f,
                                  CGRectGetWidth(uisv_.bounds),
                                  CGRectGetHeight(uisv_.bounds) - buttonHeight);
  
  if (self.property)
    npf7vc_.scvA.value = [self.property valueForKey:@"futureBookingDaysLost"];
  
  [uisv_ addSubview:npf7vc_.view];
  
  //
  npf8vc_ = [[NewPropertyForm8ViewController alloc] initWithNibName:nil
                                                             bundle:nil];
  npf8vc_.view.frame = CGRectMake(CGRectGetWidth(uisv_.bounds) * 7.0f,
                                  0.0f,
                                  CGRectGetWidth(uisv_.bounds),
                                  CGRectGetHeight(uisv_.bounds) - buttonHeight);
  
  if (self.property)
    npf8vc_.scvA.value = [self.property valueForKey:@"preemptivePestControlRetainer"];
  
  [npf8vc_.finish addTarget:self action:@selector(save:) forControlEvents:UIControlEventTouchUpInside];
  [uisv_ addSubview:npf8vc_.view];
  
  uisv_.contentSize = CGSizeMake(CGRectGetWidth(uisv_.bounds) * 8.0f,
                                 1.0f);
  
  //
  UIView *bottomBand = [[UIView alloc] initWithFrame:CGRectMake(0.0f,
                                                                CGRectGetHeight(self.view.bounds) - buttonHeight,
                                                                CGRectGetWidth(self.view.bounds),
                                                                buttonHeight)];
  bottomBand.backgroundColor = [UIColor colorWithRed:0 green:0.68 blue:0.95 alpha:1];
  [self.view addSubview:bottomBand];
  
  // back
  back_ = [[UIButton alloc] initWithFrame:CGRectMake(0.0f,
                                                     0.0f,
                                                     buttonWidth,
                                                     CGRectGetHeight(bottomBand.frame))];
  back_.showsTouchWhenHighlighted = YES;
  [back_ setTitle:[GlobalMethods localizedStringWithKey:@"Back"] forState:UIControlStateNormal];
  [back_ addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
  [back_ setTitleColor:[UIColor colorWithWhite:1.0f alpha:0.2f] forState:UIControlStateDisabled];
  [back_ setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
  [bottomBand addSubview:back_];
  
  // next
  next_ = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth(bottomBand.bounds) - buttonWidth,
                                                     0.0f,
                                                     buttonWidth,
                                                     CGRectGetHeight(bottomBand.frame))];
  next_.showsTouchWhenHighlighted = YES;
  [next_ setTitle:[GlobalMethods localizedStringWithKey:@"Next"] forState:UIControlStateNormal];
  [next_ addTarget:self action:@selector(next:) forControlEvents:UIControlEventTouchUpInside];
  [next_ setTitleColor:[UIColor colorWithWhite:1.0f alpha:0.2f] forState:UIControlStateDisabled];
  [next_ setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
  [bottomBand addSubview:next_];

  //
  uipc_ = [[UIPageControl alloc] initWithFrame:CGRectMake(buttonWidth,
                                                          0.0f,
                                                          CGRectGetWidth(self.view.bounds) - (buttonWidth * 2.0f),
                                                          CGRectGetHeight(bottomBand.frame))];
  uipc_.pageIndicatorTintColor = [UIColor colorWithWhite:0.0f alpha:0.3f];
  uipc_.currentPageIndicatorTintColor = [UIColor whiteColor];
  uipc_.numberOfPages = 8;
  [bottomBand addSubview:uipc_];
  
  //
  UITapGestureRecognizer *tapper = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                           action:@selector(handleSingleTap:)];
  tapper.cancelsTouchesInView = NO;
  [self.view addGestureRecognizer:tapper];
}

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  
  //
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(apiUserPropertyStoreSuccessful:)
                                               name:apiUserPropertyStoreSuccessfulNotification
                                             object:nil];
  
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(apiUserPropertyUpdateSuccessful:)
                                               name:apiUserPropertyUpdateSuccessfulNotification
                                             object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
  [super viewWillDisappear:animated];
  
  [[NSNotificationCenter defaultCenter] removeObserver:self
                                                  name:apiUserPropertyStoreSuccessfulNotification
                                                object:nil];
  
  [[NSNotificationCenter defaultCenter] removeObserver:self
                                                  name:apiUserPropertyUpdateSuccessfulNotification
                                                object:nil];
}

- (void)handleSingleTap:(UITapGestureRecognizer *) sender
{
  [self.view endEditing:YES];
}

- (void)exit:(UIBarButtonItem *)uibbi
{
  [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)cancel:(UIBarButtonItem *)uibbi
{
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)save:(UIBarButtonItem *)uibbi
{
  UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Profit Protector"
                                                                 message:@"You cannot save because some fields are missing"
                                                          preferredStyle:UIAlertControllerStyleAlert];
  
  UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:[GlobalMethods localizedStringWithKey:@"Cancel"]
                                                         style:UIAlertActionStyleDestructive
                                                       handler:nil];
  
  [alert addAction:cancelAction];
  
  if ([npf1vc_.textField.text isEqualToString:@""] ||
      
      [npf2vc_.scvA.value isEqualToNumber:@(-1)] ||
      [npf2vc_.scvB.value isEqualToNumber:@(-1)] ||
      [npf2vc_.scvC.value isEqualToNumber:@(-1)] ||
      
      [npf3vc_.scvA.value isEqualToNumber:@(-1)] ||
      [npf3vc_.scvB.value isEqualToNumber:@(-1)] ||
      [npf3vc_.scvC.value isEqualToNumber:@(-1)] ||
      
      [npf4vc_.scvA.value isEqualToNumber:@(-1)] ||
      [npf4vc_.scvB.value isEqualToNumber:@(-1)] ||
      
      [npf5vc_.scvA.value isEqualToNumber:@(-1)] ||
      
      [npf6vc_.scvA.value isEqualToNumber:@(-1)] ||
      [npf6vc_.scvB.value isEqualToNumber:@(-1)] ||
      [npf6vc_.scvC.value isEqualToNumber:@(-1)] ||
      [npf6vc_.scvD.value isEqualToNumber:@(-1)] ||
      
      [npf7vc_.scvA.value isEqualToNumber:@(-1)] ||
      
      [npf8vc_.scvA.value isEqualToNumber:@(-1)])
  {
    [self presentViewController:alert animated:YES completion:nil];
    
    return;
  }
  
  // reset the global values
  GlobalData *gd = [GlobalData singleton];
  gd.numberOfBeds = -1.0f;
  gd.percentage = -1.0f;
  gd.costPerBed = -1.0f;
  gd.propertyType = None;
  
  NSDictionary *token = @{@"name": npf1vc_.textField.text,
                          @"propertyType": npf1vc_.propertyType.titleLabel.text,
                          
                          npf2vc_.scvA.key: npf2vc_.scvA.value,
                          npf2vc_.scvB.key: npf2vc_.scvB.value,
                          npf2vc_.scvC.key: npf2vc_.scvC.value,
                          
                          npf3vc_.scvA.key: npf3vc_.scvA.value,
                          npf3vc_.scvB.key: npf3vc_.scvB.value,
                          npf3vc_.scvC.key: npf3vc_.scvC.value,
                          
                          npf4vc_.scvA.key: npf4vc_.scvA.value,
                          npf4vc_.scvB.key: npf4vc_.scvB.value,
                          
                          npf5vc_.scvA.key: npf5vc_.scvA.value,
                          
                          npf6vc_.scvA.key: npf6vc_.scvA.value,
                          npf6vc_.scvB.key: npf6vc_.scvB.value,
                          npf6vc_.scvC.key: npf6vc_.scvC.value,
                          npf6vc_.scvD.key: npf6vc_.scvD.value,
                          
                          npf7vc_.scvA.key: npf7vc_.scvA.value,
                          
                          npf8vc_.scvA.key: npf8vc_.scvA.value};
  
  if (self.property)
  {
    [API updateUploadedProperty:[self.property valueForKey:@"propertyID"]
                          title:npf1vc_.textField.text
                     contentRaw:npf1vc_.textField.text
                         author:[GlobalData authorID]
                       postMeta:token];
  }
  else
  {
    [API uploadPropertyWithTitle:npf1vc_.textField.text
                      contentRaw:npf1vc_.textField.text
                          author:[GlobalData authorID]
                        postMeta:token];
  }
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

#pragma mark - API notifications callbacks

- (void)apiUserPropertyStoreSuccessful:(NSNotification *)notification
{
  NSDictionary *token = (NSDictionary *)notification.object;
  
  [CoreDataStoring storeProperty:token];
  
  [self dismissViewControllerAnimated:YES
                           completion:^{
                             [[NSNotificationCenter defaultCenter] postNotificationName:displaySelectedPropertyNotification
                                                                                 object:token];
                           }];
}

- (void)apiUserPropertyUpdateSuccessful:(NSNotification *)notification
{
  NSDictionary *dictionary = (NSDictionary *)notification.object;
  
  [self.property setValue:dictionary[@"ID"] forKey:@"propertyID"];
  
  [self.property setValue:dictionary[@"title"] forKey:@"name"];
  
  [self.property setValue:dictionary[@"author"][@"ID"] forKey:@"authorID"];
  
  NSArray *postMeta = dictionary[@"post_meta"];
  
  [postMeta enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
    NSDictionary *meta = (NSDictionary *)obj;
    
    if ([meta[@"key"] isEqualToString:@"ancillariesRevenuePerRoomPerNight"])
    {
      [self.property setValue:@([meta[@"value"] doubleValue])
                       forKey:meta[@"key"]];
    }
    
    if ([meta[@"key"] isEqualToString:@"bedBugIncidents"])
    {
      [self.property setValue:@([meta[@"value"] integerValue])
                       forKey:meta[@"key"]];
    }
    
    if ([meta[@"key"] isEqualToString:@"bedsNumber"])
    {
      [self.property setValue:@([meta[@"value"] integerValue])
                       forKey:meta[@"key"]];
    }
    
    if ([meta[@"key"] isEqualToString:@"bugInspectionAndPestControlFees"])
    {
      [self.property setValue:@([meta[@"value"] doubleValue])
                       forKey:meta[@"key"]];
    }
    
    if ([meta[@"key"] isEqualToString:@"costOfReplaceFurnishings"])
    {
      [self.property setValue:@([meta[@"value"] doubleValue])
                       forKey:meta[@"key"]];
    }
    
    if ([meta[@"key"] isEqualToString:@"occupancyRate"])
    {
      [self.property setValue:@([meta[@"value"] doubleValue])
                       forKey:meta[@"key"]];
    }
    
    if ([meta[@"key"] isEqualToString:@"costOfReplaceMattressesAndBoxSpring"])
    {
      [self.property setValue:@([meta[@"value"] doubleValue])
                       forKey:meta[@"key"]];
    }
    
    if ([meta[@"key"] isEqualToString:@"costToCleanAndReinstallEncasements"])
    {
      [self.property setValue:@([meta[@"value"] doubleValue])
                       forKey:meta[@"key"]];
    }
    
    if ([meta[@"key"] isEqualToString:@"favorite"])
    {
      [self.property setValue:@([meta[@"value"] boolValue])
                       forKey:meta[@"key"]];
    }
    
    if ([meta[@"key"] isEqualToString:@"foodBeverageSalesPerRoomPerNight"])
    {
      [self.property setValue:@([meta[@"value"] doubleValue])
                       forKey:meta[@"key"]];
    }
    
    if ([meta[@"key"] isEqualToString:@"futureBookingDaysLost"])
    {
      [self.property setValue:@([meta[@"value"] integerValue])
                       forKey:meta[@"key"]];
    }
    
    if ([meta[@"key"] isEqualToString:@"grievanceCosts"])
    {
      [self.property setValue:@([meta[@"value"] integerValue])
                       forKey:meta[@"key"]];
    }
    
    if ([meta[@"key"] isEqualToString:@"preemptivePestControlRetainer"])
    {
      [self.property setValue:@([meta[@"value"] doubleValue])
                       forKey:meta[@"key"]];
    }
    
    if ([meta[@"key"] isEqualToString:@"percentageOfMattressesReplaceEachYear"])
    {
      [self.property setValue:@([meta[@"value"] doubleValue])
                       forKey:meta[@"key"]];
    }
    
    if ([meta[@"key"] isEqualToString:@"propertyType"])
    {
      [self.property setValue:meta[@"value"]
                       forKey:meta[@"key"]];
    }
    
    if ([meta[@"key"] isEqualToString:@"roomRevenuePerNight"])
    {
      [self.property setValue:@([meta[@"value"] doubleValue])
                       forKey:meta[@"key"]];
    }
    
    if ([meta[@"key"] isEqualToString:@"roomsNumber"])
    {
      [self.property setValue:@([meta[@"value"] integerValue])
                       forKey:meta[@"key"]];
    }
    
    if ([meta[@"key"] isEqualToString:@"timesPerYearBedClean"])
    {
      [self.property setValue:@([meta[@"value"] integerValue])
                       forKey:meta[@"key"]];
    }
  }];
  
  CoreDataManager *cdm = [CoreDataManager singleton];
  [cdm.managedObjectContext save:nil];
  
  [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - PropertyTypeDelegate delegate methods implementation

- (void)propertyTypeDidSelect:(PropertyType)propertyType
{
  [npf1vc_.propertyType setTitle:propertyType == Full ? [GlobalMethods localizedStringWithKey:@"Full Service"] : [GlobalMethods localizedStringWithKey:@"Select Service"]
                        forState:UIControlStateNormal];
  
  GlobalData *gd = [GlobalData singleton];
  gd.propertyType = propertyType;
  
  if ([npf3vc_.scvA.value integerValue] == -1)
    npf3vc_.scvA.value = gd.propertyType == Full ? @(150) : @(66);
  
  if ([npf3vc_.scvB.value integerValue] == -1)
    npf3vc_.scvB.value = gd.propertyType == Full ? @(57) : @(10);
  
  if ([npf3vc_.scvC.value integerValue] == -1)
    npf3vc_.scvC.value = gd.propertyType == Full ? @(17) : @(0);
}

#pragma mark - UIScrollView delegate methods implementation

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
  CGFloat xPosition = scrollView.contentOffset.x / CGRectGetWidth(self.view.bounds);
  
  if (xPosition < 1.0f)
    back_.enabled = NO;
  else
    back_.enabled = YES;

  if (xPosition > 6.0f)
    next_.enabled = NO;
  else
    next_.enabled = YES;
  
  uipc_.currentPage = xPosition;
}

@end