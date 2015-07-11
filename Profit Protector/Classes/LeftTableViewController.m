#import "LeftTableViewController.h"

@interface LeftTableViewController ()
@end

@implementation LeftTableViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  // UI customizations
  self.tableView.backgroundColor = [UIColor colorWithRed:0 green:0.68 blue:0.95 alpha:1];
  self.tableView.contentInset = UIEdgeInsetsMake(60.0f, 0.0f, 0.0f, 0.0f);
  self.tableView.separatorColor = [UIColor clearColor];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
  return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *cellReusableIdentifier = @"cellReusableIdentifier";
  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReusableIdentifier];
  

  if (!cell)
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                  reuseIdentifier:cellReusableIdentifier];
  
  if (indexPath.row == 0)
    cell.textLabel.text = @"User Name";

  if (indexPath.row == 1)
    cell.textLabel.text = @"Settings";
  
  if (indexPath.row == 2)
    cell.textLabel.text = @"Log Out";
  
  if (indexPath.row == 0)
    cell.textLabel.textColor = [UIColor blackColor];
  else
    cell.textLabel.textColor = [UIColor whiteColor];
  
  cell.backgroundColor = [UIColor colorWithRed:0 green:0.68 blue:0.95 alpha:1];
  
  return cell;
}

#pragma mark - 

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end