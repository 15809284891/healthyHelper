#import <UIKit/UIKit.h>
@class PersonView;
@interface PersonController : UIViewController<UITableViewDataSource,UITableViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIAlertViewDelegate>
@property(nonatomic)UITableView *tableView;
@property(nonatomic)PersonView *personView;

@end
