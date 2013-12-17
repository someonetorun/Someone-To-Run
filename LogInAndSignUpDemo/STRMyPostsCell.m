//
//  STRMyPostsCell.m
//  Sporty
//
//  Created by נמרוד בר on 11/11/13.
//
//

#import "STRMyPostsCell.h"

@implementation STRMyPostsCell

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
    //setting the labels of the cell according to post data
    
    //set activity type
    self.lblActivityType.text=[post objectForKey:KeyActivityType];
    
    //set activity descreption
    self.lblActivityDesc.text=[post objectForKey:KeyActivityDesc];
    
    //set activity type
    self.lblActivityTime.text=[[AppData sharedInstance] dateOrgenizer:[post valueForKey:KeyActivityTime]];
    
    
    

}

@end
