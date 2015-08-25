#import "FrontTableViewController.h"
#import "MainViewController.h"
#import "ProfitProtectorStyleKit.h"
#import "NewPropertyViewController.h"
#import "HotelDetailsViewController.h"
#import "CoreDataRetrieving.h"
#import "CoreDataStoring.h"
#import "GlobalMethods.h"
#import "API.h"
#import "NDHTMLtoPDF.h"
#import "HUD.h"
@import MessageUI;

@interface FrontTableViewController () <UITableViewDataSource,
                                        UITableViewDelegate,
                                        MFMailComposeViewControllerDelegate>
{
  NSArray     *properties_;
  UILabel     *name_;
  
  UIButton    *new_;
  
  BOOL        isExpanded_;
  UIButton    *chevron_;
  
  UITableView *uitv_;
  
  NDHTMLtoPDF *PDFCreator_;
}
@end

@implementation FrontTableViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  // UI customizations
  self.view.backgroundColor = [UIColor colorWithRed:0.91 green:0.9 blue:0.9 alpha:1];
  
  isExpanded_ = YES;
  
  // UI customizations
  self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu"]
                                                                           style:UIBarButtonItemStylePlain
                                                                          target:self
                                                                          action:@selector(showLeftViewController:)];
  
  self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                                                                                         target:self
                                                                                         action:@selector(allProperties:)];
  
  // new property
  new_ = [UIButton buttonWithType:UIButtonTypeCustom];
  new_.frame = CGRectMake(0.0f, 64.0f, CGRectGetWidth(self.view.frame), CGRectGetWidth(self.view.frame));
  [new_ setImage:[UIImage imageNamed:@"walkthroughPage2"] forState:UIControlStateNormal];
  [new_ setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
  [new_ addTarget:self action:@selector(addProperty:) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:new_];
  
  // properties list
  uitv_ = [[UITableView alloc] initWithFrame:CGRectMake(0.0f,
                                                        CGRectGetMaxY(new_.frame),
                                                        CGRectGetWidth(self.view.frame),
                                                        CGRectGetHeight(self.view.frame) - CGRectGetMaxY(new_.frame))];
  uitv_.dataSource = self;
  uitv_.delegate = self;
  uitv_.bounces = NO;
  [self.view addSubview:uitv_];
  
  // accordion
  chevron_ = [UIButton buttonWithType:UIButtonTypeCustom];
  chevron_.frame = CGRectMake(CGRectGetWidth(self.view.frame) - 58.0f,
                              CGRectGetMaxY(new_.frame) - 14.0f,
                              48.0f,
                              48.0f);
  chevron_.backgroundColor = [UIColor whiteColor];
  chevron_.layer.cornerRadius = 24.0f;
  chevron_.layer.borderColor = [UIColor lightGrayColor].CGColor;
  chevron_.layer.borderWidth = 1.0f;
  [chevron_ setImage:[UIImage imageNamed:@"up"] forState:UIControlStateNormal];
  [chevron_ addTarget:self action:@selector(accordion:) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:chevron_];
  
  //
  [self allProperties:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  
  //
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(apiUserPropertiesSuccessful:)
                                               name:apiUserPropertiesSuccessfulNotification
                                             object:nil];
  
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(apiUserPropertyDeleteSuccessful:)
                                               name:apiUserPropertyDeleteSuccessfulNotification
                                             object:nil];
  
  properties_ = [CoreDataRetrieving allProperties];
  
  [uitv_ reloadData];
}

- (void)viewWillDisappear:(BOOL)animated
{
  [super viewWillDisappear:animated];
  
  [[NSNotificationCenter defaultCenter] removeObserver:self
                                                  name:apiUserPropertiesSuccessfulNotification
                                                object:nil];
  
  [[NSNotificationCenter defaultCenter] removeObserver:self
                                                  name:apiUserPropertyDeleteSuccessfulNotification
                                                object:nil];
}

