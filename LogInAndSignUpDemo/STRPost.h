//
//  STRPost.h
//  SportyTest2
//
//  Created by JBH-User on 09/09/13.
//
//

#import <Foundation/Foundation.h>

typedef enum
{
    running,
    swimming,
    walking,
    gim,
    tennis,
    basketball,
    soccer,
    bicycle,
    spiritual,
    other
}activityTypes;

typedef enum
{
    olympic,
    athlete,
    amature,
    lazyAss
    
}workoutLevels;

@interface STRPost : NSObject

@property (strong, nonatomic) PFUser* user;
@property (strong, nonatomic) NSString* activityDesc;
@property (strong, nonatomic) NSString* activityType;
//@property (nonatomic) PFGeoPoint* UserHomePoint;
@property (nonatomic) PFGeoPoint* activityPoint;
@property (strong, nonatomic) NSString* workoutLevel;
//@property (nonatomic, strong) NSString* cellPhone;
@property (nonatomic, strong) NSDate* activityTime;

@end
