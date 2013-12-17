//
//  STRUserDetailsVC.h
//  Sporty
//
//  Created by נמרוד בר on 10/11/13.
//
//

#import <UIKit/UIKit.h>

@interface STRUserDetailsVC : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *IVUserImage;
@property (weak, nonatomic) IBOutlet UILabel *lblUserSex;
@property (weak, nonatomic) IBOutlet UILabel *lblUserName;
@property (weak, nonatomic) IBOutlet UILabel *lblMyPhone;
@property (weak, nonatomic) IBOutlet UITableView *MyPostsTableView;

@end
