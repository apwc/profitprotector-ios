#import "FrontTableViewController.h"
#import "MainViewController.h"
#import "ProfitProtectorStyleKit.h"
#import "NewPropertyViewController.h"
#import "HotelDetailsViewController.h"
#import "CoreDataRetrieving.h"
#import "CoreDataStoring.h"
#import "GlobalMethods.h"
#import "API.h"
#import "NDHTMLtoPDF.h"
#import "HUD.h"

@interface FrontTableViewController () <UITableViewDataSource,
                                        UITableViewDelegate>
{
  NSArray     *properties_;
  UILabel     *name_;
  
  UIButton    *new_;
  
  BOOL        isExpanded_;
  UIButton    *chevron_;
  
  UITableView *uitv_;
}
@end

@implementation FrontTableViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  // UI customizations
  self.view.backgroundColor = [UIColor colorWithRed:0.91 green:0.9 blue:0.9 alpha:1];
  
  isExpanded_ = YES;
  
  // UI customizations
  self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu"]
                                                                           style:UIBarButtonItemStylePlain
                                                                          target:self
                                                                          action:@selector(showLeftViewController:)];
  
  self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                                                                                         target:self
                                                                                         action:@selector(allProperties:)];
  
  // new property
  new_ = [UIButton buttonWithType:UIButtonTypeCustom];
  new_.frame = CGRectMake(0.0f, 64.0f, CGRectGetWidth(self.view.frame), CGRectGetWidth(self.view.frame));
  [new_ setImage:[UIImage imageNamed:@"newProperty"] forState:UIControlStateNormal];
  [new_ setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
  [new_ addTarget:self action:@selector(addProperty:) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:new_];
  
  // properties list
  uitv_ = [[UITableView alloc] initWithFrame:CGRectMake(0.0f,
                                                        CGRectGetMaxY(new_.frame),
                                                        CGRectGetWidth(self.view.frame),
                                                        CGRectGetHeight(self.view.frame) - CGRectGetMaxY(new_.frame))];
  uitv_.dataSource = self;
  uitv_.delegate = self;
  uitv_.bounces = NO;
  [self.view addSubview:uitv_];
  
  // accordion
  chevron_ = [UIButton buttonWithType:UIButtonTypeCustom];
  chevron_.frame = CGRectMake(CGRectGetWidth(self.view.frame) - 58.0f,
                              CGRectGetMaxY(new_.frame) - 14.0f,
                              48.0f,
                              48.0f);
  chevron_.backgroundColor = [UIColor whiteColor];
  chevron_.layer.cornerRadius = 24.0f;
  chevron_.layer.borderColor = [UIColor lightGrayColor].CGColor;
  chevron_.layer.borderWidth = 1.0f;
  [chevron_ setImage:[UIImage imageNamed:@"up"] forState:UIControlStateNormal];
  [chevron_ addTarget:self action:@selector(accordion:) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:chevron_];
  
  //
  [self allProperties:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  
  //
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(apiUserPropertiesSuccessful:)
                                               name:apiUserPropertiesSuccessfulNotification
                                             object:nil];
  
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(apiUserPropertyDeleteSuccessful:)
                                               name:apiUserPropertyDeleteSuccessfulNotification
                                             object:nil];
  
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(displaySelectedProperty:)
                                               name:displaySelectedPropertyNotification
                                             object:nil];
  
  properties_ = [CoreDataRetrieving allProperties];
  
  [uitv_ reloadData];
}

- (void)viewWillDisappear:(BOOL)animated
{
  [super viewWillDisappear:animated];
  
  [[NSNotificationCenter defaultCenter] removeObserver:self
                                                  name:apiUserPropertiesSuccessfulNotification
                                                object:nil];
  
  [[NSNotificationCenter defaultCenter] removeObserver:self
                                                  name:apiUserPropertyDeleteSuccessfulNotification
                                                object:nil];
  
  [[NSNotificationCenter defaultCenter] removeObserver:self
                                                  name:displaySelectedPropertyNotification
                                                object:nil];
}

- (void)showLeftViewController:(UIBarButtonItem *)uibbi
{
  MainViewController *mvc = (MainViewController *)self.parentViewController.parentViewController;
  [mvc showViewController:mvc.leftViewController];
}

- (void)allProperties:(UIBarButtonItem *)uibbi
{
  [API getProperties];
}

