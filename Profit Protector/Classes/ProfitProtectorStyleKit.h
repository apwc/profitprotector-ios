@import Foundation;
@import UIKit;

@interface ProfitProtectorStyleKit : NSObject

+ (UIImage *)imageOfBadgeWithSize:(CGSize)size
                        fillColor:(UIColor *)fillColor
                     cornerRadius:(CGFloat)cornerRadius
                      strokeColor:(UIColor *)strokeColor
                      strokeWidth:(CGFloat)strokeWidth
                             text:(NSString *)text
                        textColor:(UIColor *)textColor
                         textFont:(UIFont *)textFont;

@end