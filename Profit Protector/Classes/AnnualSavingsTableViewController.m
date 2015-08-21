#import "AnnualSavingsTableViewController.h"
#import "ProfitProtectorStyleKit.h"

@interface AnnualSavingsTableViewController ()
{
  NSNumberFormatter *formatter_;
}
@end

@implementation AnnualSavingsTableViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  self.title = @"ANNUAL SAVINGS";
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
      cell.textLabel.text = @"Total Lifetime Savings\nfrom Encasing\nw/ CleanRest Pro";
      
      UIImageView *newProperty = [[UIImageView alloc] initWithImage:[ProfitProtectorStyleKit imageOfBadgeWithSize:CGSizeMake(130.0f, 37.0f)
                                                                                                        fillColor:[UIColor whiteColor]
                                                                                                     cornerRadius:7.0f
                                                                                                      strokeColor:[UIColor colorWithRed:0.0f green:0.68f blue:0.94f alpha:1.0f]
                                                                                                      strokeWidth:1.0f
                                                                                                             text:[formatter_ stringFromNumber:self.math[@"totalAnnualCostsLossesWithout"]]
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
      cell.textLabel.text = @"Total Investment to\nEncase all Beds";
      
      UIImageView *newProperty = [[UIImageView alloc] initWithImage:[ProfitProtectorStyleKit imageOfBadgeWithSize:CGSizeMake(130.0f, 37.0f)
                                                                                                        fillColor:[UIColor whiteColor]
                                                                                                     cornerRadius:7.0f
                                                                                                      strokeColor:[UIColor colorWithRed:0.0f green:0.68f blue:0.94f alpha:1.0f]
                                                                                                      strokeWidth:1.0f
                                                                                                             text:[formatter_ stringFromNumber:self.math[@"totalAnnualCostsLossesWithout"]]
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
      cell.textLabel.text = @"Lifetime Net Return on\nEncasement Investment";
      
      UIImageView *newProperty = [[UIImageView alloc] initWithImage:[ProfitProtectorStyleKit imageOfBadgeWithSize:CGSizeMake(130.0f, 37.0f)
                                                                                                        fillColor:[UIColor whiteColor]
                                                                                                     cornerRadius:7.0f
                                                                                                      strokeColor:[UIColor colorWithRed:0.0f green:0.68f blue:0.94f alpha:1.0f]
                                                                                                      strokeWidth:1.0f
                                                                                                             text:[formatter_ stringFromNumber:self.math[@"totalAnnualCostsLossesWithout"]]
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
      cell.textLabel.text = @"Lifetime Savings\nEncasement Investment";
      
      UIImageView *newProperty = [[UIImageView alloc] initWithImage:[ProfitProtectorStyleKit imageOfBadgeWithSize:CGSizeMake(130.0f, 37.0f)
                                                                                                        fillColor:[UIColor whiteColor]
                                                                                                     cornerRadius:7.0f
                                                                                                      strokeColor:[UIColor colorWithRed:0.0f green:0.68f blue:0.94f alpha:1.0f]
                                                                                                      strokeWidth:1.0f
                                                                                                             text:[formatter_ stringFromNumber:self.math[@"totalAnnualCostsLossesWithout"]]
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
      cell.textLabel.text = @"Encasement Investment\nPayback in Months";
      
      UIImageView *newProperty = [[UIImageView alloc] initWithImage:[ProfitProtectorStyleKit imageOfBadgeWithSize:CGSizeMake(130.0f, 37.0f)
                                                                                                        fillColor:[UIColor whiteColor]
                                                                                                     cornerRadius:7.0f
                                                                                                      strokeColor:[UIColor colorWithRed:0.0f green:0.68f blue:0.94f alpha:1.0f]
                                                                                                      strokeWidth:1.0f
                                                                                                             text:[formatter_ stringFromNumber:self.math[@"totalAnnualCostsLossesWithout"]]
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
      cell.textLabel.text = @"PREEMTIVE ENCASEMENTS SAVINGS";
      cell.backgroundColor = [UIColor colorWithWhite:0.95f alpha:1.0f];
    }
    
    if (indexPath.row == 6)
    {
      cell.textLabel.text = @"Remediation Costs";
      
      UIImageView *newProperty = [[UIImageView alloc] initWithImage:[ProfitProtectorStyleKit imageOfBadgeWithSize:CGSizeMake(130.0f, 37.0f)
                                                                                                        fillColor:[UIColor whiteColor]
                                                                                                     cornerRadius:7.0f
                                                                                                      strokeColor:[UIColor colorWithRed:0.0f green:0.68f blue:0.94f alpha:1.0f]
                                                                                                      strokeWidth:1.0f
                                                                                                             text:[formatter_ stringFromNumber:self.math[@"totalAnnualCostsLossesWithout"]]
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
      cell.textLabel.text = @"Lost Revenue";
      
      UIImageView *newProperty = [[UIImageView alloc] initWithImage:[ProfitProtectorStyleKit imageOfBadgeWithSize:CGSizeMake(130.0f, 37.0f)
                                                                                                        fillColor:[UIColor whiteColor]
                                                                                                     cornerRadius:7.0f
                                                                                                      strokeColor:[UIColor colorWithRed:0.0f green:0.68f blue:0.94f alpha:1.0f]
                                                                                                      strokeWidth:1.0f
                                                                                                             text:[formatter_ stringFromNumber:self.math[@"totalAnnualCostsLossesWithout"]]
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
      cell.textLabel.text = @"Property Damage";
      
      UIImageView *newProperty = [[UIImageView alloc] initWithImage:[ProfitProtectorStyleKit imageOfBadgeWithSize:CGSizeMake(130.0f, 37.0f)
                                                                                                        fillColor:[UIColor whiteColor]
                                                                                                     cornerRadius:7.0f
                                                                                                      strokeColor:[UIColor colorWithRed:0.0f green:0.68f blue:0.94f alpha:1.0f]
                                                                                                      strokeWidth:1.0f
                                                                                                             text:[formatter_ stringFromNumber:self.math[@"totalAnnualCostsLossesWithout"]]
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
      cell.textLabel.text = @"Brand Damage\n(Lost Future Revenue)";
      
      UIImageView *newProperty = [[UIImageView alloc] initWithImage:[ProfitProtectorStyleKit imageOfBadgeWithSize:CGSizeMake(130.0f, 37.0f)
                                                                                                        fillColor:[UIColor whiteColor]
                                                                                                     cornerRadius:7.0f
                                                                                                      strokeColor:[UIColor colorWithRed:0.0f green:0.68f blue:0.94f alpha:1.0f]
                                                                                                      strokeWidth:1.0f
                                                                                                             text:[formatter_ stringFromNumber:self.math[@"totalAnnualCostsLossesWithout"]]
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
      cell.textLabel.text = @"Total Loses/Bed\nBug Incident";
      
      UIImageView *newProperty = [[UIImageView alloc] initWithImage:[ProfitProtectorStyleKit imageOfBadgeWithSize:CGSizeMake(130.0f, 37.0f)
                                                                                                        fillColor:[UIColor whiteColor]
                                                                                                     cornerRadius:7.0f
                                                                                                      strokeColor:[UIColor colorWithRed:0.0f green:0.68f blue:0.94f alpha:1.0f]
                                                                                                      strokeWidth:1.0f
                                                                                                             text:[formatter_ stringFromNumber:self.math[@"totalAnnualCostsLossesWithout"]]
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
      cell.textLabel.text = @"Total Annual\nInfestation Losses";
      
      UIImageView *newProperty = [[UIImageView alloc] initWithImage:[ProfitProtectorStyleKit imageOfBadgeWithSize:CGSizeMake(130.0f, 37.0f)
                                                                                                        fillColor:[UIColor whiteColor]
                                                                                                     cornerRadius:7.0f
                                                                                                      strokeColor:[UIColor colorWithRed:0.0f green:0.68f blue:0.94f alpha:1.0f]
                                                                                                      strokeWidth:1.0f
                                                                                                             text:[formatter_ stringFromNumber:self.math[@"totalAnnualCostsLossesWithout"]]
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
      cell.textLabel.text = @"Mattress Spoilage\nPer Year";
      
      UIImageView *newProperty = [[UIImageView alloc] initWithImage:[ProfitProtectorStyleKit imageOfBadgeWithSize:CGSizeMake(130.0f, 37.0f)
                                                                                                        fillColor:[UIColor whiteColor]
                                                                                                     cornerRadius:7.0f
                                                                                                      strokeColor:[UIColor colorWithRed:0.0f green:0.68f blue:0.94f alpha:1.0f]
                                                                                                      strokeWidth:1.0f
                                                                                                             text:[formatter_ stringFromNumber:self.math[@"totalAnnualCostsLossesWithout"]]
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
      cell.textLabel.text = @"Preemptive Encasement\nLaundering Costs";
      
      UIImageView *newProperty = [[UIImageView alloc] initWithImage:[ProfitProtectorStyleKit imageOfBadgeWithSize:CGSizeMake(130.0f, 37.0f)
                                                                                                        fillColor:[UIColor whiteColor]
                                                                                                     cornerRadius:7.0f
                                                                                                      strokeColor:[UIColor colorWithRed:0.0f green:0.68f blue:0.94f alpha:1.0f]
                                                                                                      strokeWidth:1.0f
                                                                                                             text:[formatter_ stringFromNumber:self.math[@"totalAnnualCostsLossesWithout"]]
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
      cell.textLabel.text = @"Total Annual Costs/Loses";
      
      UIImageView *newProperty = [[UIImageView alloc] initWithImage:[ProfitProtectorStyleKit imageOfBadgeWithSize:CGSizeMake(130.0f, 37.0f)
                                                                                                        fillColor:[UIColor whiteColor]
                                                                                                     cornerRadius:7.0f
                                                                                                      strokeColor:[UIColor colorWithRed:0.0f green:0.68f blue:0.94f alpha:1.0f]
                                                                                                      strokeWidth:1.0f
                                                                                                             text:[formatter_ stringFromNumber:self.math[@"totalAnnualCostsLossesWithout"]]
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