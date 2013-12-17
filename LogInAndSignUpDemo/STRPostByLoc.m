//
//  STRPostByLoc.m
//  Sporty
//
//  Created by נמרוד בר on 24/10/13.
//
//

#import "STRPostByLoc.h"


@interface STRPostByLoc () <CLLocationManagerDelegate>
@property (strong, nonatomic) CLLocationManager* locationManager;
@property (strong, nonatomic) CLLocation* currentLocation;
@end

@implementation STRPostByLoc

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if (self.locationManager == nil) {
        self.locationManager = [[CLLocationManager alloc]init];
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest ;
    }
    [self.locationManager startUpdatingLocation];
    self.locationManager.delegate = self;
    
    self.currentLocation = self.locationManager.location;
    [self getTextByLoc];
}

-(void) getPosts
{
    PFQuery *query = [PFQuery queryWithClassName:@"Posts"];
    [query whereKey:KeyActivityType equalTo:@"running"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d scores.", objects.count);
            // Do something with the found objects
            NSString *postsLblInfo = [[NSString alloc]init];
            for (PFObject *object in objects) {

                NSDictionary *userDict = [object valueForKey:@"estimatedData"];
                
                postsLblInfo = [NSString stringWithFormat:@"%@\n%@", postsLblInfo, [userDict valueForKey:@"text"]];
                                NSLog(@"%@", [userDict valueForKey:@"text"]);
                NSLog(@"%@",self.currentLocation);
            }
            self.lblInfo.text = [NSString stringWithFormat:@"%@", postsLblInfo];
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
        
    }];
}

-(void) getTextByLoc
{
    PFGeoPoint *currentGeoPoint = [PFGeoPoint new];
    currentGeoPoint.latitude = self.currentLocation.coordinate.latitude;
    currentGeoPoint.longitude = self.currentLocation.coordinate.longitude;
    PFQuery *locQuery = [PFQuery queryWithClassName:@"Posts"];
    [locQuery whereKey:@"location" nearGeoPoint:currentGeoPoint withinKilometers:20];
    
    [locQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d scores.", objects.count);
            // Do something with the found objects
            NSString *postsLblInfo = [[NSString alloc]init];
            for (PFObject *object in objects) {
                
                NSDictionary *userDict = [object valueForKey:@"estimatedData"];
                
                postsLblInfo = [NSString stringWithFormat:@"%@\n%@", postsLblInfo, [userDict valueForKey:@"text"]];
                NSLog(@"%@", [userDict valueForKey:@"location"]);
            }
            self.lblInfo.text = [NSString stringWithFormat:@"%@", postsLblInfo];
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
        
    }];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