- (void)showLeftViewController:(UIBarButtonItem *)uibbi
{
  MainViewController *mvc = (MainViewController *)self.parentViewController.parentViewController;
  [mvc showViewController:mvc.leftViewController];
}

- (void)allProperties:(UIBarButtonItem *)uibbi
{
  [API getProperties];
}

- (void)addProperty:(UIButton *)uib
{
  NewPropertyViewController *npvc = [[NewPropertyViewController alloc] initWithNibName:nil
                                                                                bundle:nil];
  [self.navigationController pushViewController:npvc animated:YES];
}

- (void)accordion:(UIButton *)uib
{
  isExpanded_ = !isExpanded_;
  
  if (isExpanded_)
  {
    [chevron_ setImage:[UIImage imageNamed:@"up"] forState:UIControlStateNormal];
    
    [UIView animateWithDuration:0.25f
                     animations:^{
                       chevron_.center = CGPointMake(chevron_.center.x,
                                                     CGRectGetMaxY(new_.frame) + 10.0f);
                       
                       uitv_.frame = CGRectMake(0.0f,
                                                CGRectGetMaxY(new_.frame),
                                                CGRectGetWidth(self.view.frame),
                                                CGRectGetHeight(self.view.frame) - 264.0f);
                     }];
  }
  else
  {
    [chevron_ setImage:[UIImage imageNamed:@"down"] forState:UIControlStateNormal];
    
    [UIView animateWithDuration:0.25f
                     animations:^{
                       chevron_.center = CGPointMake(chevron_.center.x, 74.0f);
                       
                       uitv_.frame = CGRectMake(0.0f,
                                                64.0f,
                                                CGRectGetWidth(self.view.frame),
                                                CGRectGetHeight(self.view.frame) - 64.0f);
                     }];
  }
}

