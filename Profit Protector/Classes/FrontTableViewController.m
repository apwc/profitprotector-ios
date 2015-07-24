#import "FrontTableViewController.h"
#import "MainViewController.h"
#import "ProfitProtectorStyleKit.h"
#import "NewPropertyViewController.h"
#import "HotelDetailsViewController.h"
#import "CoreDataRetrieving.h"

@interface FrontTableViewController ()
{
  NSArray *properties_;
}
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

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  
  properties_ = [CoreDataRetrieving properties];
  
  [self.tableView reloadData];
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
    rows = [properties_ count];
  
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
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                  reuseIdentifier:cellReusableIdentifier];
    
    if (indexPath.section == 0)
    {
      UIImageView *newProperty = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"newProperty"]];
      newProperty.frame = CGRectMake(0.0f, 0.0f, CGRectGetWidth(cell.bounds), CGRectGetHeight(cell.bounds));
      newProperty.contentMode = UIViewContentModeScaleAspectFill;
      newProperty.autoresizingMask = (UIViewAutoresizingFlexibleWidth |
                                      UIViewAutoresizingFlexibleHeight);
      [cell.contentView addSubview:newProperty];
      
      UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f,
                                                                 0.0f,
                                                                 CGRectGetWidth(cell.bounds),
                                                                 48.0f)];
      label.text = @"Create a Property";
      label.font = [UIFont fontWithName:@"HelveticaNeue" size:26.0f];
      label.textColor = [UIColor darkGrayColor];
      label.textAlignment = NSTextAlignmentCenter;
      label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
      [cell.contentView addSubview:label];
      
      cell.clipsToBounds = YES;
    }
    
    if (indexPath.section == 1)
    {
      cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:14.0f];
      
      NSNumberFormatter *formatter_ = [[NSNumberFormatter alloc] init];
      [formatter_ setNumberStyle:NSNumberFormatterCurrencyStyle];
      
      NSManagedObject *property = properties_[indexPath.row];

      // math calculations
      // values form the database input fields
      float ancillariesRevenuePerRoomPerNight = [[property valueForKey:@"ancillariesRevenuePerRoomPerNight"] floatValue];
      float bedBugIncidents = [[property valueForKey:@"bedBugIncidents"] floatValue];
      float bedsNumber = [[property valueForKey:@"bedsNumber"] doubleValue];
      float bugInspectionAndPestControlFees = [[property valueForKey:@"bugInspectionAndPestControlFees"] floatValue];
      float costOfReplaceFurnishings = [[property valueForKey:@"costOfReplaceFurnishings"] floatValue];
      float costOfReplaceMattressesAndBoxSpring = [[property valueForKey:@"costOfReplaceMattressesAndBoxSpring"] floatValue];
      float costToCleanAndReinstallEncasements = [[property valueForKey:@"costToCleanAndReinstallEncasements"] floatValue];
      float foodBeverageSalesPerRoomPerNight = [[property valueForKey:@"foodBeverageSalesPerRoomPerNight"] floatValue];
      float percentageOfMattressesReplaceEachYear = [[property valueForKey:@"percentageOfMattressesReplaceEachYear"] floatValue] / 100.0f;
      float roomRevenuePerNight = [[property valueForKey:@"roomRevenuePerNight"] floatValue];
      float roomsNumber = [[property valueForKey:@"roomsNumber"] floatValue];
      float timesPerYearBedClean = [[property valueForKey:@"timesPerYearBedClean"] floatValue];
      float futureBookingDaysLost = [[property valueForKey:@"futureBookingDaysLost"] floatValue];
      
      // constants
      float encasementCommercialWarrantyLifeSavingsPeriod = 8.0f;
      float costOfCleanRestProQueenMattressAndBoxSpringEncasements = 80.0f;
      
      float roomsTreatedPerInfestationWithout = 3.75f;
      float roomsTreatedPerInfestationWith = 1.0f;
      
      float typicalRemediationCostPerRoomWithout = 750.0f;
      float typicalRemediationCostPerRoomWith = 500.0f;
      float daysLostToRemediationTreatmentWithout = 5.0f;
      float daysLostToRemediationTreatmentWith = 3.0f;
      
      float percentageOfRoomsExperiencePropertyDamageFromInfestationWithout = 0.25f;
      float percentageOfRoomsExperiencePropertyDamageFromInfestationWith = 0.0f;
      
      float revenueLossRateFromRoomClosures = 0.16f;
      
      float yourBedBugIncidentRate = bedBugIncidents / roomsNumber;
      
      // sums
      float remediationCostsWithout = roomsTreatedPerInfestationWithout * typicalRemediationCostPerRoomWithout;
      float remediationCostsWith = roomsTreatedPerInfestationWith * typicalRemediationCostPerRoomWith;
      
      float lostRevenueWithout = daysLostToRemediationTreatmentWithout * (roomRevenuePerNight + foodBeverageSalesPerRoomPerNight + ancillariesRevenuePerRoomPerNight) * roomsTreatedPerInfestationWithout * revenueLossRateFromRoomClosures;
      float lostRevenueWith = daysLostToRemediationTreatmentWith * (roomRevenuePerNight + foodBeverageSalesPerRoomPerNight + ancillariesRevenuePerRoomPerNight) * roomsTreatedPerInfestationWith * revenueLossRateFromRoomClosures;
      
      float propertyDamageWithout = (roomsTreatedPerInfestationWithout * percentageOfRoomsExperiencePropertyDamageFromInfestationWithout) * ((bedsNumber / roomsNumber) * costOfReplaceMattressesAndBoxSpring + costOfReplaceFurnishings);
      float propertyDamageWith = (roomsTreatedPerInfestationWith * percentageOfRoomsExperiencePropertyDamageFromInfestationWith) * (bedsNumber / roomsNumber) * (costOfReplaceMattressesAndBoxSpring + costOfReplaceFurnishings);
      
      float customerGrievanceCostsWithout =  bugInspectionAndPestControlFees;
      
      float brandDamageWithout = futureBookingDaysLost * (roomRevenuePerNight + foodBeverageSalesPerRoomPerNight + ancillariesRevenuePerRoomPerNight);
      
      float totalLossesPerBedBugInfestationIncidentWithout = remediationCostsWithout + lostRevenueWithout + propertyDamageWithout + customerGrievanceCostsWithout + brandDamageWithout;
      float totalLossesPerBedBugInfestationIncidentWith = remediationCostsWith + lostRevenueWith + propertyDamageWith;
      
      //  double timesIncidentsPerYear = roomsNumber * 2.8f;
      
      float totalAnnualBedBugInfestationLossesWithout = totalLossesPerBedBugInfestationIncidentWithout * yourBedBugIncidentRate * roomsNumber;
      float totalAnnualBedBugInfestationLossesWith = totalLossesPerBedBugInfestationIncidentWith * yourBedBugIncidentRate * roomsNumber;
      
      float mattressSpoilageCostsPerYear = bedsNumber * percentageOfMattressesReplaceEachYear * costOfReplaceMattressesAndBoxSpring;
      
      float preemptiveEncasementLaunderingCostsWith = timesPerYearBedClean * costToCleanAndReinstallEncasements * bedsNumber;
      
      float totalAnnualCostsLossesWithout = totalAnnualBedBugInfestationLossesWithout + mattressSpoilageCostsPerYear;
      float totalAnnualCostsLossesWith = totalAnnualBedBugInfestationLossesWith + preemptiveEncasementLaunderingCostsWith;
      
      float totalAnnualCostsLossesPreemptive = totalAnnualCostsLossesWithout - totalAnnualCostsLossesWith;
      
      float totalLifetimeSavingsFromEncasingWithCleanRestPro = totalAnnualCostsLossesPreemptive * encasementCommercialWarrantyLifeSavingsPeriod;
      
      float totalInvestmentToEncaseAllBeds = costOfCleanRestProQueenMattressAndBoxSpringEncasements * bedsNumber;
      
      float roi = totalLifetimeSavingsFromEncasingWithCleanRestPro - totalInvestmentToEncaseAllBeds;

      UIImageView *newProperty = [[UIImageView alloc] initWithImage:[ProfitProtectorStyleKit imageOfBadgeWithSize:CGSizeMake(130.0f, 37.0f)
                                                                                                        fillColor:[UIColor whiteColor]
                                                                                                     cornerRadius:7.0f
                                                                                                      strokeColor:[UIColor colorWithRed:0 green:0.68 blue:0.94 alpha:1]
                                                                                                      strokeWidth:1.0f
                                                                                                             text:[formatter_ stringFromNumber:@(roi)]
                                                                                                        textColor:[UIColor colorWithRed:0 green:0.68 blue:0.94 alpha:1]
                                                                                                         textFont:[UIFont fontWithName:@"HelveticaNeue" size:14.0f]]];
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
    NSManagedObject *property = properties_[indexPath.row];
    
    cell.textLabel.text = [property valueForKey:@"name"];
    
    if ([[property valueForKey:@"favorite"] boolValue])
      cell.imageView.image = [UIImage imageNamed:@"fav"];
  }
  
  return cell;
}

