#import "HotelDetailsViewController.h"
#import "ProfitProtectorStyleKit.h"

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
  
  // math calculations
  NSInteger ancillariesRevenuePerRoomPerNight = [[self.property valueForKey:@"bedsNumber"] integerValue];
  NSInteger bedBugIncidents = [[self.property valueForKey:@"bedBugIncidents"] integerValue];
  NSInteger bedsNumber = [[self.property valueForKey:@"bedsNumber"] integerValue];
  NSInteger bugInspectionAndPestControlFees = [[self.property valueForKey:@"bugInspectionAndPestControlFees"] integerValue];
  NSInteger costOfReplaceFurnishings = [[self.property valueForKey:@"costOfReplaceFurnishings"] integerValue];
  NSInteger costOfReplaceMattressesAndBoxSpring = [[self.property valueForKey:@"costOfReplaceMattressesAndBoxSpring"] integerValue];
  NSInteger costToCleanAndReinstallEncasements = [[self.property valueForKey:@"costToCleanAndReinstallEncasements"] integerValue];
  NSInteger foodBeverageSalesPerRoomPerNight = [[self.property valueForKey:@"foodBeverageSalesPerRoomPerNight"] integerValue];
  NSInteger grevianceCostsPerInfestation = [[self.property valueForKey:@"grevianceCostsPerInfestation"] integerValue];
  NSInteger percentageOfMattressesReplaceEachYear = [[self.property valueForKey:@"percentageOfMattressesReplaceEachYear"] integerValue];
  NSInteger roomRevenuePerNight = [[self.property valueForKey:@"roomRevenuePerNight"] integerValue];
  NSInteger roomsNumber = [[self.property valueForKey:@"roomsNumber"] integerValue];
  NSInteger timesPerYearBedClean = [[self.property valueForKey:@"roomsNumber"] integerValue];
  