- (void)forward:(NSIndexPath *)indexPath
{
  NSString *html = [[NSString alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"report_receipt" ofType:@"html"]
                                                   encoding:NSASCIIStringEncoding
                                                      error:nil];
  
  NSManagedObject *property = properties_[indexPath.row];
  
  NSNumberFormatter *formatter_ = [[NSNumberFormatter alloc] init];
  [formatter_ setNumberStyle:NSNumberFormatterCurrencyStyle];
  
  // get the math results
  NSDictionary *math = [GlobalMethods math:property];
  
  // replace the values
  html = [html stringByReplacingOccurrencesOfString:@"[name]" withString:[property valueForKey:@"name"]];
  
  html = [html stringByReplacingOccurrencesOfString:@"[remediationCostsWithout]"
                                         withString:[formatter_ stringFromNumber:math[@"remediationCostsWithout"]]];
  
  html = [html stringByReplacingOccurrencesOfString:@"[remediationCostsWith]"
                                         withString:[formatter_ stringFromNumber:math[@"remediationCostsWith"]]];
  
  html = [html stringByReplacingOccurrencesOfString:@"[remediationCostSavings]"
                                         withString:[formatter_ stringFromNumber:math[@"remediationCostSavings"]]];
  
  html = [html stringByReplacingOccurrencesOfString:@"[lostRevenueWithout]"
                                         withString:[formatter_ stringFromNumber:math[@"lostRevenueWithout"]]];
  
  html = [html stringByReplacingOccurrencesOfString:@"[lostRevenueWith]"
                                         withString:[formatter_ stringFromNumber:math[@"lostRevenueWith"]]];
  
  html = [html stringByReplacingOccurrencesOfString:@"[lostRevenueSavings]"
                                         withString:[formatter_ stringFromNumber:math[@"lostRevenueSavings"]]];
  
  html = [html stringByReplacingOccurrencesOfString:@"[propertyDamageWithout]"
                                         withString:[formatter_ stringFromNumber:math[@"propertyDamageWithout"]]];
  
  html = [html stringByReplacingOccurrencesOfString:@"[propertyDamageWith]"
                                         withString:[formatter_ stringFromNumber:math[@"propertyDamageWith"]]];
  
  html = [html stringByReplacingOccurrencesOfString:@"[propertyDamageSavings]"
                                         withString:[formatter_ stringFromNumber:math[@"propertyDamageSavings"]]];
  
  html = [html stringByReplacingOccurrencesOfString:@"[customerGrievanceCostsWithout]"
                                         withString:[formatter_ stringFromNumber:math[@"customerGrievanceCostsWithout"]]];
  
  html = [html stringByReplacingOccurrencesOfString:@"[brandDamageWithout]"
                                         withString:[formatter_ stringFromNumber:math[@"brandDamageWithout"]]];
  
  html = [html stringByReplacingOccurrencesOfString:@"[brandDamageSavings]"
                                         withString:[formatter_ stringFromNumber:math[@"brandDamageSavings"]]];

  html = [html stringByReplacingOccurrencesOfString:@"[totalLossesPerBedBugInfestationIncidentWithout]"
                                         withString:[formatter_ stringFromNumber:math[@"totalLossesPerBedBugInfestationIncidentWithout"]]];
  
  html = [html stringByReplacingOccurrencesOfString:@"[totalLossesPerBedBugInfestationIncidentWith]"
                                         withString:[formatter_ stringFromNumber:math[@"totalLossesPerBedBugInfestationIncidentWith"]]];
  
  html = [html stringByReplacingOccurrencesOfString:@"[totalLossesPerBedBugInfestationIncidentSavings]"
                                         withString:[formatter_ stringFromNumber:math[@"totalLossesPerBedBugInfestationIncidentSavings"]]];
  
  html = [html stringByReplacingOccurrencesOfString:@"[totalAnnualBedBugInfestationLossesWithout]"
                                         withString:[formatter_ stringFromNumber:math[@"totalAnnualBedBugInfestationLossesWithout"]]];
  
  html = [html stringByReplacingOccurrencesOfString:@"[totalAnnualBedBugInfestationLossesWith]"
                                         withString:[formatter_ stringFromNumber:math[@"totalAnnualBedBugInfestationLossesWith"]]];
  
  html = [html stringByReplacingOccurrencesOfString:@"[totalAnnualBedBugInfestationLossesSavings]"
                                         withString:[formatter_ stringFromNumber:math[@"totalAnnualBedBugInfestationLossesSavings"]]];
  
  html = [html stringByReplacingOccurrencesOfString:@"[mattressSpoilageCostsPerYear]"
                                         withString:[formatter_ stringFromNumber:math[@"mattressSpoilageCostsPerYear"]]];
  
  html = [html stringByReplacingOccurrencesOfString:@"[mattressSpoilageCostsPerYear]"
                                         withString:[formatter_ stringFromNumber:math[@"mattressSpoilageCostsPerYear"]]];
  
  html = [html stringByReplacingOccurrencesOfString:@"[preemptiveEncasementLaunderingCostsSavings]"
                                         withString:[formatter_ stringFromNumber:math[@"preemptiveEncasementLaunderingCostsSavings"]]];
  
  html = [html stringByReplacingOccurrencesOfString:@"[preemptiveEncasementLaunderingCostsSavings]"
                                         withString:[formatter_ stringFromNumber:math[@"preemptiveEncasementLaunderingCostsSavings"]]];
  
  html = [html stringByReplacingOccurrencesOfString:@"[totalAnnualCostsLossesWithout]"
                                         withString:[formatter_ stringFromNumber:math[@"totalAnnualCostsLossesWithout"]]];
  
  html = [html stringByReplacingOccurrencesOfString:@"[totalAnnualCostsLossesWith]"
                                         withString:[formatter_ stringFromNumber:math[@"totalAnnualCostsLossesWith"]]];
  
  html = [html stringByReplacingOccurrencesOfString:@"[totalAnnualCostsLossesSavings]"
                                         withString:[formatter_ stringFromNumber:math[@"totalAnnualCostsLossesSavings"]]];
  
  html = [html stringByReplacingOccurrencesOfString:@"[totalLifetimeSavingsFromEncasingWithCleanRestPro]"
                                         withString:[formatter_ stringFromNumber:math[@"totalLifetimeSavingsFromEncasingWithCleanRestPro"]]];
  
  html = [html stringByReplacingOccurrencesOfString:@"[totalInvestmentToEncaseAllBeds]"
                                         withString:[formatter_ stringFromNumber:math[@"totalInvestmentToEncaseAllBeds"]]];
  
  html = [html stringByReplacingOccurrencesOfString:@"[roi]"
                                         withString:[formatter_ stringFromNumber:math[@"roi"]]];
  
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

#pragma mark - API notifications callbacks

- (void)apiUserPropertiesSuccessful:(NSNotification *)notification
{
  NSArray *array = (NSArray *)notification.object;
  
  properties_ = [CoreDataRetrieving allProperties];
  
  [properties_ enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
    NSManagedObject *property = (NSManagedObject *)obj;
    
    CoreDataManager *cdm = [CoreDataManager singleton];
    [cdm deleteObject:property];
    [cdm saveData];
  }];
  
  [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
    [CoreDataStoring storeProperty:obj];
  }];
  
  properties_ = [CoreDataRetrieving allProperties];
  
  [uitv_ reloadData];
}

