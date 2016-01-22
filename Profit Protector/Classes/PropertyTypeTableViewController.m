#import "PropertyTypeTableViewController.h"
#import "GlobalMethods.h"

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
  {
    cell.textLabel.text = [GlobalMethods localizedStringWithKey:@"Full Service"];
    cell.tag = Full;
  }
  
  if (indexPath.row == 1)
  {
    cell.textLabel.text = [GlobalMethods localizedStringWithKey:@"Select Service"];
    cell.tag = Select;
  }
  
  return cell;
}

#pragma mark - UITableView delegate methods implementation

- (void)tableView:(UITableView *)tableView
  didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
  
  UITableViewCell *cell = (UITableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
  
  [self.delegate propertyTypeDidSelect:(PropertyType)cell.tag];
  
  [self.navigationController popViewControllerAnimated:YES];
}

@end