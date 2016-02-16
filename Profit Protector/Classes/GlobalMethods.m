#import "GlobalMethods.h"
#import "GlobalData.h"

@interface GlobalMethods () <NSXMLParserDelegate>
{
  NSMutableString *resultString_;
}
@end

@implementation GlobalMethods

+ (NSDictionary *)math:(NSManagedObject *)obj
{
  // math calculations
  // values form the database input fields
  float ancillariesRevenuePerRoomPerNight = [[obj valueForKey:@"ancillariesRevenuePerRoomPerNight"] floatValue];
  float bedBugIncidents = [[obj valueForKey:@"bedBugIncidents"] floatValue];
  float occupancyRate = [[obj valueForKey:@"occupancyRate"] doubleValue] / 100.0f;
  float bedsNumber = [[obj valueForKey:@"bedsNumber"] doubleValue];
  float bugInspectionAndPestControlFees = [[obj valueForKey:@"bugInspectionAndPestControlFees"] floatValue];
  float costOfReplaceFurnishings = [[obj valueForKey:@"costOfReplaceFurnishings"] floatValue];
  float costOfReplaceMattressesAndBoxSpring = [[obj valueForKey:@"costOfReplaceMattressesAndBoxSpring"] floatValue];
  float costToCleanAndReinstallEncasements = [[obj valueForKey:@"costToCleanAndReinstallEncasements"] floatValue];
  float foodBeverageSalesPerRoomPerNight = [[obj valueForKey:@"foodBeverageSalesPerRoomPerNight"] floatValue];
  float grievanceCosts = [[obj valueForKey:@"grievanceCosts"] floatValue];
  float percentageOfMattressesReplaceEachYear = [[obj valueForKey:@"percentageOfMattressesReplaceEachYear"] floatValue] / 100.0f;
  float roomRevenuePerNight = [[obj valueForKey:@"roomRevenuePerNight"] floatValue];
  float roomsNumber = [[obj valueForKey:@"roomsNumber"] floatValue];
  float timesPerYearBedClean = [[obj valueForKey:@"timesPerYearBedClean"] floatValue];
  float futureBookingDaysLost = [[obj valueForKey:@"futureBookingDaysLost"] floatValue];
  float preemptivePestControlRetainer = [[obj valueForKey:@"preemptivePestControlRetainer"] floatValue];
  
  // constants
  float encasementCommercialWarrantyLifeSavingsPeriod = 10.0f;
  float costOfCleanRestProQueenMattressAndBoxSpringEncasements = 80.0f;
  
  float roomsTreatedPerInfestationWithout = 3.75f;
  float roomsTreatedPerInfestationWith = 1.0f;
  
  float typicalRemediationCostPerRoomWithout = 750.0f;
  float typicalRemediationCostPerRoomWith = 500.0f;
  float daysLostToRemediationTreatmentWithout = 5.0f;
  float daysLostToRemediationTreatmentWith = 3.0f;
  
  float percentageOfRoomsExperiencePropertyDamageFromInfestationWithout = 0.25f;
  float percentageOfRoomsExperiencePropertyDamageFromInfestationWith = 0.0f;
  
  float a2 = 17.614f;
  float a3 = -62.8260f;
  float a4 = 80.9360f;
  float a5 = -44.0440f;
  float a6 = 10.1000f;
  float a7 = -0.7979f;
  float a8 = 0.0078f;

  float revenueLossRateFromRoomClosuresMyHotel = a2 * powf(occupancyRate, 6) + a3 * powf(occupancyRate, 5) + a4 * powf(occupancyRate, 4) + a5 * powf(occupancyRate, 3) + a6 * powf(occupancyRate, 2) + a7 * occupancyRate + a8;
  float revenueLossRateFromRoomClosuresIndustryEstimate = 0.16f;
  
  float yourBedBugIncidentRate = bedBugIncidents / roomsNumber;
  
  // sums
  float remediationCostsWithout = roomsTreatedPerInfestationWithout * typicalRemediationCostPerRoomWithout;
  float remediationCostsWith = roomsTreatedPerInfestationWith * typicalRemediationCostPerRoomWith;
  float remediationCostSavings = remediationCostsWithout - remediationCostsWith;
  
  float lostRevenueWithout = daysLostToRemediationTreatmentWithout * (roomRevenuePerNight + foodBeverageSalesPerRoomPerNight + ancillariesRevenuePerRoomPerNight) * roomsTreatedPerInfestationWithout * revenueLossRateFromRoomClosuresMyHotel;
  float lostRevenueWith = daysLostToRemediationTreatmentWith * (roomRevenuePerNight + foodBeverageSalesPerRoomPerNight + ancillariesRevenuePerRoomPerNight) * roomsTreatedPerInfestationWith * revenueLossRateFromRoomClosuresIndustryEstimate;
  float lostRevenueSavings = lostRevenueWithout - lostRevenueWith;
  
  float propertyDamageWithout = (roomsTreatedPerInfestationWithout * percentageOfRoomsExperiencePropertyDamageFromInfestationWithout) * ((bedsNumber / roomsNumber) * costOfReplaceMattressesAndBoxSpring + costOfReplaceFurnishings);
  float propertyDamageWith = (roomsTreatedPerInfestationWith * percentageOfRoomsExperiencePropertyDamageFromInfestationWith) * (bedsNumber / roomsNumber) * (costOfReplaceMattressesAndBoxSpring + costOfReplaceFurnishings);
  float propertyDamageSavings = propertyDamageWithout - propertyDamageWith;
  
  float customerGrievanceCostsWithout = grievanceCosts;//bugInspectionAndPestControlFees;
  
  float brandDamageWithout = futureBookingDaysLost * (roomRevenuePerNight + foodBeverageSalesPerRoomPerNight + ancillariesRevenuePerRoomPerNight);
  float brandDamageSavings = brandDamageWithout;
  
  float totalLossesPerBedBugInfestationIncidentWithout = remediationCostsWithout + lostRevenueWithout + propertyDamageWithout + customerGrievanceCostsWithout + brandDamageWithout;
  float totalLossesPerBedBugInfestationIncidentWith = remediationCostsWith + lostRevenueWith + propertyDamageWith;
  float totalLossesPerBedBugInfestationIncidentSavings = remediationCostSavings + lostRevenueSavings + propertyDamageSavings + brandDamageSavings;
  
  float totalAnnualBedBugInfestationLossesWithout = totalLossesPerBedBugInfestationIncidentWithout * yourBedBugIncidentRate * roomsNumber;
  float totalAnnualBedBugInfestationLossesWith = totalLossesPerBedBugInfestationIncidentWith * yourBedBugIncidentRate * roomsNumber;
  float totalAnnualBedBugInfestationLossesSavings = totalAnnualBedBugInfestationLossesWithout - totalAnnualBedBugInfestationLossesWith;
  
  float mattressSpoilageCostsPerYear = bedsNumber * percentageOfMattressesReplaceEachYear * costOfReplaceMattressesAndBoxSpring;
  
  float preemptiveEncasementLaunderingCostsWith = timesPerYearBedClean * costToCleanAndReinstallEncasements * bedsNumber;
  
  float preemptiveEncasementLaunderingCostsSavings = preemptiveEncasementLaunderingCostsWith;

  float preemptivePestControlRetainerCostPerYearWith = preemptivePestControlRetainer / 100.0f * 12.0f * roomsNumber;
  
  float preemptiveEncasementLaunderingCostsPerYearWith = timesPerYearBedClean * costToCleanAndReinstallEncasements * bedsNumber;
  
  float totalAnnualCostsLossesWithout = totalAnnualBedBugInfestationLossesWithout + mattressSpoilageCostsPerYear;
  
  float totalAnnualCostsLossesWith = totalAnnualBedBugInfestationLossesWith + preemptiveEncasementLaunderingCostsWith + preemptivePestControlRetainerCostPerYearWith + preemptiveEncasementLaunderingCostsPerYearWith;
  
  float totalAnnualCostsLossesSavings = totalAnnualCostsLossesWithout - totalAnnualCostsLossesWith;
  
  float totalAnnualCostsLossesPreemptive = totalAnnualCostsLossesWithout - totalAnnualCostsLossesWith;
  
  float totalLifetimeSavingsFromEncasingWithCleanRestPro = totalAnnualCostsLossesPreemptive * encasementCommercialWarrantyLifeSavingsPeriod;
  
  float totalInvestmentToEncaseAllBeds = costOfCleanRestProQueenMattressAndBoxSpringEncasements * bedsNumber;
  
  float roi = totalLifetimeSavingsFromEncasingWithCleanRestPro - totalInvestmentToEncaseAllBeds;
  
  float lifetimeSavingsEncasementInvestment = totalLifetimeSavingsFromEncasingWithCleanRestPro / totalInvestmentToEncaseAllBeds;

  float encasementInvestmentPaybackInMonths = 12 / (totalAnnualCostsLossesPreemptive / totalInvestmentToEncaseAllBeds);

  return @{@"yourBedBugIncidentRate": @(yourBedBugIncidentRate),
           @"yourBedBugIncidentRate": @(yourBedBugIncidentRate),
           @"remediationCostsWithout": @(remediationCostsWithout),
           @"remediationCostsWith": @(remediationCostsWith),
           @"remediationCostSavings": @(remediationCostSavings),
           @"lostRevenueWithout": @(lostRevenueWithout),
           @"lostRevenueWith": @(lostRevenueWith),
           @"lostRevenueSavings": @(lostRevenueSavings),
           @"propertyDamageWithout": @(propertyDamageWithout),
           @"propertyDamageWith": @(propertyDamageWith),
           @"propertyDamageSavings": @(propertyDamageSavings),
           @"customerGrievanceCostsWithout": @(customerGrievanceCostsWithout),
           @"brandDamageWithout": @(brandDamageWithout),
           @"brandDamageSavings": @(brandDamageSavings),
           @"totalLossesPerBedBugInfestationIncidentWithout": @(totalLossesPerBedBugInfestationIncidentWithout),
           @"totalLossesPerBedBugInfestationIncidentWith": @(totalLossesPerBedBugInfestationIncidentWith),
           @"totalLossesPerBedBugInfestationIncidentSavings": @(totalLossesPerBedBugInfestationIncidentSavings),
           @"totalAnnualBedBugInfestationLossesWithout": @(totalAnnualBedBugInfestationLossesWithout),
           @"totalAnnualBedBugInfestationLossesWith": @(totalAnnualBedBugInfestationLossesWith),
           @"mattressSpoilageCostsPerYear": @(mattressSpoilageCostsPerYear),
           @"preemptiveEncasementLaunderingCostsWith": @(preemptiveEncasementLaunderingCostsWith),
           @"totalAnnualCostsLossesWithout": @(totalAnnualCostsLossesWithout),
           @"totalAnnualCostsLossesWith": @(totalAnnualCostsLossesWith),
           @"totalAnnualCostsLossesPreemptive": @(totalAnnualCostsLossesPreemptive),
           @"totalLifetimeSavingsFromEncasingWithCleanRestPro": @(totalLifetimeSavingsFromEncasingWithCleanRestPro),
           @"totalInvestmentToEncaseAllBeds": @(totalInvestmentToEncaseAllBeds),
           @"roi": @(roi),
           @"lifetimeSavingsEncasementInvestment": @(lifetimeSavingsEncasementInvestment),
           @"encasementInvestmentPaybackInMonths": @(encasementInvestmentPaybackInMonths),
           @"totalAnnualCostsLossesSavings": @(totalAnnualCostsLossesSavings),
           @"totalAnnualBedBugInfestationLossesSavings": @(totalAnnualBedBugInfestationLossesSavings),
           @"preemptiveEncasementLaunderingCostsSavings": @(preemptiveEncasementLaunderingCostsSavings)};
}