- (void)apiUserPropertyDeleteSuccessful:(NSNotification *)notification
{
  properties_ = [CoreDataRetrieving allProperties];
  
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
  return [properties_ count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  NSString *cellReusableIdentifier = [NSString stringWithFormat:@"cellReusableIdentifier%ld%ld",
                                      indexPath.section,
                                      indexPath.row];
  
  UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                 reuseIdentifier:cellReusableIdentifier];
  cell.clipsToBounds = YES;
  
  NSManagedObject *property = properties_[indexPath.row];
  
  NSNumberFormatter *formatter_ = [[NSNumberFormatter alloc] init];
  [formatter_ setNumberStyle:NSNumberFormatterCurrencyStyle];
  
  // get the math results
  NSDictionary *math = [GlobalMethods math:property];
  
  UIImageView *newProperty = [[UIImageView alloc] initWithImage:[ProfitProtectorStyleKit imageOfBadgeWithSize:CGSizeMake(130.0f, 37.0f)
                                                                                                    fillColor:[UIColor whiteColor]
                                                                                                 cornerRadius:7.0f
                                                                                                  strokeColor:[UIColor colorWithRed:0.0f green:0.68f blue:0.94f alpha:1.0f]
                                                                                                  strokeWidth:1.0f
                                                                                                         text:[formatter_ stringFromNumber:math[@"roi"]]
                                                                                                    textColor:[UIColor colorWithRed:0.0f green:0.68f blue:0.94f alpha:1.0f]
                                                                                                     textFont:[UIFont fontWithName:@"HelveticaNeue" size:14.0f]]];
  [newProperty sizeToFit];
  newProperty.center = CGPointMake(CGRectGetWidth(cell.bounds) - (CGRectGetWidth(newProperty.bounds) / 2.0f) - 10.f,
                                   CGRectGetHeight(cell.bounds) / 2.0f);
  newProperty.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin |
                                  UIViewAutoresizingFlexibleTopMargin |
                                  UIViewAutoresizingFlexibleBottomMargin);
  [cell.contentView addSubview:newProperty];
  
  //
  name_ = [[UILabel alloc] initWithFrame:CGRectZero];
  name_.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:16.0f];
  name_.numberOfLines = 2;
  name_.autoresizingMask = UIViewAutoresizingFlexibleHeight;
  [cell.contentView addSubview:name_];
  
  name_.text = [property valueForKey:@"name"];
  
  if ([[property valueForKey:@"favorite"] boolValue])
  {
    cell.imageView.image = [UIImage imageNamed:@"fav"];
    
    name_.frame = CGRectMake(40.0f,
                             0.0f,
                             CGRectGetWidth(cell.bounds) - 150.0f - 10.0f - (cell.imageView.image.size.width + 10.0f),
                             CGRectGetHeight(cell.bounds));
  }
  else
  {
    cell.imageView.image = nil;
    
    name_.frame =  CGRectMake(10.0f,
                              0.0f,
                              CGRectGetWidth(cell.bounds) - 135.0f - 10.0f - (cell.imageView.image.size.width + 10.0f),
                              CGRectGetHeight(cell.bounds));
  }
  
  return cell;
}

