#import "HotelDetailsViewController.h"
#import "ProfitProtectorStyleKit.h"
#import "GlobalMethods.h"
#import "NewPropertyViewController.h"
#import "AnnualLosesTableViewController.h"
#import "AnnualSavingsTableViewController.h"
#import "NDHTMLtoPDF.h"
#import "HUD.h"
@import MessageUI;

@interface HotelDetailsViewController () <UITableViewDataSource,
                                          UITableViewDelegate,
                                          MFMailComposeViewControllerDelegate>
{
  NSDictionary      *math_;
  
  UILabel           *lifetimeROI_;
  
  UITableView       *uitv_;
  
  BOOL              isProfileSelected_;
  
  NSNumberFormatter *formatter_;
  
  NDHTMLtoPDF       *PDFCreator_;
}
@end

@implementation HotelDetailsViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  formatter_ = [[NSNumberFormatter alloc] init];
  [formatter_ setNumberStyle:NSNumberFormatterCurrencyStyle];
  
  // UI customizations
  self.view.backgroundColor = [UIColor whiteColor];

  self.navigationItem.rightBarButtonItems = @[[[UIBarButtonItem alloc] initWithTitle:@"Edit"
                                                                              style:UIBarButtonItemStylePlain
                                                                           target:self
                                                                           action:@selector(edit:)],
                                             [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"forward"]
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(forward:)]];
  
  // get the math results
  math_ = [GlobalMethods math:self.property];
  
  //
  UISegmentedControl *uisc = [[UISegmentedControl alloc] initWithItems:@[@"Report", @"Profile"]];
  uisc.selectedSegmentIndex = 0;
  uisc.frame = CGRectMake((CGRectGetWidth(self.view.bounds) - (CGRectGetWidth(self.view.bounds) - 20.0f)) / 2.0f,
                          74.0,
                          CGRectGetWidth(self.view.bounds) - 20.0f,
                          33.0f);
  [uisc addTarget:self action:@selector(segmentedControlEventChanged:) forControlEvents:UIControlEventValueChanged];
  uisc.tintColor = [UIColor colorWithRed:0.0f green:0.68f blue:0.94f alpha:1.0f];
  [self.view addSubview:uisc];
  
  uitv_ = [[UITableView alloc] initWithFrame:CGRectMake(0.0f,
                                                        CGRectGetMaxY(uisc.frame) + 10.0f,
                                                        CGRectGetWidth(self.view.bounds),
                                                        CGRectGetHeight(self.view.bounds) - (CGRectGetMaxY(uisc.frame) + 10.0f))
                                       style:UITableViewStylePlain];
  uitv_.dataSource = self;
  uitv_.delegate = self;
  uitv_.separatorColor = [UIColor clearColor];
  [self.view addSubview:uitv_];
  
  isProfileSelected_ = NO;
}

