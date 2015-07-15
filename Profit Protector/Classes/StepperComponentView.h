@import UIKit;

@interface StepperComponentView : UIView

@property (nonatomic, strong) NSString  *title;
@property (nonatomic, strong) NSString  *prefix;
@property (nonatomic, strong) NSString  *suffix;
@property                     NSInteger stepByValue;

@end