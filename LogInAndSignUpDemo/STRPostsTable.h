//
//  STRPostsTable.h
//  SportyTest2
//
//  Created by נמרוד בר on 08/09/13.
//
//

#import <UIKit/UIKit.h>

@interface STRPostsTable : UIViewController <UITableViewDataSource,UITableViewDelegate,PFSignUpViewControllerDelegate,PFLogInViewControllerDelegate>

// Create users posts
-(void)logOutButtonTapAction;
@end
