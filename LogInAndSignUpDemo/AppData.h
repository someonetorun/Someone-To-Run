//
//  WIAppData.h
//  iTrade
//
//  Created by Ariel Peremen on 8/11/13.
//  Copyright (c) 2013 Wabbit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import <CoreLocation/CoreLocation.h>


@interface AppData : NSObject <NSURLConnectionDataDelegate,UIAlertViewDelegate>

@property (strong, nonatomic)User *user;
@property (strong, nonatomic) User *currentUser;


//function to create the single tone
+(AppData*)sharedInstance;

//Get current location
-(CLLocation*) getCurrentLocation;

-(NSString*) dateOrgenizer: (NSDate*) dateToOrgenize;


@end