- (BOOL)tableView:(UITableView *)tableView
  canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
  return YES;
}

- (void)tableView:(UITableView *)tableView
  commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
  forRowAtIndexPath:(NSIndexPath *)indexPath
{
}

- (NSArray *)tableView:(UITableView *)tableView
  editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
  __block NSManagedObject *property = properties_[indexPath.row];
  
  BOOL isFavorited = [[property valueForKey:@"favorite"] boolValue];
  
  UITableViewRowAction *fav = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal
                                                                 title:isFavorited ? @"UNFAV" : @"FAV"
                                                               handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
                                                                 
                                                                 if (isFavorited)
                                                                   [property setValue:@(NO) forKey:@"favorite"];
                                                                 else
                                                                   [property setValue:@(YES) forKey:@"favorite"];
                                                                 
                                                                 CoreDataManager *cdm = [CoreDataManager singleton];
                                                                 [cdm saveData];
                                                                 
                                                                 properties_ = [CoreDataRetrieving allProperties];
                                                                 
                                                                 [uitv_ reloadData];
                                                               }];
  fav.backgroundColor = [UIColor colorWithRed:0.89 green:0.88 blue:0.13 alpha:1];
  
  UITableViewRowAction *frwrd = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal
                                                                   title:@"FRWRD"
                                                                 handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
                                                                   [self forward:indexPath];
                                                                 }];
  frwrd.backgroundColor = [UIColor colorWithRed:0 green:0.83 blue:0 alpha:1];
  
  UITableViewRowAction *trsh = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive
                                                                  title:@"TRSH"
                                                                handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
                                                                  [API deleteProperty:properties_[indexPath.row]];
                                                                }];
  
  return @[trsh, frwrd, fav];
}

#pragma mark - UITableView delegate methods implementation

- (CGFloat)tableView:(UITableView *)tableView
  heightForHeaderInSection:(NSInteger)section
{
  return 32.0f;
}

- (UIView *)tableView:(UITableView *)tableView
  viewForHeaderInSection:(NSInteger)section
{
  UILabel *holder = [[UILabel alloc] initWithFrame:CGRectZero];
  holder.textAlignment = NSTextAlignmentCenter;
  holder.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:18.0f];
  holder.textColor = [UIColor colorWithRed:0.28 green:0.69 blue:0.92 alpha:1];
  holder.backgroundColor = [UIColor colorWithWhite:0.95f alpha:1.0f];
  holder.text = @"PROPERTIES";
  return holder;
}

- (CGFloat)tableView:(UITableView *)tableView
  heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return 70.0f;
}

- (void)tableView:(UITableView *)tableView
  didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
  
  HotelDetailsViewController *hdvc = [[HotelDetailsViewController alloc] initWithNibName:nil
                                                                                  bundle:nil];
  hdvc.property = properties_[indexPath.row];
  [self.navigationController pushViewController:hdvc animated:YES];
}

#pragma mark - MFMailComposeViewController delegate methods implementation

- (void)mailComposeController:(MFMailComposeViewController *)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError *)error
{
  [controller dismissViewControllerAnimated:YES completion:nil];
}

@end