+ (NSString *)localizedStringWithKey:(NSString *)key
{
  NSString *languageFilePath = [[NSBundle mainBundle] pathForResource:[GlobalData languageID]
                                                               ofType:@"json"];
  
  NSData *languageData = [NSData dataWithContentsOfFile:languageFilePath];
  
  // we do not have even the language file
  if (!languageData)
    return nil;
  
  NSError *error;
  
  NSDictionary *dictionary = (NSDictionary *)[NSJSONSerialization JSONObjectWithData:languageData
                                                                             options:0
                                                                               error:&error];

  NSLog(@"%@ = %@", key, dictionary[key]);
  
  return dictionary[key] ? dictionary[key] : @"|MISSING TRANSLATION|";
}

- (NSString *)stringByDecodingXMLEntities:(NSString *)string
{
  resultString_ = [NSMutableString stringWithCapacity:0];
  
  NSString *xmlStr = [NSString stringWithFormat:@"<d>%@</d>", string];
  
  NSData *data = [xmlStr dataUsingEncoding:NSUTF8StringEncoding
                      allowLossyConversion:YES];
  
  NSXMLParser* xmlParse = [[NSXMLParser alloc] initWithData:data];
  [xmlParse setDelegate:self];
  [xmlParse parse];
  
  return [NSString stringWithFormat:@"%@", resultString_];
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)s
{
  [resultString_ appendString:s];
}

@end