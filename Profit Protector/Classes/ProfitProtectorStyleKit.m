#import "ProfitProtectorStyleKit.h"

@implementation ProfitProtectorStyleKit

+ (void)drawBadgeWithSize:(CGSize)size
                fillColor:(UIColor *)fillColor
             cornerRadius:(CGFloat)cornerRadius
              strokeColor:(UIColor *)strokeColor
              strokeWidth:(CGFloat)strokeWidth
                     text:(NSString *)text
                textColor:(UIColor *)textColor
                 textFont:(UIFont *)textFont
{
  CGContextRef context = UIGraphicsGetCurrentContext();
  
  CGRect rect = CGRectMake(strokeWidth,
                           strokeWidth,
                           size.width - (strokeWidth * 2.0f),
                           size.height - (strokeWidth * 2.0f));
  
  UIBezierPath *ovalPath;
  UIBezierPath *rectanglePath;
  
  // if we have same width and height, it means we have a circle
  if (size.width == size.height)
  {
    ovalPath = [UIBezierPath bezierPathWithOvalInRect:rect];
    [fillColor setFill];
    [ovalPath fill];
  }
  else
  {
    rectanglePath = [UIBezierPath bezierPathWithRoundedRect:rect
                                               cornerRadius:cornerRadius];
    [fillColor setFill];
    [rectanglePath fill];
  }
  
  if (strokeColor != [UIColor clearColor])
  {
    [strokeColor setStroke];
    
    if (ovalPath)
    {
      ovalPath.lineWidth = strokeWidth;
      [ovalPath stroke];
    }
    
    if (rectanglePath)
    {
      rectanglePath.lineWidth = strokeWidth;
      [rectanglePath stroke];
    }
  }
  
  CGRect textRect = rect;
  {
    NSMutableParagraphStyle *textStyle = NSMutableParagraphStyle.defaultParagraphStyle.mutableCopy;
    textStyle.alignment = NSTextAlignmentCenter;
    
    NSDictionary *textFontAttributes = @{NSFontAttributeName: textFont,
                                         NSForegroundColorAttributeName: textColor,
                                         NSParagraphStyleAttributeName: textStyle};
    
    CGFloat textHeight = [text boundingRectWithSize:CGSizeMake(textRect.size.width - (strokeWidth * 2.0f), INFINITY)
                                            options: NSStringDrawingUsesLineFragmentOrigin
                                         attributes:textFontAttributes
                                            context:nil].size.height;
    
    CGContextSaveGState(context);
    
    CGContextClipToRect(context, textRect);
    
    [text drawInRect:CGRectMake(CGRectGetMinX(rect),
                                CGRectGetMinY(rect) + ((CGRectGetHeight(textRect) - textHeight) / 2),
                                CGRectGetWidth(textRect),
                                textHeight)
      withAttributes:textFontAttributes];
    
    CGContextRestoreGState(context);
  }
}

+ (UIImage *)imageOfBadgeWithSize:(CGSize)size
                        fillColor:(UIColor *)fillColor
                     cornerRadius:(CGFloat)cornerRadius
                      strokeColor:(UIColor *)strokeColor
                      strokeWidth:(CGFloat)strokeWidth
                             text:(NSString *)text
                        textColor:(UIColor *)textColor
                         textFont:(UIFont *)textFont
{
  UIGraphicsBeginImageContextWithOptions(size, NO, 0.0f);
  
  [ProfitProtectorStyleKit drawBadgeWithSize:size
                                   fillColor:fillColor
                                cornerRadius:cornerRadius
                                 strokeColor:strokeColor
                                 strokeWidth:strokeWidth
                                        text:text
                                   textColor:textColor
                                    textFont:textFont];
  
  UIImage *imageOfBadge = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  
  return imageOfBadge;
}

@end