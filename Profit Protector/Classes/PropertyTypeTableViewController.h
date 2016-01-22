@import UIKit;
#import "TypeDefEnumerators.h"

@protocol PropertyTypeDelegate <NSObject>

- (void)propertyTypeDidSelect:(PropertyType)propertyType;

@end

@interface PropertyTypeTableViewController : UITableViewController

@property (nonatomic, unsafe_unretained) id<PropertyTypeDelegate> delegate;

@end