- (BOOL)tableView:(UITableView *)tableView
  canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
  return indexPath.section == 0 ? NO : YES;
}

- (void)tableView:(UITableView *)tableView
  commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
  forRowAtIndexPath:(NSIndexPath *)indexPath
{
}

- (NSArray *)tableView:(UITableView *)tableView
  editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
  if (indexPath.section == 0)
    return nil;
  
  UITableViewRowAction *fav = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal
                                                                 title:@"FAV"
                                                               handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
                                                                 NSManagedObject *property = properties_[indexPath.row];
                                                                 [property setValue:@(YES) forKey:@"favorite"];
                                                                 
                                                                 CoreDataManager *cdm = [CoreDataManager singleton];
                                                                 [cdm saveData];
                                                                 
                                                                 properties_ = [CoreDataRetrieving properties];
                                                                 
                                                                 [self.tableView reloadData];
                                                               }];
  fav.backgroundColor = [UIColor colorWithRed:0.89 green:0.88 blue:0.13 alpha:1];
  
  UITableViewRowAction *frwrd = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal
                                                                   title:@"FRWRD"
                                                                 handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
                                                                 }];
  frwrd.backgroundColor = [UIColor colorWithRed:0 green:0.83 blue:0 alpha:1];
  
  UITableViewRowAction *trsh = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal
                                                                  title:@"TRSH"
                                                                handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
                                                                  CoreDataManager *cdm = [CoreDataManager singleton];
                                                                  [cdm deleteObject:properties_[indexPath.row]];
                                                                  
                                                                  properties_ = [CoreDataRetrieving properties];
                                                                  
                                                                  [self.tableView reloadData];
                                                                }];
  
  return @[trsh, frwrd, fav];
}

#pragma mark - UITableView delegate methods implementation

- (CGFloat)tableView:(UITableView *)tableView
  heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return indexPath.section == 0 ? 200.0f : 70.0f;
}

- (void)tableView:(UITableView *)tableView
  didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
  
  if (indexPath.section == 0)
  {
    NewPropertyViewController *npvc = [[NewPropertyViewController alloc] initWithNibName:nil
                                                                                  bundle:nil];
    [self.navigationController pushViewController:npvc animated:YES];
  }
  else
  {
    HotelDetailsViewController *hdvc = [[HotelDetailsViewController alloc] initWithNibName:nil
                                                                                    bundle:nil];
    hdvc.property = properties_[indexPath.row];
    [self.navigationController pushViewController:hdvc animated:YES];
  }
}

@end