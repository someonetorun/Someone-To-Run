//
//  STRInboxVC.h
//  Sporty
//
//  Created by נמרוד בר on 18/11/13.
//
//

#import <UIKit/UIKit.h>

@interface STRInboxVC : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *myInboxTableView;

@end