- (void)addProperty:(UIButton *)uib
{
  NewPropertyViewController *npvc = [[NewPropertyViewController alloc] init];
  
  UINavigationController *uinc = [[UINavigationController alloc] initWithRootViewController:npvc];

  [self presentViewController:uinc animated:YES completion:nil];
}

- (void)accordion:(UIButton *)uib
{
  isExpanded_ = !isExpanded_;
  
  if (isExpanded_)
  {
    [chevron_ setImage:[UIImage imageNamed:@"up"] forState:UIControlStateNormal];
    
    [UIView animateWithDuration:0.25f
                     animations:^{
                       chevron_.center = CGPointMake(chevron_.center.x,
                                                     CGRectGetMaxY(new_.frame) + 10.0f);
                       
                       uitv_.frame = CGRectMake(0.0f,
                                                CGRectGetMaxY(new_.frame),
                                                CGRectGetWidth(self.view.frame),
                                                CGRectGetHeight(self.view.frame) - 264.0f);
                     }];
  }
  else
  {
    [chevron_ setImage:[UIImage imageNamed:@"down"] forState:UIControlStateNormal];
    
    [UIView animateWithDuration:0.25f
                     animations:^{
                       chevron_.center = CGPointMake(chevron_.center.x, 74.0f);
                       
                       uitv_.frame = CGRectMake(0.0f,
                                                64.0f,
                                                CGRectGetWidth(self.view.frame),
                                                CGRectGetHeight(self.view.frame) - 64.0f);
                     }];
  }
}

#pragma mark - UI Updates notifications callbacks

- (void)displaySelectedProperty:(NSNotification *)notification
{
  NSDictionary *token = (NSDictionary *)notification.object;
  
  [properties_ enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
    NSManagedObject *property = (NSManagedObject *)obj;
    
    if ([[property valueForKey:@"propertyID"] integerValue] == [token[@"ID"] integerValue])
    {
      HotelDetailsViewController *hdvc = [[HotelDetailsViewController alloc] initWithNibName:nil
                                                                                      bundle:nil];
      hdvc.property = property;
      [self.navigationController pushViewController:hdvc animated:YES];
      
      *stop = YES;
    }
  }];
}

#pragma mark - API notifications callbacks

- (void)apiUserPropertiesSuccessful:(NSNotification *)notification
{
  NSArray *array = (NSArray *)notification.object;
  
  properties_ = [CoreDataRetrieving allProperties];
  
  [properties_ enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
    NSManagedObject *property = (NSManagedObject *)obj;
    
    CoreDataManager *cdm = [CoreDataManager singleton];
    [cdm deleteObject:property];
    [cdm saveData];
  }];
  
  [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
    [CoreDataStoring storeProperty:obj];
  }];
  
  properties_ = [CoreDataRetrieving allProperties];
  
  [uitv_ reloadData];
}

- (void)apiUserPropertyDeleteSuccessful:(NSNotification *)notification
{
  properties_ = [CoreDataRetrieving allProperties];
  
  [uitv_ reloadData];
}

