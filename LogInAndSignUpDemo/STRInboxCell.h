//
//  STRInboxCell.h
//  Sporty
//
//  Created by נמרוד בר on 18/11/13.
//
//

#import <UIKit/UIKit.h>

@interface STRInboxCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblUserName;
-(void)SetCurrentPostInCell:(NSDictionary*)post;
@end
