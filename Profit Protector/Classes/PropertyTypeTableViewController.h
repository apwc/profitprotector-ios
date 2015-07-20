@import UIKit;

@protocol PropertyTypeDelegate <NSObject>

- (void)propertyTypeDidSelect:(NSString *)propertyType;

@end

@interface PropertyTypeTableViewController : UITableViewController

@property (nonatomic, unsafe_unretained) id<PropertyTypeDelegate> delegate;

@end