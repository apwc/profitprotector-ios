#import "FrontTableViewController.h"
#import "MainViewController.h"
#import "ProfitProtectorStyleKit.h"

@interface FrontTableViewController ()
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
    rows = 3;
  
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
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                  reuseIdentifier:cellReusableIdentifier];
    
    if (indexPath.section == 0)
    {
      UIImageView *newProperty = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"newProperty"]];
      newProperty.contentMode = UIViewContentModeScaleAspectFit;
      [cell.contentView addSubview:newProperty];
      
      UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f,
                                                                 0.0f,
                                                                 CGRectGetWidth(cell.bounds),
                                                                 48.0f)];
      label.text = @"Create a Property";
      label.font = [UIFont fontWithName:@"HelveticaNeue" size:26.0f];
      label.textColor = [UIColor darkGrayColor];
      label.textAlignment = NSTextAlignmentCenter;
      [self.view addSubview:label];
    }
    
    if (indexPath.section == 1)
    {
      UIImageView *newProperty = [[UIImageView alloc] initWithImage:[ProfitProtectorStyleKit imageOfBadgeWithSize:CGSizeMake(150.0f, 37.0f)
                                                                                                        fillColor:[UIColor whiteColor]
                                                                                                     cornerRadius:7.0f
                                                                                                      strokeColor:[UIColor colorWithRed:0 green:0.68 blue:0.94 alpha:1]
                                                                                                      strokeWidth:1.0f
                                                                                                             text:@"$27,000.00"
                                                                                                        textColor:[UIColor colorWithRed:0 green:0.68 blue:0.94 alpha:1]
                                                                                                         textFont:[UIFont fontWithName:@"HelveticaNeue" size:16.0f]]];
      [newProperty sizeToFit];
      newProperty.center = CGPointMake(CGRectGetWidth(cell.bounds) - (CGRectGetWidth(newProperty.bounds) / 2.0f) - 10.f,
                                       CGRectGetHeight(cell.bounds) / 2.0f);
      newProperty.autoresizingMask = (UIViewAutoresizingFlexibleTopMargin |
                                      UIViewAutoresizingFlexibleBottomMargin);
      [cell.contentView addSubview:newProperty];
    }
  }
  
  if (indexPath.section == 1)
  {
    cell.textLabel.text = @"second";
    cell.detailTextLabel.text = @"subtitle";
    cell.imageView.image = [UIImage imageNamed:@"fav"];
  }
  
  return cell;
}

- (void)tableView:(UITableView *)tableView
  commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
  forRowAtIndexPath:(NSIndexPath *)indexPath
{
}

- (NSArray *)tableView:(UITableView *)tableView
  editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
  UITableViewRowAction *fav = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal
                                                                 title:@"FAV"
                                                               handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
                                                               }];
  fav.backgroundColor = [UIColor yellowColor];
  
  UITableViewRowAction *frwrd = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal
                                                                   title:@"FRWRD"
                                                                 handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
                                                                 }];
  frwrd.backgroundColor = [UIColor greenColor];
  
  UITableViewRowAction *trsh = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal
                                                                  title:@"TRSH"
                                                                handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
                                                                }];
  
  return @[trsh, frwrd, fav];
}

#pragma mark - UITableView delegate methods implementation

- (CGFloat)tableView:(UITableView *)tableView
  heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return indexPath.section == 0 ? 232.0f : 70.0f;
}



- (void)tableView:(UITableView *)tableView
  didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end