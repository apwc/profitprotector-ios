@import UIKit;

@class UserTypeTableViewController;
@protocol UserTypeDelegate <NSObject>

- (void)userTypeSelected:(NSString *)userType;

@end

@interface UserTypeTableViewController : UITableViewController

@property (nonatomic, unsafe_unretained) id<UserTypeDelegate> delegate;

@end