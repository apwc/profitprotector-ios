#import "FrontTableViewController.h"
#import "MainViewController.h"
#import "ProfitProtectorStyleKit.h"
#import "NewPropertyViewController.h"
#import "HotelDetailsViewController.h"
#import "CoreDataRetrieving.h"
#import "GlobalMethods.h"

@interface FrontTableViewController ()
{
  NSArray *properties_;
  UILabel *name_;
}
@end

@implementation FrontTableViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  // UI customizations
  self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu"]
                                                                           style:UIBarButtonItemStylePlain
                                                                          target:self
                                                                          action:@selector(showLeftViewController:)];
}

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  
  properties_ = [CoreDataRetrieving properties];
  
  [self.tableView reloadData];
}

- (void)showLeftViewController:(UIBarButtonItem *)uibbi
{
  MainViewController *mvc = (MainViewController *)self.parentViewController.parentViewController;
  [mvc showViewController:mvc.leftViewController];
}

#pragma mark - UITableView datasource methods implementation

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 2;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
  NSInteger rows = 0;
  
  if (section == 0)
    rows = 1;
  
  if (section == 1)
    rows = [properties_ count];
  
  return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  NSString *cellReusableIdentifier = [NSString stringWithFormat:@"cellReusableIdentifier%ld%ld",
                                      indexPath.section,
                                      indexPath.row];
  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReusableIdentifier];
  
  if (!cell)
  {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                  reuseIdentifier:cellReusableIdentifier];
    
    if (indexPath.section == 0)
    {
      UIImageView *newProperty = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"newProperty"]];
      newProperty.frame = CGRectMake(0.0f, 0.0f, CGRectGetWidth(cell.bounds), CGRectGetHeight(cell.bounds));
      newProperty.contentMode = UIViewContentModeScaleAspectFill;
      newProperty.autoresizingMask = (UIViewAutoresizingFlexibleWidth |
                                      UIViewAutoresizingFlexibleHeight);
      [cell.contentView addSubview:newProperty];
      
      UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f,
                                                                 0.0f,
                                                                 CGRectGetWidth(cell.bounds),
                                                                 48.0f)];
      label.text = @"Create a Property";
      label.font = [UIFont fontWithName:@"HelveticaNeue" size:26.0f];
      label.textColor = [UIColor darkGrayColor];
      label.textAlignment = NSTextAlignmentCenter;
      label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
      [cell.contentView addSubview:label];
      
      cell.clipsToBounds = YES;
    }
  }
  
  if (indexPath.section == 1)
  {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                  reuseIdentifier:cellReusableIdentifier];
    
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
    name_.font = [UIFont fontWithName:@"HelveticaNeue" size:16.0f];
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
  }
  
  return cell;
}

- (BOOL)tableView:(UITableView *)tableView
  canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
  return indexPath.section == 0 ? NO : YES;
}

- (void)tableView:(UITableView *)tableView
  commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
  forRowAtIndexPath:(NSIndexPath *)indexPath
{
}

- (NSArray *)tableView:(UITableView *)tableView
  editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
  if (indexPath.section == 0)
    return nil;
  
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
                                                                 
                                                                 properties_ = [CoreDataRetrieving properties];
                                                                 
                                                                 [self.tableView reloadData];
                                                               }];
  fav.backgroundColor = [UIColor colorWithRed:0.89 green:0.88 blue:0.13 alpha:1];
  
  UITableViewRowAction *frwrd = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal
                                                                   title:@"FRWRD"
                                                                 handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
                                                                 }];
  frwrd.backgroundColor = [UIColor colorWithRed:0 green:0.83 blue:0 alpha:1];
  
  UITableViewRowAction *edt = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal
                                                                   title:@"EDT"
                                                                 handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
                                                                   NewPropertyViewController *npvc = [[NewPropertyViewController alloc] initWithNibName:nil
                                                                                                                                                 bundle:nil];
                                                                   npvc.property = property;
                                                                   [self.navigationController pushViewController:npvc animated:YES];
                                                                 }];
  edt.backgroundColor = [UIColor colorWithRed:0.38 green:0.54 blue:1 alpha:1];
  
  UITableViewRowAction *trsh = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive
                                                                  title:@"TRSH"
                                                                handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
                                                                  CoreDataManager *cdm = [CoreDataManager singleton];
                                                                  [cdm deleteObject:properties_[indexPath.row]];
                                                                  
                                                                  properties_ = [CoreDataRetrieving properties];
                                                                  
                                                                  [self.tableView reloadData];
                                                                }];
  
  return @[trsh, edt, frwrd, fav];
}

#pragma mark - UITableView delegate methods implementation

- (CGFloat)tableView:(UITableView *)tableView
  heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return indexPath.section == 0 ? 200.0f : 70.0f;
}

- (void)tableView:(UITableView *)tableView
  didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
  
  if (indexPath.section == 0)
  {
    NewPropertyViewController *npvc = [[NewPropertyViewController alloc] initWithNibName:nil
                                                                                  bundle:nil];
    [self.navigationController pushViewController:npvc animated:YES];
  }
  else
  {
    HotelDetailsViewController *hdvc = [[HotelDetailsViewController alloc] initWithNibName:nil
                                                                                    bundle:nil];
    hdvc.property = properties_[indexPath.row];
    [self.navigationController pushViewController:hdvc animated:YES];
  }
}

@end