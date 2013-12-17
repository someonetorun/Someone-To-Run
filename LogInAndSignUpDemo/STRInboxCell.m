//
//  STRInboxCell.m
//  Sporty
//
//  Created by נמרוד בר on 18/11/13.
//
//

#import "STRInboxCell.h"

@implementation STRInboxCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)SetCurrentPostInCell:(NSDictionary*)post
{
    PFUser *interstedUser = [PFUser user];
    PFQuery *userQuery = [PFQuery queryWithClassName:@"User"];
    [userQuery getObjectInBackgroundWithId:[post valueForKey:@"ApprovedByUserId"] block:^(PFObject *user, NSError *error)
    {
        self.lblUserName.text = [user valueForKey:@"username"];
    }];
//    self.lblUserName.text = [NSString stringWithFormat:@"%@ is interested in you post", [post value]
}
@end
