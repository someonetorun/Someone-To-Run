//
//  User.h
//  ParseStarterProject
//
//  Created by JBH-User on 29/08/2013.
//
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface  User   : PFUser 

@property (strong,nonatomic) NSString *userName;
@property (strong,nonatomic) NSString *userPassword;
@property (strong,nonatomic) NSMutableArray *adsList;
@property (strong,nonatomic) enum userGender;
@property (strong,nonatomic) NSMutableArray *logList;
@property (strong,nonatomic) NSMutableArray *adsFavoritesList;
@property (nonatomic)int phoneNumber;
@property (nonatomic) PFGeoPoint* activityPoint;









@end
