//
//  STRMyPostsCell.h
//  Sporty
//
//  Created by נמרוד בר on 11/11/13.
//
//

#import <UIKit/UIKit.h>

@interface STRMyPostsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblActivityDesc;
@property (weak, nonatomic) IBOutlet UILabel *lblActivityTime;
@property (weak, nonatomic) IBOutlet UILabel *lblActivityType;
@property (weak, nonatomic) IBOutlet UIImageView *imgActivityType;
@property (weak, nonatomic) IBOutlet UIImageView *imgUserProfile;


-(void)SetCurrentPostInCell:(NSDictionary*)post;

@end
