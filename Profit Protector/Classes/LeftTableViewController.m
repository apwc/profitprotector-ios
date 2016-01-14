#import "LeftTableViewController.h"
#import "Constants.h"
#import "GlobalData.h"

@implementation LeftTableViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  // UI customizations
  self.tableView.backgroundColor = [UIColor colorWithRed:0 green:0.68 blue:0.95 alpha:1];
  self.tableView.contentInset = UIEdgeInsetsMake(60.0f, 0.0f, 0.0f, 0.0f);
  self.tableView.separatorColor = [UIColor clearColor];
}

#pragma mark - UITableView datasource methods implementation

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
  return 4;
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
    cell.textLabel.text = [GlobalData username];
    cell.textLabel.textColor = [UIColor blackColor];
  }

  if (indexPath.row == 1)
  {
    cell.textLabel.text = @"Language";
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
  }
  
  if (indexPath.row == 2)
  {
    cell.textLabel.text = @"Currency";
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
  }
  
  if (indexPath.row == 3)
  {
    cell.textLabel.text = @"Log Out";
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:16.0f];
    cell.textLabel.textColor = [UIColor whiteColor];
  }
  
  cell.backgroundColor = [UIColor colorWithRed:0 green:0.68 blue:0.95 alpha:1];
  
  return cell;
}

#pragma mark - UITableView delegate methods implementation

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
  
  if (indexPath.row == 1)
  {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil
                                                                   message:nil
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *english = [UIAlertAction actionWithTitle:@"English"
                                                   style:UIAlertActionStyleDefault
                                                 handler:^(UIAlertAction *action) {
                                                 }];
    
    [alert addAction:english];
    
    UIAlertAction *french = [UIAlertAction actionWithTitle:@"Français"
                                                  style:UIAlertActionStyleDefault
                                                handler:^(UIAlertAction *action) {
                                                }];
    
    [alert addAction:french];
    
    UIAlertAction *mandarin = [UIAlertAction actionWithTitle:@"普通话"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction *action) {
                                                     }];
    
    [alert addAction:mandarin];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel"
                                                     style:UIAlertActionStyleCancel
                                                   handler:nil];
    
    [alert addAction:cancel];
    
    // note: you can control the order buttons are shown, unlike UIActionSheet
    [alert setModalPresentationStyle:UIModalPresentationPopover];
    
    UIPopoverPresentationController *popPresenter = [alert popoverPresentationController];
    popPresenter.sourceView = self.view;
    popPresenter.sourceRect = self.view.bounds;
    
    [self presentViewController:alert animated:YES completion:nil];
  }
  
  if (indexPath.row == 2)
  {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil
                                                                   message:nil
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *usd = [UIAlertAction actionWithTitle:@"USD"
                                                  style:UIAlertActionStyleDefault
                                                handler:^(UIAlertAction *action) {
                                                }];
    
    [alert addAction:usd];
    
    UIAlertAction *pounds = [UIAlertAction actionWithTitle:@"Pounds"
                                                     style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction *action) {
                                                   }];
    
    [alert addAction:pounds];
    
    UIAlertAction *euro = [UIAlertAction actionWithTitle:@"Euro"
                                                   style:UIAlertActionStyleDefault
                                                 handler:^(UIAlertAction *action) {
                                                 }];
    
    [alert addAction:euro];
    
    UIAlertAction *rmb = [UIAlertAction actionWithTitle:@"RMB"
                                                     style:UIAlertActionStyleDefault
                                                   handler:nil];
    
    [alert addAction:rmb];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel"
                                                     style:UIAlertActionStyleCancel
                                                   handler:nil];
    
    [alert addAction:cancel];
    
    // note: you can control the order buttons are shown, unlike UIActionSheet
    [alert setModalPresentationStyle:UIModalPresentationPopover];
    
    UIPopoverPresentationController *popPresenter = [alert popoverPresentationController];
    popPresenter.sourceView = self.view;
    popPresenter.sourceRect = self.view.bounds;
    
    [self presentViewController:alert animated:YES completion:nil];
  }
  
  if (indexPath.row == 3)
  {
    [[NSNotificationCenter defaultCenter] postNotificationName:userDidLogoutNotification
                                                        object:nil];
  }
}

@end