//
//  STRAddNewPostVC.h
//  SportyTest2
//
//  Created by נמרוד בר on 08/09/13.
//
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "MapLocation.h"
#import "STRPost.h"

@interface STRAddNewPostVC : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *lblSportLoc;

@property (weak, nonatomic) IBOutlet UILabel *lblActivityDate;
@property (weak, nonatomic) IBOutlet UITextField *lblSportDescr;
- (IBAction)txtEditingDone:(UITextField *)sender;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segActivityType;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segWorkoutLevel;
@property (weak, nonatomic) IBOutlet UIButton *btnChangeDate;
@property (weak, nonatomic) IBOutlet UIButton *btnSetDate;



@property (nonatomic, strong) NSDate* currentPostTime;
@property (nonatomic, strong) NSDate* currentActivityTime;


@end
