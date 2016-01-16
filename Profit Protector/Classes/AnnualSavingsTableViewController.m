#import "AnnualSavingsTableViewController.h"
#import "ProfitProtectorStyleKit.h"
#import "GlobalMethods.h"

@interface AnnualSavingsTableViewController ()
{
  NSNumberFormatter *formatter_;
}
@end

@implementation AnnualSavingsTableViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  self.title = [GlobalMethods localizedStringWithKey:@"ANNUAL SAVINGS"];
  
  formatter_ = [[NSNumberFormatter alloc] init];
  [formatter_ setNumberStyle:NSNumberFormatterCurrencyStyle];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
  return 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  NSString *cellIdentifier =[NSString stringWithFormat:@"cellReusableIdentifier%ld%ld",
                             (long)indexPath.section,
                             (long)indexPath.row];
  
  UITableViewCell *cell;
  
  if (!cell)
  {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                  reuseIdentifier:cellIdentifier];

    if (indexPath.row == 0)
    {
      cell.textLabel.text = [GlobalMethods localizedStringWithKey:@"Total Lifetime Savings\nfrom Encasing\nw/ CleanRest Pro"];
      
      UIImageView *newProperty = [[UIImageView alloc] initWithImage:[ProfitProtectorStyleKit imageOfBadgeWithSize:CGSizeMake(130.0f, 37.0f)
                                                                                                        fillColor:[UIColor whiteColor]
                                                                                                     cornerRadius:7.0f
                                                                                                      strokeColor:[UIColor colorWithRed:0.0f green:0.68f blue:0.94f alpha:1.0f]
                                                                                                      strokeWidth:1.0f
                                                                                                             text:[formatter_ stringFromNumber:self.math[@"totalLifetimeSavingsFromEncasingWithCleanRestPro"]]
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

    if (indexPath.row == 1)
    {
      cell.textLabel.text = [GlobalMethods localizedStringWithKey:@"Total Investment to\nEncase all Beds"];
      
      UIImageView *newProperty = [[UIImageView alloc] initWithImage:[ProfitProtectorStyleKit imageOfBadgeWithSize:CGSizeMake(130.0f, 37.0f)
                                                                                                        fillColor:[UIColor whiteColor]
                                                                                                     cornerRadius:7.0f
                                                                                                      strokeColor:[UIColor colorWithRed:0.0f green:0.68f blue:0.94f alpha:1.0f]
                                                                                                      strokeWidth:1.0f
                                                                                                             text:[formatter_ stringFromNumber:self.math[@"totalInvestmentToEncaseAllBeds"]]
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
      cell.textLabel.text = [GlobalMethods localizedStringWithKey:@"Lifetime Net Return on\nEncasement Investment"];
      
      UIImageView *newProperty = [[UIImageView alloc] initWithImage:[ProfitProtectorStyleKit imageOfBadgeWithSize:CGSizeMake(130.0f, 37.0f)
                                                                                                        fillColor:[UIColor whiteColor]
                                                                                                     cornerRadius:7.0f
                                                                                                      strokeColor:[UIColor colorWithRed:0.0f green:0.68f blue:0.94f alpha:1.0f]
                                                                                                      strokeWidth:1.0f
                                                                                                             text:[formatter_ stringFromNumber:self.math[@"roi"]]
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
      cell.textLabel.text = [GlobalMethods localizedStringWithKey:@"Lifetime Savings\nEncasement Investment"];
      
      UIImageView *newProperty = [[UIImageView alloc] initWithImage:[ProfitProtectorStyleKit imageOfBadgeWithSize:CGSizeMake(130.0f, 37.0f)
                                                                                                        fillColor:[UIColor whiteColor]
                                                                                                     cornerRadius:7.0f
                                                                                                      strokeColor:[UIColor colorWithRed:0.0f green:0.68f blue:0.94f alpha:1.0f]
                                                                                                      strokeWidth:1.0f
                                                                                                             text:[formatter_ stringFromNumber:self.math[@"lifetimeSavingsEncasementInvestment"]]
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
    
    if (indexPath.row == 4)
    {
      cell.textLabel.text = [GlobalMethods localizedStringWithKey:@"Encasement Investment\nPayback in Months"];
      
      UIImageView *newProperty = [[UIImageView alloc] initWithImage:[ProfitProtectorStyleKit imageOfBadgeWithSize:CGSizeMake(130.0f, 37.0f)
                                                                                                        fillColor:[UIColor whiteColor]
                                                                                                     cornerRadius:7.0f
                                                                                                      strokeColor:[UIColor colorWithRed:0.0f green:0.68f blue:0.94f alpha:1.0f]
                                                                                                      strokeWidth:1.0f
                                                                                                             text:[formatter_ stringFromNumber:self.math[@"encasementInvestmentPaybackInMonths"]]
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
      cell.textLabel.text = [GlobalMethods localizedStringWithKey:@"PREEMTIVE ENCASEMENTS SAVINGS"];
      cell.backgroundColor = [UIColor colorWithWhite:0.95f alpha:1.0f];
    }
    
    if (indexPath.row == 6)
    {
      cell.textLabel.text = [GlobalMethods localizedStringWithKey:@"Remediation Costs"];
      
      UIImageView *newProperty = [[UIImageView alloc] initWithImage:[ProfitProtectorStyleKit imageOfBadgeWithSize:CGSizeMake(130.0f, 37.0f)
                                                                                                        fillColor:[UIColor whiteColor]
                                                                                                     cornerRadius:7.0f
                                                                                                      strokeColor:[UIColor colorWithRed:0.0f green:0.68f blue:0.94f alpha:1.0f]
                                                                                                      strokeWidth:1.0f
                                                                                                             text:[formatter_ stringFromNumber:self.math[@"remediationCostSavings"]]
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
    
    if (indexPath.row == 7)
    {
      cell.textLabel.text = [GlobalMethods localizedStringWithKey:@"Lost Revenue"];
      
      UIImageView *newProperty = [[UIImageView alloc] initWithImage:[ProfitProtectorStyleKit imageOfBadgeWithSize:CGSizeMake(130.0f, 37.0f)
                                                                                                        fillColor:[UIColor whiteColor]
                                                                                                     cornerRadius:7.0f
                                                                                                      strokeColor:[UIColor colorWithRed:0.0f green:0.68f blue:0.94f alpha:1.0f]
                                                                                                      strokeWidth:1.0f
                                                                                                             text:[formatter_ stringFromNumber:self.math[@"lostRevenueSavings"]]
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
    
    if (indexPath.row == 8)
    {
      cell.textLabel.text = [GlobalMethods localizedStringWithKey:@"Property Damage"];
      
      UIImageView *newProperty = [[UIImageView alloc] initWithImage:[ProfitProtectorStyleKit imageOfBadgeWithSize:CGSizeMake(130.0f, 37.0f)
                                                                                                        fillColor:[UIColor whiteColor]
                                                                                                     cornerRadius:7.0f
                                                                                                      strokeColor:[UIColor colorWithRed:0.0f green:0.68f blue:0.94f alpha:1.0f]
                                                                                                      strokeWidth:1.0f
                                                                                                             text:[formatter_ stringFromNumber:self.math[@"propertyDamageSavings"]]
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
    
    if (indexPath.row == 9)
    {
      cell.textLabel.text = [GlobalMethods localizedStringWithKey:@"Brand Damage\n(Lost Future Revenue)"];
      
      UIImageView *newProperty = [[UIImageView alloc] initWithImage:[ProfitProtectorStyleKit imageOfBadgeWithSize:CGSizeMake(130.0f, 37.0f)
                                                                                                        fillColor:[UIColor whiteColor]
                                                                                                     cornerRadius:7.0f
                                                                                                      strokeColor:[UIColor colorWithRed:0.0f green:0.68f blue:0.94f alpha:1.0f]
                                                                                                      strokeWidth:1.0f
                                                                                                             text:[formatter_ stringFromNumber:self.math[@"brandDamageSavings"]]
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
    
    if (indexPath.row == 10)
    {
      cell.textLabel.text = [GlobalMethods localizedStringWithKey:@"Total Loses/Bed\nBug Incident"];
      
      UIImageView *newProperty = [[UIImageView alloc] initWithImage:[ProfitProtectorStyleKit imageOfBadgeWithSize:CGSizeMake(130.0f, 37.0f)
                                                                                                        fillColor:[UIColor whiteColor]
                                                                                                     cornerRadius:7.0f
                                                                                                      strokeColor:[UIColor colorWithRed:0.0f green:0.68f blue:0.94f alpha:1.0f]
                                                                                                      strokeWidth:1.0f
                                                                                                             text:[formatter_ stringFromNumber:self.math[@"totalLossesPerBedBugInfestationIncidentSavings"]]
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
    
    if (indexPath.row == 11)
    {
      cell.textLabel.text = [GlobalMethods localizedStringWithKey:@"Total Annual\nInfestation Losses"];
      
      UIImageView *newProperty = [[UIImageView alloc] initWithImage:[ProfitProtectorStyleKit imageOfBadgeWithSize:CGSizeMake(130.0f, 37.0f)
                                                                                                        fillColor:[UIColor whiteColor]
                                                                                                     cornerRadius:7.0f
                                                                                                      strokeColor:[UIColor colorWithRed:0.0f green:0.68f blue:0.94f alpha:1.0f]
                                                                                                      strokeWidth:1.0f
                                                                                                             text:[formatter_ stringFromNumber:self.math[@"totalAnnualBedBugInfestationLossesSavings"]]
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
    
    if (indexPath.row == 12)
    {
      cell.textLabel.text = [GlobalMethods localizedStringWithKey:@"Mattress Spoilage\nPer Year"];
      
      UIImageView *newProperty = [[UIImageView alloc] initWithImage:[ProfitProtectorStyleKit imageOfBadgeWithSize:CGSizeMake(130.0f, 37.0f)
                                                                                                        fillColor:[UIColor whiteColor]
                                                                                                     cornerRadius:7.0f
                                                                                                      strokeColor:[UIColor colorWithRed:0.0f green:0.68f blue:0.94f alpha:1.0f]
                                                                                                      strokeWidth:1.0f
                                                                                                             text:[formatter_ stringFromNumber:self.math[@"totalAnnualCostsLossesSavings"]]
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
    
    if (indexPath.row == 13)
    {
      cell.textLabel.text = [GlobalMethods localizedStringWithKey:@"Preemptive Encasement\nLaundering Costs"];
      
      UIImageView *newProperty = [[UIImageView alloc] initWithImage:[ProfitProtectorStyleKit imageOfBadgeWithSize:CGSizeMake(130.0f, 37.0f)
                                                                                                        fillColor:[UIColor whiteColor]
                                                                                                     cornerRadius:7.0f
                                                                                                      strokeColor:[UIColor colorWithRed:0.0f green:0.68f blue:0.94f alpha:1.0f]
                                                                                                      strokeWidth:1.0f
                                                                                                             text:[formatter_ stringFromNumber:self.math[@"preemptiveEncasementLaunderingCostsSavings"]]
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
    
    if (indexPath.row == 14)
    {
      cell.textLabel.text = [GlobalMethods localizedStringWithKey:@"Total Annual Costs/Loses"];
      
      UIImageView *newProperty = [[UIImageView alloc] initWithImage:[ProfitProtectorStyleKit imageOfBadgeWithSize:CGSizeMake(130.0f, 37.0f)
                                                                                                        fillColor:[UIColor whiteColor]
                                                                                                     cornerRadius:7.0f
                                                                                                      strokeColor:[UIColor colorWithRed:0.0f green:0.68f blue:0.94f alpha:1.0f]
                                                                                                      strokeWidth:1.0f
                                                                                                             text:[formatter_ stringFromNumber:self.math[@"totalAnnualCostsLossesSavings"]]
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
  
  cell.textLabel.numberOfLines = 3;
  cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:14.0f];
  cell.selectionStyle = UITableViewCellSelectionStyleNone;
  
  return cell;
}

#pragma mark - UITableView delegate methods implementation

- (CGFloat)tableView:(UITableView *)tableView
  heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  if (indexPath.row == 5)
    return 34.0f;
  
  return 64.0f;
}

@end