//  NSInteger remediationCosts =
//  NSInteger totalLossesPerBedBugInfestationIncident =
  
  
//  NSInteger totalInvestmentToEncaseAllBeds = [[self.property valueForKey:@"bedsNumber"] integerValue] * [[self.property valueForKey:@"costOfReplaceMattressesAndBoxSpring"] integerValue];
//  NSInteger totalAnnualBedBugInfestationLosses = () * [[self.property valueForKey:@"roomsNumber"] integerValue] * [[self.property valueForKey:@"roomsNumber"] integerValue];
  //NSInteger preemptiveEncasementSavings = ;
  //NSInteger withoutEncasements =
  //NSInteger roi = totalInvestmentToEncaseAllBeds;
  
  //
  UISegmentedControl *uisc = [[UISegmentedControl alloc] initWithItems:@[@"Report", @"Profile"]];
  uisc.selectedSegmentIndex = 0;
  uisc.frame = CGRectMake((CGRectGetWidth(self.view.bounds) - (CGRectGetWidth(self.view.bounds) - 20.0f)) / 2.0f,
                          74.0,
                          CGRectGetWidth(self.view.bounds) - 20.0f,
                          33.0f);
  [uisc addTarget:self action:@selector(segmentedControlEventChanged:) forControlEvents:UIControlEventValueChanged];
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
  NSString *cellIdentifier =[NSString stringWithFormat:@"cellReusableIdentifier%ld%ld%d",
                             indexPath.section,
                             indexPath.row,
                             isProfileSelected_];
  
  UITableViewCell *cell;
  
  if (isProfileSelected_)
  {
    cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    
    if (!cell)
    {
      cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                    reuseIdentifier:cellIdentifier];
      
      UILabel *details = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(cell.bounds) - 170.0f - 10.0f,
                                                                   0.0f,
                                                                   170.0f,
                                                                   CGRectGetHeight(cell.bounds))];
      details.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:14.0f];
      details.textColor = [UIColor blueColor];
      details.textAlignment = NSTextAlignmentRight;
      details.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin |
                                  UIViewAutoresizingFlexibleTopMargin |
                                  UIViewAutoresizingFlexibleBottomMargin |
                                  UIViewAutoresizingFlexibleHeight);
      [cell.contentView addSubview:details];
      
      if (indexPath.row == 0)
      {
        details.text = [self.property valueForKey:@"propertyType"];
      }
      
      if (indexPath.row == 1)
      {
        details.text = [NSString stringWithFormat:@"%ld Rooms",
                        [[self.property valueForKey:@"roomsNumber"] integerValue]];
      }
      
      if (indexPath.row == 2)
      {
        details.text = @"$37,468.000";
      }
      
      if (indexPath.row == 3)
      {
        details.text = @"$110,022.000";
      }
      
      if (indexPath.row == 4)
      {
        details.text = [NSString stringWithFormat:@"%ld%%",
                        [[self.property valueForKey:@"percentageOfMattressesReplaceEachYear"] integerValue]];
      }
      
      if (indexPath.row == 5)
      {
        details.text = [NSString stringWithFormat:@"%ld Cases",
                        [[self.property valueForKey:@"bedsNumber"] integerValue]];
      }
    }
    
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
    cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell)
    {
      cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                    reuseIdentifier:cellIdentifier];
      
      if (indexPath.section == 0)
      {
        if (indexPath.row == 0)
        {
          UIImageView *newProperty = [[UIImageView alloc] initWithImage:[ProfitProtectorStyleKit imageOfBadgeWithSize:CGSizeMake(130.0f, 37.0f)
                                                                                                            fillColor:[UIColor whiteColor]
                                                                                                         cornerRadius:7.0f
                                                                                                          strokeColor:[UIColor redColor]
                                                                                                          strokeWidth:1.0f
                                                                                                                 text:@"$27,000.00"
                                                                                                            textColor:[UIColor redColor]
                                                                                                             textFont:[UIFont fontWithName:@"HelveticaNeue" size:16.0f]]];
          [newProperty sizeToFit];
          newProperty.center = CGPointMake(CGRectGetWidth(cell.bounds) - (CGRectGetWidth(newProperty.bounds) / 2.0f) - 10.f,
                                           CGRectGetHeight(cell.bounds) / 2.0f);
          newProperty.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin |
                                          UIViewAutoresizingFlexibleTopMargin |
                                          UIViewAutoresizingFlexibleBottomMargin);
          [cell.contentView addSubview:newProperty];
        }
        
        if (indexPath.row == 1)
        {
          UIImageView *newProperty = [[UIImageView alloc] initWithImage:[ProfitProtectorStyleKit imageOfBadgeWithSize:CGSizeMake(130.0f, 37.0f)
                                                                                                            fillColor:[UIColor whiteColor]
                                                                                                         cornerRadius:7.0f
                                                                                                          strokeColor:[UIColor orangeColor]
                                                                                                          strokeWidth:1.0f
                                                                                                                 text:@"$27,000.00"
                                                                                                            textColor:[UIColor orangeColor]
                                                                                                             textFont:[UIFont fontWithName:@"HelveticaNeue" size:16.0f]]];
          [newProperty sizeToFit];
          newProperty.center = CGPointMake(CGRectGetWidth(cell.bounds) - (CGRectGetWidth(newProperty.bounds) / 2.0f) - 10.f,
                                           CGRectGetHeight(cell.bounds) / 2.0f);
          newProperty.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin |
                                          UIViewAutoresizingFlexibleTopMargin |
                                          UIViewAutoresizingFlexibleBottomMargin);
          [cell.contentView addSubview:newProperty];
        }
      }
      
      if (indexPath.section == 1)
      {
        if (indexPath.row == 0)
        {
          UIImageView *newProperty = [[UIImageView alloc] initWithImage:[ProfitProtectorStyleKit imageOfBadgeWithSize:CGSizeMake(130.0f, 37.0f)
                                                                                                            fillColor:[UIColor whiteColor]
                                                                                                         cornerRadius:7.0f
                                                                                                          strokeColor:[UIColor greenColor]
                                                                                                          strokeWidth:1.0f
                                                                                                                 text:@"$27,000.00"
                                                                                                            textColor:[UIColor greenColor]
                                                                                                             textFont:[UIFont fontWithName:@"HelveticaNeue" size:16.0f]]];
          [newProperty sizeToFit];
          newProperty.center = CGPointMake(CGRectGetWidth(cell.bounds) - (CGRectGetWidth(newProperty.bounds) / 2.0f) - 10.f,
                                           CGRectGetHeight(cell.bounds) / 2.0f);
          newProperty.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin |
                                          UIViewAutoresizingFlexibleTopMargin |
                                          UIViewAutoresizingFlexibleBottomMargin);
          [cell.contentView addSubview:newProperty];
        }
      }
    }
    
    if (indexPath.section == 0)
    {
      if (indexPath.row == 0)
        cell.textLabel.text = @"Without Encasements";
      
      if (indexPath.row == 1)
        cell.textLabel.text = @"With Preemptive\nEncasements";
    }
    
    if (indexPath.section == 1)
    {
      if (indexPath.row == 0)
        cell.textLabel.text = @"Preemptive Encasements\nSavings";
    }
  }
  
  cell.textLabel.numberOfLines = 2;
  cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:14.0f];
  
  return cell;
}

#pragma mark - UITableView delegate methods implementation

- (CGFloat)tableView:(UITableView *)tableView
  heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return 70.0f;
}


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
