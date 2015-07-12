#import "HotelDetailsViewController.h"

@interface HotelDetailsViewController () <UITableViewDataSource,
                                          UITableViewDelegate>
{
  UILabel     *lifetimeROI_;
  
  UITableView *uitv_;
  
  BOOL        isProfileSelected_;
}
@end

@implementation HotelDetailsViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  // UI customizations
  self.view.backgroundColor = [UIColor whiteColor];
  
  UISegmentedControl *uisc = [[UISegmentedControl alloc] initWithItems:@[@"Report", @"Profile"]];
  uisc.selectedSegmentIndex = 0;
  uisc.frame = CGRectMake((CGRectGetWidth(self.view.bounds) - (CGRectGetWidth(self.view.bounds) - 20.0f)) / 2.0f,
                          74.0,
                          CGRectGetWidth(self.view.bounds) - 20.0f,
                          33.0f);
  [uisc addTarget:self
           action:@selector(segmentedControlEventChanged:)
 forControlEvents:UIControlEventValueChanged];
  [self.view addSubview:uisc];
  
  // Lifetime ROI
  UILabel *lifetimeROITitle = [[UILabel alloc] initWithFrame:CGRectMake(0.0f,
                                                                        CGRectGetHeight(self.view.bounds) - 70.0f - 42.0f,
                                                                        CGRectGetWidth(self.view.bounds),
                                                                        42.0f)];
  lifetimeROITitle.textColor = [UIColor blackColor];
  lifetimeROITitle.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:22.0f];
  lifetimeROITitle.textAlignment = NSTextAlignmentCenter;
  lifetimeROITitle.text = @"Lifetime ROI";
  [self.view addSubview:lifetimeROITitle];
  
  lifetimeROI_ = [[UILabel alloc] initWithFrame:CGRectMake(0.0f,
                                                           CGRectGetHeight(self.view.bounds) - 70.0f,
                                                           CGRectGetWidth(self.view.bounds),
                                                           70.0f)];
  lifetimeROI_.backgroundColor = [UIColor greenColor];
  lifetimeROI_.textColor = [UIColor whiteColor];
  lifetimeROI_.font = [UIFont fontWithName:@"HelveticaNeue" size:26.0f];
  lifetimeROI_.textAlignment = NSTextAlignmentCenter;
  lifetimeROI_.text = @"$606,204.00";
  [self.view addSubview:lifetimeROI_];
  
  uitv_ = [[UITableView alloc] initWithFrame:CGRectMake(0.0f,
                                                        CGRectGetMaxY(uisc.frame) + 10.0f,
                                                        CGRectGetWidth(self.view.bounds),
                                                        CGRectGetHeight(self.view.bounds) - (CGRectGetMaxY(uisc.frame) + 10.0f) - CGRectGetHeight(lifetimeROITitle.frame) - CGRectGetHeight(lifetimeROI_.frame))//(CGRectGetMaxY(uisc.frame) + 10.0f) - )
                                       style:UITableViewStylePlain];
  uitv_.dataSource = self;
  uitv_.delegate = self;
  [self.view addSubview:uitv_];
  
  isProfileSelected_ = NO;
}

- (void)segmentedControlEventChanged:(UISegmentedControl *)uisc
{
  isProfileSelected_ = uisc.selectedSegmentIndex;
  
  [uitv_ reloadData];
}

#pragma mark - UITableView datasource methods implementation

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return isProfileSelected_ ? 1 : 2;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
  return isProfileSelected_ ? 6 : section == 0 ? 2 : 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *cellReusableReportIdentifier = @"cellReusableIdentifier";
  static NSString *cellReusableProfileIdentifier = @"cellReusableIdentifier";
  
  UITableViewCell *cell;
  
  if (isProfileSelected_)
  {
    cell = [tableView dequeueReusableCellWithIdentifier:cellReusableProfileIdentifier];
    
    
    if (!cell)
      cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                    reuseIdentifier:cellReusableProfileIdentifier];
    
    if (indexPath.row == 0)
      cell.textLabel.text = @"Property Type";
    
    if (indexPath.row == 1)
      cell.textLabel.text = @"Rooms & Beds";
    
    if (indexPath.row == 2)
      cell.textLabel.text = @"Revenues";
    
    if (indexPath.row == 3)
      cell.textLabel.text = @"Costs";
    
    if (indexPath.row == 4)
      cell.textLabel.text = @"Spoilage";
    
    if (indexPath.row == 5)
      cell.textLabel.text = @"Infestations";
  }
  else
  {
    cell = [tableView dequeueReusableCellWithIdentifier:cellReusableReportIdentifier];
    
    
    if (!cell)
      cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                    reuseIdentifier:cellReusableReportIdentifier];
    
    if (indexPath.section == 0)
    {
      if (indexPath.row == 0)
        cell.textLabel.text = @"Without Encasements";
      
      if (indexPath.row == 1)
        cell.textLabel.text = @"With Preemptive Encasements";
    }
    
    if (indexPath.section == 1)
    {
      if (indexPath.row == 0)
        cell.textLabel.text = @"Preemptive Encasements Savings";
    }
  }
  
  return cell;
}

#pragma mark - UITableView delegate methods implementation

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
  NSString *headerTitle;
  
  if (section == 0)
    headerTitle = @"Your Annual Loses";
  
  if (section == 1)
    headerTitle = @"Your Annual Savings";
  
  return headerTitle;
}

- (CGFloat)tableView:(UITableView *)tableView
  heightForHeaderInSection:(NSInteger)section
{
  return isProfileSelected_ ? 0.0f : 32.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
