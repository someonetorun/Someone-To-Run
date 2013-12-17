//
//  CellForAdsList.m
//  Sporty
//
//  Created by Ariel Peremen on 9/9/13.
//
//

#import "STRPostCell.h"

@implementation STRPostCell

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
    //set the activity Descreption
    self.lblActivityDesc.text = [post valueForKey:KeyActivityDesc];
    //set the activity Time
    NSString *activityTime=[[AppData sharedInstance] dateOrgenizer:[post valueForKey:KeyActivityTime]];
    self.lblActivityTime.text = activityTime;
     //set the activity Type
    self.lblActivityType.text = [post valueForKey:KeyActivityType];
    //set the activity Type
    NSString *postCreated= [[AppData sharedInstance]dateOrgenizer:[post valueForKey:KeyCreatedAt]];
    self.lblPostTime.text= postCreated;

    //set username label
    self.lblUserName.text=[post valueForKey:KeyUserName];
    
    
    
    
    
    //calculate distance from activity
    CLLocation* currentLoction = [[AppData sharedInstance] getCurrentLocation];
    PFGeoPoint* postGeoPoint = [post valueForKey:KeyActivityLocation];
    CLLocation* postLocation = [[CLLocation alloc]initWithLatitude:postGeoPoint.latitude longitude:postGeoPoint.longitude];

    
    CLLocationDistance distanceFromActivity = [currentLoction distanceFromLocation:postLocation];
    
    
    
    self.lblDestanceFromActivty.text = [NSString stringWithFormat:@"%.1f", distanceFromActivity];
    
}

@end
