//
//  CellForAdsList.h
//  Sporty
//
//  Created by Ariel Peremen on 9/9/13.
//
//

#import <UIKit/UIKit.h>

@interface STRPostCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblActivityDesc;
@property (weak, nonatomic) IBOutlet UILabel *lblPostTime;
@property (weak, nonatomic) IBOutlet UILabel *lblDestanceFromActivty;
@property (weak, nonatomic) IBOutlet UILabel *lblActivityTime;
@property (weak, nonatomic) IBOutlet UILabel *lblActivityType;
@property (weak, nonatomic) IBOutlet UIImageView *imgActivityType;
@property (weak, nonatomic) IBOutlet UIImageView *imgUserProfile;
@property (weak, nonatomic) IBOutlet UILabel *lblUserName;


-(void)SetCurrentPostInCell:(NSDictionary*)post;
@end