- (void)forward:(NSIndexPath *)indexPath
{
  NSString *html = [[NSString alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"report_receipt" ofType:@"html"]
                                                   encoding:NSASCIIStringEncoding
                                                      error:nil];
  
  NSManagedObject *property = self.property;
  
  NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
  [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
  
  // get the math results
  NSDictionary *math = [GlobalMethods math:property];
  
  // replace the values
  html = [html stringByReplacingOccurrencesOfString:@"[name]" withString:[property valueForKey:@"name"]];
  
  html = [html stringByReplacingOccurrencesOfString:@"[remediationCostsWithout]"
                                         withString:[formatter stringFromNumber:math[@"remediationCostsWithout"]]];
  
  html = [html stringByReplacingOccurrencesOfString:@"[remediationCostsWith]"
                                         withString:[formatter stringFromNumber:math[@"remediationCostsWith"]]];
  
  html = [html stringByReplacingOccurrencesOfString:@"[remediationCostSavings]"
                                         withString:[formatter stringFromNumber:math[@"remediationCostSavings"]]];
  
  html = [html stringByReplacingOccurrencesOfString:@"[lostRevenueWithout]"
                                         withString:[formatter stringFromNumber:math[@"lostRevenueWithout"]]];
  
  html = [html stringByReplacingOccurrencesOfString:@"[lostRevenueWith]"
                                         withString:[formatter stringFromNumber:math[@"lostRevenueWith"]]];
  
  html = [html stringByReplacingOccurrencesOfString:@"[lostRevenueSavings]"
                                         withString:[formatter stringFromNumber:math[@"lostRevenueSavings"]]];
  
  html = [html stringByReplacingOccurrencesOfString:@"[propertyDamageWithout]"
                                         withString:[formatter stringFromNumber:math[@"propertyDamageWithout"]]];
  
  html = [html stringByReplacingOccurrencesOfString:@"[propertyDamageWith]"
                                         withString:[formatter stringFromNumber:math[@"propertyDamageWith"]]];
  
  html = [html stringByReplacingOccurrencesOfString:@"[propertyDamageSavings]"
                                         withString:[formatter stringFromNumber:math[@"propertyDamageSavings"]]];
  
  html = [html stringByReplacingOccurrencesOfString:@"[customerGrievanceCostsWithout]"
                                         withString:[formatter stringFromNumber:math[@"customerGrievanceCostsWithout"]]];
  
  html = [html stringByReplacingOccurrencesOfString:@"[brandDamageWithout]"
                                         withString:[formatter stringFromNumber:math[@"brandDamageWithout"]]];
  
  html = [html stringByReplacingOccurrencesOfString:@"[brandDamageSavings]"
                                         withString:[formatter stringFromNumber:math[@"brandDamageSavings"]]];
  
  html = [html stringByReplacingOccurrencesOfString:@"[totalLossesPerBedBugInfestationIncidentWithout]"
                                         withString:[formatter stringFromNumber:math[@"totalLossesPerBedBugInfestationIncidentWithout"]]];
  
  html = [html stringByReplacingOccurrencesOfString:@"[totalLossesPerBedBugInfestationIncidentWith]"
                                         withString:[formatter stringFromNumber:math[@"totalLossesPerBedBugInfestationIncidentWith"]]];
  
  html = [html stringByReplacingOccurrencesOfString:@"[totalLossesPerBedBugInfestationIncidentSavings]"
                                         withString:[formatter stringFromNumber:math[@"totalLossesPerBedBugInfestationIncidentSavings"]]];
  
  html = [html stringByReplacingOccurrencesOfString:@"[totalAnnualBedBugInfestationLossesWithout]"
                                         withString:[formatter stringFromNumber:math[@"totalAnnualBedBugInfestationLossesWithout"]]];
  
  html = [html stringByReplacingOccurrencesOfString:@"[totalAnnualBedBugInfestationLossesWith]"
                                         withString:[formatter stringFromNumber:math[@"totalAnnualBedBugInfestationLossesWith"]]];
  
  html = [html stringByReplacingOccurrencesOfString:@"[totalAnnualBedBugInfestationLossesSavings]"
                                         withString:[formatter stringFromNumber:math[@"totalAnnualBedBugInfestationLossesSavings"]]];
  
  html = [html stringByReplacingOccurrencesOfString:@"[mattressSpoilageCostsPerYear]"
                                         withString:[formatter stringFromNumber:math[@"mattressSpoilageCostsPerYear"]]];
  
  html = [html stringByReplacingOccurrencesOfString:@"[mattressSpoilageCostsPerYear]"
                                         withString:[formatter stringFromNumber:math[@"mattressSpoilageCostsPerYear"]]];
  
  html = [html stringByReplacingOccurrencesOfString:@"[preemptiveEncasementLaunderingCostsSavings]"
                                         withString:[formatter stringFromNumber:math[@"preemptiveEncasementLaunderingCostsSavings"]]];
  
  html = [html stringByReplacingOccurrencesOfString:@"[preemptiveEncasementLaunderingCostsSavings]"
                                         withString:[formatter stringFromNumber:math[@"preemptiveEncasementLaunderingCostsSavings"]]];
  
  html = [html stringByReplacingOccurrencesOfString:@"[totalAnnualCostsLossesWithout]"
                                         withString:[formatter stringFromNumber:math[@"totalAnnualCostsLossesWithout"]]];
  
  html = [html stringByReplacingOccurrencesOfString:@"[totalAnnualCostsLossesWith]"
                                         withString:[formatter stringFromNumber:math[@"totalAnnualCostsLossesWith"]]];
  
  html = [html stringByReplacingOccurrencesOfString:@"[totalAnnualCostsLossesSavings]"
                                         withString:[formatter stringFromNumber:math[@"totalAnnualCostsLossesSavings"]]];
  
  html = [html stringByReplacingOccurrencesOfString:@"[totalLifetimeSavingsFromEncasingWithCleanRestPro]"
                                         withString:[formatter stringFromNumber:math[@"totalLifetimeSavingsFromEncasingWithCleanRestPro"]]];
  
  html = [html stringByReplacingOccurrencesOfString:@"[totalInvestmentToEncaseAllBeds]"
                                         withString:[formatter stringFromNumber:math[@"totalInvestmentToEncaseAllBeds"]]];
  
  html = [html stringByReplacingOccurrencesOfString:@"[roi]"
                                         withString:[formatter stringFromNumber:math[@"roi"]]];
  
  html = [html stringByReplacingOccurrencesOfString:@"[lifetimeSavingsEncasementInvestment]"
                                         withString:[NSString stringWithFormat:@"%@x", [math[@"lifetimeSavingsEncasementInvestment"] stringValue]]];
  
  html = [html stringByReplacingOccurrencesOfString:@"[encasementInvestmentPaybackInMonths]"
                                         withString:[math[@"encasementInvestmentPaybackInMonths"] stringValue]];
  
  html = [html stringByReplacingOccurrencesOfString:@"[bedBugIncidents]"
                                         withString:[[property valueForKey:@"bedBugIncidents"] stringValue]];
  
  __block NSString *pdfFilename = [NSString stringWithFormat:@"CleanRest Pro Savings Report %@.pdf", [NSDate date]];
  __block NSString *pdfPath = [[NSString stringWithFormat:@"~/Documents/%@.pdf", pdfFilename] stringByExpandingTildeInPath];
  
  PDFCreator_ = [NDHTMLtoPDF createPDFWithHTML:html
                                       baseURL:nil
                                    pathForPDF:pdfPath
                                      pageSize:CGSizeMake(500.0f, 650.0f)
                                       margins:UIEdgeInsetsZero
                                  successBlock:^(NDHTMLtoPDF *htmlToPDF) {
                                    [uitv_ reloadData];
                                    
                                    PDFCreator_ = nil;
                                    
                                    if ([MFMailComposeViewController canSendMail])
                                    {
                                      MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
                                      picker.navigationBar.tintColor = [UIColor darkGrayColor];
                                      picker.mailComposeDelegate = self;
                                      
                                      // body
                                      [picker setSubject:@"CleanRest Pro Savings Report"];
                                      
                                      NSFileManager *fileManager = [NSFileManager defaultManager];
                                      
                                      if ([fileManager fileExistsAtPath:pdfPath])
                                      {
                                        [picker addAttachmentData:[NSData dataWithContentsOfFile:pdfPath]
                                                         mimeType:@"application/pdf"
                                                         fileName:pdfFilename];
                                      }
                                      
                                      [self presentViewController:picker animated:YES completion:nil];
                                    }
                                    else
                                    {
                                      UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                                                      message:@"Device is unable to send email in its current state."
                                                                                     delegate:self
                                                                            cancelButtonTitle:@"OK"
                                                                            otherButtonTitles:nil];
                                      
                                      [alert show];
                                    }
                                  }
                                    errorBlock:^(NDHTMLtoPDF *htmlToPDF) {
                                      PDFCreator_ = nil;
                                    }];
}

