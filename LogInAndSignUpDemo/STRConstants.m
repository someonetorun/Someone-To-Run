//
//  STRConstants.m
//  Sporty
//
//  Created by Ariel Peremen on 10/25/13.
//
//

///username objectId activityTime activityType activityDesc serverData Phone

#import "STRConstants.h"

@implementation STRConstants : NSObject 

NSString *const MyThingNotificationKey = @"MyThingNotificationKey";

//app key words
NSString *const KeyUserName= @"username";
NSString *const KeyActivityTime= @"activityTime";
NSString *const KeyActivityType= @"activityType";
NSString *const KeyActivityDesc= @"activityDesc";
NSString *const KeyPhoneNumber=@"Phone";
NSString *const KeyWorkoutLevel=@"workoutLevel";
NSString *const KeyActivityLocation=@"location";

//server keys
NSString *const KeyUser= @"user";
NSString *const KeyObjectId= @"objectId";
NSString *const KeyCreatedAt= @"createdAt";
NSString *const KeyClassUser= @"User";
NSString *const KeyClassPosts= @"Posts";
NSString *const KeyEstimatedData= @"estimatedData";
NSString *const KeyServerData= @"serverData";


//app parameters
int const RadiosForPostSearch=50000;

//languges
NSString *const KeyMenuHome=@"פעילות";
NSString *const KeymenuMessegesBox= @"תיבת הודעות";
NSString *const KeyMenuUserDetails=@"פרטים אישיים";
NSString *const KeyMenuRunning=@"ריצה";
NSString *const KeyMenuSwimming=@"שחייה";
NSString *const KeyMenuGim=@"חדר כושר";
NSString *const KeyMenuWalking=@"הליכה";
NSString *const KeyMenuTennis=@"טניס";
NSString *const KeyMenuGroups=@"קבוצות";
NSString *const KeyMenuOther=@"אחר..";
NSString *const KeyMenuAboutUs=@"עלינו";
NSString *const KeyMenuReport=@"דווח";
NSString *const KeyMenuLogOut=@"התנתק";


@end
