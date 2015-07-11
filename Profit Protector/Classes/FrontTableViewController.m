#import "FrontTableViewController.h"

@interface FrontTableViewController ()
@end

@implementation FrontTableViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  // UI customizations
  self.view.backgroundColor = [UIColor redColor];

  self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction
                                                                                        target:self
                                                                                        action:@selector(showLeftViewController:)];
}

- (void)showLeftViewController:(UIBarButtonItem *)uibbi
{
}

#pragma mark - UITableView datasource methods implementation

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 3;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
  NSInteger rows = 0;
  
  if (section == 0)
    rows = 1;
  
  if (section == 1)
    rows = 3;
  
  if (section == 2)
    rows = 3;
  
  return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *cellReusableIdentifier = @"cellReusableIdentifier";
  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReusableIdentifier];
  
  
  if (!cell)
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                  reuseIdentifier:cellReusableIdentifier];
  
  if (indexPath.section == 0)
  {
    cell.textLabel.text = @"first";
  }
  
  if (indexPath.section == 1)
  {
    cell.textLabel.text = @"second";
  }
  
  if (indexPath.section == 2)
  {
    cell.textLabel.text = @"third";
  }
  
  return cell;
}

#pragma mark - UITableView delegate methods implementation

- (void)tableView:(UITableView *)tableView
  didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end