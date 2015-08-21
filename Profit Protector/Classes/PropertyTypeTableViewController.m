#import "PropertyTypeTableViewController.h"

@implementation PropertyTypeTableViewController

- (void)close:(UIBarButtonItem *)uibbi
{
  [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITableView datasource methods implementation

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
  return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *reuseIdentifier = @"reuseIdentifier";
  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
  
  if (!cell)
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                  reuseIdentifier:reuseIdentifier];
  
  if (indexPath.row == 0)
    cell.textLabel.text = @"Full Service";
  
  if (indexPath.row == 1)
    cell.textLabel.text = @"Selective Service";
  
  return cell;
}

#pragma mark - UITableView delegate methods implementation

- (void)tableView:(UITableView *)tableView
  didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
  
  UITableViewCell *cell = (UITableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
  
  [self.delegate propertyTypeDidSelect:cell.textLabel.text];
  
  [self.navigationController popViewControllerAnimated:YES];
}

@end