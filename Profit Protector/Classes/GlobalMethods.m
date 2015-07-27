#import "GlobalMethods.h"

@implementation GlobalMethods

+ (NSDictionary *)math:(NSManagedObject *)obj
{
  // math calculations
  // values form the database input fields
  float ancillariesRevenuePerRoomPerNight = [[obj valueForKey:@"ancillariesRevenuePerRoomPerNight"] floatValue];
  float bedBugIncidents = [[obj valueForKey:@"bedBugIncidents"] floatValue];
  float bedsNumber = [[obj valueForKey:@"bedsNumber"] doubleValue];
  float bugInspectionAndPestControlFees = [[obj valueForKey:@"bugInspectionAndPestControlFees"] floatValue];
  float costOfReplaceFurnishings = [[obj valueForKey:@"costOfReplaceFurnishings"] floatValue];
  float costOfReplaceMattressesAndBoxSpring = [[obj valueForKey:@"costOfReplaceMattressesAndBoxSpring"] floatValue];
  float costToCleanAndReinstallEncasements = [[obj valueForKey:@"costToCleanAndReinstallEncasements"] floatValue];
  float foodBeverageSalesPerRoomPerNight = [[obj valueForKey:@"foodBeverageSalesPerRoomPerNight"] floatValue];
  //  double grevianceCostsPerInfestation = [[self.property valueForKey:@"grevianceCostsPerInfestation"] doubleValue];
  float percentageOfMattressesReplaceEachYear = [[obj valueForKey:@"percentageOfMattressesReplaceEachYear"] floatValue] / 100.0f;
  float roomRevenuePerNight = [[obj valueForKey:@"roomRevenuePerNight"] floatValue];
  float roomsNumber = [[obj valueForKey:@"roomsNumber"] floatValue];
  float timesPerYearBedClean = [[obj valueForKey:@"timesPerYearBedClean"] floatValue];
  float futureBookingDaysLost = [[obj valueForKey:@"futureBookingDaysLost"] floatValue];
  
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
  
  return @{@"totalAnnualCostsLossesWithout": @(totalAnnualCostsLossesWithout),
           @"totalAnnualCostsLossesWith": @(totalAnnualCostsLossesWith),
           @"totalAnnualCostsLossesPreemptive": @(totalAnnualCostsLossesPreemptive),
           @"roi": @(roi)};
}

@end
