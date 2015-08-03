#import "UserTypeTableViewController.h"

@interface UserTypeTableViewController ()
{
  NSArray *types_;
}
@end

@implementation UserTypeTableViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  types_ = @[@"Distributor", @"Hotel Owner", @"PCO"];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
  return [types_ count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *reuseIdentifier = @"reuseIdentifier";
  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
  
  if (!cell)
      cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                    reuseIdentifier:reuseIdentifier];
  
  cell.textLabel.text = types_[indexPath.row];
  
  return cell;
}

- (void)tableView:(UITableView *)tableView
  didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
  
  [_delegate userTypeSelected:types_[indexPath.row]];
  
  [self.navigationController popViewControllerAnimated:YES];
}

@end