#pragma mark - UITableView datasource methods implementation

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
  return [properties_ count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  NSString *cellReusableIdentifier = [NSString stringWithFormat:@"cellReusableIdentifier%ld%ld",
                                      (long)indexPath.section,
                                      (long)indexPath.row];
  
  UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                 reuseIdentifier:cellReusableIdentifier];
  cell.clipsToBounds = YES;
  
  NSManagedObject *property = properties_[indexPath.row];
  
  NSNumberFormatter *formatter_ = [[NSNumberFormatter alloc] init];
  [formatter_ setNumberStyle:NSNumberFormatterCurrencyStyle];
  
  // get the math results
  NSDictionary *math = [GlobalMethods math:property];
  
  UIImageView *newProperty = [[UIImageView alloc] initWithImage:[ProfitProtectorStyleKit imageOfBadgeWithSize:CGSizeMake(130.0f, 37.0f)
                                                                                                    fillColor:[UIColor whiteColor]
                                                                                                 cornerRadius:7.0f
                                                                                                  strokeColor:[UIColor colorWithRed:0.0f green:0.68f blue:0.94f alpha:1.0f]
                                                                                                  strokeWidth:1.0f
                                                                                                         text:[formatter_ stringFromNumber:math[@"roi"]]
                                                                                                    textColor:[UIColor colorWithRed:0.0f green:0.68f blue:0.94f alpha:1.0f]
                                                                                                     textFont:[UIFont fontWithName:@"HelveticaNeue" size:14.0f]]];
  [newProperty sizeToFit];
  newProperty.center = CGPointMake(CGRectGetWidth(cell.bounds) - (CGRectGetWidth(newProperty.bounds) / 2.0f) - 10.f,
                                   CGRectGetHeight(cell.bounds) / 2.0f);
  newProperty.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin |
                                  UIViewAutoresizingFlexibleTopMargin |
                                  UIViewAutoresizingFlexibleBottomMargin);
  [cell.contentView addSubview:newProperty];
  
  //
  name_ = [[UILabel alloc] initWithFrame:CGRectZero];
  name_.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:16.0f];
  name_.numberOfLines = 2;
  name_.autoresizingMask = UIViewAutoresizingFlexibleHeight;
  [cell.contentView addSubview:name_];
  
  name_.text = [property valueForKey:@"name"];
  
  if ([[property valueForKey:@"favorite"] boolValue])
  {
    cell.imageView.image = [UIImage imageNamed:@"fav"];
    
    name_.frame = CGRectMake(40.0f,
                             0.0f,
                             CGRectGetWidth(cell.bounds) - 150.0f - 10.0f - (cell.imageView.image.size.width + 10.0f),
                             CGRectGetHeight(cell.bounds));
  }
  else
  {
    cell.imageView.image = nil;
    
    name_.frame =  CGRectMake(10.0f,
                              0.0f,
                              CGRectGetWidth(cell.bounds) - 135.0f - 10.0f - (cell.imageView.image.size.width + 10.0f),
                              CGRectGetHeight(cell.bounds));
  }
  
  return cell;
}

- (BOOL)tableView:(UITableView *)tableView
  canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
  return YES;
}

- (void)tableView:(UITableView *)tableView
  commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
  forRowAtIndexPath:(NSIndexPath *)indexPath
{
}

- (NSArray *)tableView:(UITableView *)tableView
  editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
  __block NSManagedObject *property = properties_[indexPath.row];
  
  BOOL isFavorited = [[property valueForKey:@"favorite"] boolValue];
  
  UITableViewRowAction *fav = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal
                                                                 title:isFavorited ? @"UNFAV" : @"FAV"
                                                               handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
                                                                 
                                                                 if (isFavorited)
                                                                   [property setValue:@(NO) forKey:@"favorite"];
                                                                 else
                                                                   [property setValue:@(YES) forKey:@"favorite"];
                                                                 
                                                                 CoreDataManager *cdm = [CoreDataManager singleton];
                                                                 [cdm saveData];
                                                                 
                                                                 properties_ = [CoreDataRetrieving allProperties];
                                                                 
                                                                 [uitv_ reloadData];
                                                               }];
  fav.backgroundColor = [UIColor colorWithRed:0.89 green:0.88 blue:0.13 alpha:1];
  
  UITableViewRowAction *trsh = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive
                                                                  title:@"TRSH"
                                                                handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
                                                                  [API deleteProperty:properties_[indexPath.row]];
                                                                }];
  
  return @[trsh, fav];
}

#pragma mark - UITableView delegate methods implementation

- (CGFloat)tableView:(UITableView *)tableView
  heightForHeaderInSection:(NSInteger)section
{
  return 32.0f;
}

- (UIView *)tableView:(UITableView *)tableView
  viewForHeaderInSection:(NSInteger)section
{
  UILabel *holder = [[UILabel alloc] initWithFrame:CGRectZero];
  holder.textAlignment = NSTextAlignmentCenter;
  holder.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:18.0f];
  holder.textColor = [UIColor colorWithRed:0.28 green:0.69 blue:0.92 alpha:1];
  holder.backgroundColor = [UIColor colorWithWhite:0.95f alpha:1.0f];
  holder.text = [GlobalMethods localizedStringWithKey:@"PROPERTIES"];
  return holder;
}

- (CGFloat)tableView:(UITableView *)tableView
  heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return 70.0f;
}

- (void)tableView:(UITableView *)tableView
  didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
  
  HotelDetailsViewController *hdvc = [[HotelDetailsViewController alloc] initWithNibName:nil
                                                                                  bundle:nil];
  hdvc.property = properties_[indexPath.row];
  [self.navigationController pushViewController:hdvc animated:YES];
}

@end