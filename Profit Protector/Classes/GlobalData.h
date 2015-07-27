#import "Singleton.h"

@interface GlobalData : Singleton

@property (nonatomic) float numberOfBeds;
@property (nonatomic) float percentage;
@property (nonatomic) float costPerBed;

@end