- (void)edit:(UIBarButtonItem *)uibbi
{
  NewPropertyViewController *npvc = [[NewPropertyViewController alloc] initWithNibName:nil
                                                                                bundle:nil];
  npvc.property = self.property;
  [self.navigationController pushViewController:npvc animated:YES];
}

- (void)segmentedControlEventChanged:(UISegmentedControl *)uisc
{
  isProfileSelected_ = uisc.selectedSegmentIndex;
  
  [uitv_ reloadData];
}

#pragma mark - UITableView datasource methods implementation

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
  NSInteger count = 0;
  
  if (isProfileSelected_)
    count = 6;
  else
    count = 7;
  
  return count;
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
      details.textColor = [UIColor colorWithRed:0.0f green:0.68f blue:0.94f alpha:1.0f];
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
        
        details.text = [NSString stringWithFormat:@"%ld",
                        [[self.property valueForKey:@"roomsNumber"] integerValue] + [[self.property valueForKey:@"bedsNumber"] integerValue]];
      }
      
      if (indexPath.row == 2)
      {
        float ancillariesRevenuePerRoomPerNight = [[self.property valueForKey:@"ancillariesRevenuePerRoomPerNight"] floatValue];
        float foodBeverageSalesPerRoomPerNight = [[self.property valueForKey:@"foodBeverageSalesPerRoomPerNight"] floatValue];
        float roomRevenuePerNight = [[self.property valueForKey:@"roomRevenuePerNight"] floatValue];
       
        details.text = [formatter_ stringFromNumber:@(ancillariesRevenuePerRoomPerNight + roomRevenuePerNight + foodBeverageSalesPerRoomPerNight)];
      }
      
      if (indexPath.row == 3)
      {
        float costOfReplaceFurnishings = [[self.property valueForKey:@"costOfReplaceFurnishings"] floatValue];
        float costOfReplaceMattressesAndBoxSpring = [[self.property valueForKey:@"costOfReplaceMattressesAndBoxSpring"] floatValue];
        float costToCleanAndReinstallEncasements = [[self.property valueForKey:@"costToCleanAndReinstallEncasements"] floatValue];
        
        details.text = [formatter_ stringFromNumber:@(costOfReplaceFurnishings + costOfReplaceMattressesAndBoxSpring + costToCleanAndReinstallEncasements)];
      }
      
      if (indexPath.row == 4)
      {
        details.text = [NSString stringWithFormat:@"%ld%%",
                        [[self.property valueForKey:@"percentageOfMattressesReplaceEachYear"] integerValue]];
      }
      
      if (indexPath.row == 5)
      {
        details.text = [NSString stringWithFormat:@"%ld",
                        [[self.property valueForKey:@"bedBugIncidents"] integerValue]];
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
      
      if (indexPath.row == 0)
      {
        cell.textLabel.text = @"YOUR ANNUAL LOSES";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.backgroundColor = [UIColor colorWithWhite:0.95f alpha:1.0f];
      }
      
      if (indexPath.row == 1)
      {
        cell.textLabel.text = @"Without Encasements";
        UIImageView *newProperty = [[UIImageView alloc] initWithImage:[ProfitProtectorStyleKit imageOfBadgeWithSize:CGSizeMake(130.0f, 37.0f)
                                                                                                          fillColor:[UIColor whiteColor]
                                                                                                       cornerRadius:7.0f
                                                                                                        strokeColor:[UIColor colorWithRed:0.0f green:0.68f blue:0.94f alpha:1.0f]
                                                                                                        strokeWidth:1.0f
                                                                                                               text:[formatter_ stringFromNumber:math_[@"totalAnnualCostsLossesWithout"]]
                                                                                                          textColor:[UIColor colorWithRed:0.0f green:0.68f blue:0.94f alpha:1.0f]
                                                                                                           textFont:[UIFont fontWithName:@"HelveticaNeue" size:14.0f]]];
        [newProperty sizeToFit];
        newProperty.center = CGPointMake(CGRectGetWidth(cell.bounds) - (CGRectGetWidth(newProperty.bounds) / 2.0f) - 10.f,
                                         CGRectGetHeight(cell.bounds) / 2.0f);
        newProperty.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin |
                                        UIViewAutoresizingFlexibleTopMargin |
                                        UIViewAutoresizingFlexibleBottomMargin);
        [cell.contentView addSubview:newProperty];
      }
      
      if (indexPath.row == 2)
      {
        cell.textLabel.text = @"With Encasements";
        
        UIImageView *newProperty = [[UIImageView alloc] initWithImage:[ProfitProtectorStyleKit imageOfBadgeWithSize:CGSizeMake(130.0f, 37.0f)
                                                                                                          fillColor:[UIColor whiteColor]
                                                                                                       cornerRadius:7.0f
                                                                                                        strokeColor:[UIColor colorWithRed:0.0f green:0.68f blue:0.94f alpha:1.0f]
                                                                                                        strokeWidth:1.0f
                                                                                                               text:[formatter_ stringFromNumber:math_[@"totalAnnualCostsLossesWith"]]
                                                                                                          textColor:[UIColor colorWithRed:0.0f green:0.68f blue:0.94f alpha:1.0f]
                                                                                                           textFont:[UIFont fontWithName:@"HelveticaNeue" size:14.0f]]];
        [newProperty sizeToFit];
        newProperty.center = CGPointMake(CGRectGetWidth(cell.bounds) - (CGRectGetWidth(newProperty.bounds) / 2.0f) - 10.f,
                                         CGRectGetHeight(cell.bounds) / 2.0f);
        newProperty.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin |
                                        UIViewAutoresizingFlexibleTopMargin |
                                        UIViewAutoresizingFlexibleBottomMargin);
        [cell.contentView addSubview:newProperty];
      }
      
      if (indexPath.row == 3)
      {
        cell.textLabel.text = @"YOUR ANNUAL SAVINGS";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.backgroundColor = [UIColor colorWithWhite:0.95f alpha:1.0f];
      }
      
      if (indexPath.row == 4)
      {
        cell.textLabel.text = @"Total Preemptive Savings";
        
        UIImageView *newProperty = [[UIImageView alloc] initWithImage:[ProfitProtectorStyleKit imageOfBadgeWithSize:CGSizeMake(130.0f, 37.0f)
                                                                                                          fillColor:[UIColor whiteColor]
                                                                                                       cornerRadius:7.0f
                                                                                                        strokeColor:[UIColor colorWithRed:0.0f green:0.68f blue:0.94f alpha:1.0f]
                                                                                                        strokeWidth:1.0f
                                                                                                               text:[formatter_ stringFromNumber:math_[@"totalAnnualCostsLossesPreemptive"]]
                                                                                                          textColor:[UIColor colorWithRed:0.0f green:0.68f blue:0.94f alpha:1.0f]
                                                                                                           textFont:[UIFont fontWithName:@"HelveticaNeue" size:14.0f]]];
        [newProperty sizeToFit];
        newProperty.center = CGPointMake(CGRectGetWidth(cell.bounds) - (CGRectGetWidth(newProperty.bounds) / 2.0f) - 10.f,
                                         CGRectGetHeight(cell.bounds) / 2.0f);
        newProperty.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin |
                                        UIViewAutoresizingFlexibleTopMargin |
                                        UIViewAutoresizingFlexibleBottomMargin);
        [cell.contentView addSubview:newProperty];
      }
      
      if (indexPath.row == 5)
      {
        cell.textLabel.text = @"LIFETIME RETURN OF INVESTMENT";
        cell.backgroundColor = [UIColor colorWithWhite:0.95f alpha:1.0f];
      }
      
      if (indexPath.row == 6)
      {
        cell.textLabel.text = @"CleanRest Pro ROI";
        
        UIImageView *newProperty = [[UIImageView alloc] initWithImage:[ProfitProtectorStyleKit imageOfBadgeWithSize:CGSizeMake(130.0f, 37.0f)
                                                                                                          fillColor:[UIColor whiteColor]
                                                                                                       cornerRadius:7.0f
                                                                                                        strokeColor:[UIColor colorWithRed:0.0f green:0.68f blue:0.94f alpha:1.0f]
                                                                                                        strokeWidth:1.0f
                                                                                                               text:[formatter_ stringFromNumber:math_[@"roi"]]//[formatter_ stringFromNumber:math_[@"totalAnnualCostsLossesWithout"]]
                                                                                                          textColor:[UIColor colorWithRed:0.0f green:0.68f blue:0.94f alpha:1.0f]
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
  }
  
  cell.textLabel.numberOfLines = 2;
  cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:14.0f];
  cell.selectionStyle = UITableViewCellSelectionStyleNone;
  
  return cell;
}

#pragma mark - UITableView delegate methods implementation

- (CGFloat)tableView:(UITableView *)tableView
  heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  if (!isProfileSelected_)
  {
    if (indexPath.row == 0 ||
        indexPath.row == 3 ||
        indexPath.row == 5)
      return 34.0f;
    
    return 64.0f;
  }
  
  return 44.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
  
  if (indexPath.row == 0)
  {
    AnnualLosesTableViewController *altvc = [[AnnualLosesTableViewController alloc] initWithStyle:UITableViewStylePlain];
    altvc.math = math_;
    [self.navigationController pushViewController:altvc animated:YES];
  }
 
  if (indexPath.row == 3)
  {
    AnnualSavingsTableViewController *astvc = [[AnnualSavingsTableViewController alloc] initWithStyle:UITableViewStylePlain];
    astvc.math = math_;
    [self.navigationController pushViewController:astvc animated:YES];
  }
}

#pragma mark - MFMailComposeViewController delegate methods implementation

- (void)mailComposeController:(MFMailComposeViewController *)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError *)error
{
  [controller dismissViewControllerAnimated:YES completion:nil];
}

@end