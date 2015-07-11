#import "LeftTableViewController.h"

@interface LeftTableViewController ()
@end

@implementation LeftTableViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  // UI customizations
  self.view.backgroundColor = [UIColor colorWithRed:0 green:0.68 blue:0.95 alpha:1];
  self.tableView.backgroundColor = [UIColor colorWithRed:0 green:0.68 blue:0.95 alpha:1];
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
  {
    cell.textLabel.textColor = [UIColor blackColor];
    cell.textLabel.text = @"user name";
  }

  if (indexPath.row == 1)
    cell.textLabel.text = @"Settings";
  
  if (indexPath.row == 2)
    cell.textLabel.text = @"Log Out";
  
  return cell;
}

@end