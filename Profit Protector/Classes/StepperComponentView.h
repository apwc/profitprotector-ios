@import UIKit;
#import "TypeDefEnumerators.h"

@interface StepperComponentView : UIView

@property (nonatomic, strong) NSString    *title;
@property (nonatomic, strong) NSString    *prefix;
@property (nonatomic, strong) NSString    *suffix;
@property                     NSInteger   stepByValue;
@property (nonatomic)         NumericType numericType;

@end