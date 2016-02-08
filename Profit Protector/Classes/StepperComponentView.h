@import UIKit;
#import "TypeDefEnumerators.h"

@interface StepperComponentView : UIView

@property (nonatomic, strong) NSString    *title;
@property (nonatomic, strong) NSString    *prefix;
@property (nonatomic, strong) NSString    *suffix;
@property                     NSInteger   stepByValue;
@property (nonatomic)         NumericType numericType;
@property (nonatomic, strong) NSString    *key;
@property (nonatomic, strong) NSNumber    *value;
@property (nonatomic)         CGFloat     height;
@property (nonatomic)         NSURL       *url;
@property (nonatomic)         NSInteger   industryStandardValue;

@end