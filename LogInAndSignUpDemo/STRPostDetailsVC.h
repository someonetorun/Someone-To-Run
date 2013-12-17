//
//  STRPostDetailsVC.h
//  Sporty
//
//  Created by נמרוד בר on 31/10/13.
//
//

#import <UIKit/UIKit.h>
#import "STRPost.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "MapLocation.h"

@interface STRPostDetailsVC : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *lblUserName;
@property (weak, nonatomic) IBOutlet UILabel *lblActivityDesc;
@property (weak, nonatomic) IBOutlet UILabel *lblActivityType;
@property (weak, nonatomic) IBOutlet UILabel *lblCreatedAt;
@property (weak, nonatomic) IBOutlet UILabel *lblActivityTime;
@property (weak, nonatomic) IBOutlet UILabel *lblUserPhoneNumber;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@property (strong, nonatomic) NSDictionary* currentPost;

@end
