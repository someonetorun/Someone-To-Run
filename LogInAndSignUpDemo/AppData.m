//
//  WIAppData.m
//  iTrade
//
//  Created by Ariel Peremen on 8/11/13.
//  Copyright (c) 2013 Wabbit. All rights reserved.
//

#import "AppData.h"


@interface AppData () <CLLocationManagerDelegate>

@property (strong, nonatomic) CLLocationManager* locationManager;
@property (strong, nonatomic) CLLocation* currentLocation;


@end

static AppData* staticInstance;


@implementation AppData



//creating the singletone

+(AppData*)sharedInstance
{
    if (staticInstance==nil)
    {
        staticInstance=[AppData new];
    }
    return staticInstance;
}

- (id)init
{
    
    return self;
}

-(CLLocation*) getCurrentLocation
{
    //Get the current location of the user to show the close-Locations Posts
    if (self.locationManager == nil) {
        self.locationManager = [[CLLocationManager alloc]init];
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest ;
    }
    [self.locationManager startUpdatingLocation];
    self.locationManager.delegate = self;
    
    self.currentLocation = self.locationManager.location;
    
    return self.currentLocation;
}
-(NSString*) dateOrgenizer: (NSDate*) dateToOrgenize
{
    //creat the format for the time stamp
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM 'at' HH:mm"];
    
    //******* in the futur- compere the date with the current date and retrive a word ("היום״ ״אתמול)********
    
    //create the time stamp
    //NSDate * now = [NSDate date];
    
    
    //Change the time stamp to a string
    NSString *formattedDateString = [dateFormatter stringFromDate:dateToOrgenize];
    return formattedDateString;
}

@end