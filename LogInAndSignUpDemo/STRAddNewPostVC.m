//
//  STRAddNewPostVC.m
//  SportyTest2
//
//  Created by נמרוד בר on 08/09/13.
//
//

#import "STRAddNewPostVC.h"

@interface STRAddNewPostVC () <CLLocationManagerDelegate, MKMapViewDelegate>

@property (strong,nonatomic) CLLocationManager *loctionManger;
@property (strong,nonatomic) CLGeocoder *geocoder;
@property (strong,nonatomic) CLLocation *currentLocation;

@end

@implementation STRAddNewPostVC

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
    self.datePicker.minimumDate = [NSDate date];
    
    //navigation controller bar - "send" button
    //UIBarButtonItem *sendButton =
    //sendButton.title = @"send";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(addPostButtonTapped)];
    
    
    
    //////map part//////
    
    // if no location manger created- create one
    if(self.loctionManger==nil)
    {
        //init LM
        self.loctionManger= [[CLLocationManager alloc]init];
        //set accuracy of wanted tracking
        self.loctionManger.desiredAccuracy=kCLLocationAccuracyBest;
        
    }
    //start getting updates
    [self.loctionManger startUpdatingLocation];
    //updates on location will get to me
    self.mapView.delegate=self;
    self.loctionManger.delegate=self;
    
    
    //hide date picker
    self.datePicker.hidden=YES;
    //hide set date button
    self.btnSetDate.hidden=YES;
    
    
    //create date format
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //for time
    [formatter setDateFormat:@"hh:mm"];
    //for date
    [formatter setDateFormat:@"MMM dd, YYYY"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    
    //get the date today in that format
    NSString *dateToday = [formatter stringFromDate:[NSDate date]];
    
    //set the current date to activity label
    self.lblActivityDate.text=dateToday;
    
    /////map part////

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addPostButtonTapped
{
    
    //collect data from fields and GPS
    
    //Create current Post Object
     STRPost *currentPost = [self collectAdData];
    
    
   
    //Create thread for the saveing action to run on background
    NSThread *savePostThread=[[NSThread alloc]initWithTarget:self selector:@selector(savePostToDB:) object:currentPost];
    [savePostThread start];
    

    
    //save it to current user ad list
    
    
    
    
    
    //Back to list VC
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)txtEditingDone:(UITextField *)sender {
    [self resignFirstResponder];
}

- (IBAction)changeDateTapped:(UIButton *)sender
{
    //show date picker
    self.datePicker.hidden=NO;
    
    //show set date button
    self.btnSetDate.hidden=NO;
    
    //hide change date button
    self.btnChangeDate.hidden=YES;
    
    
    
    
    
}

- (IBAction)setDateTapped:(UIButton *)sender
{
    //set current time from date picker in current activity time
    self.currentActivityTime=self.datePicker.date;
    
    
    //hide date picker
    self.datePicker.hidden=YES;
    
    //hide set date button
    self.btnSetDate.hidden=YES;
    
    //show change date button
    self.btnChangeDate.hidden=NO;
    
    //create date format
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //for time
    [formatter setDateFormat:@"hh:mm"];
    //for date
    [formatter setDateFormat:@"MMM dd, YYYY"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    //get the date in that format
    NSString *dateToday = [formatter stringFromDate:self.datePicker.date];
    
    //set the current date to activity label
    self.lblActivityDate.text=dateToday;
    
}


- (void)viewDidUnload {
    [self setLblSportDescr:nil];
    [self setLblSportLoc:nil];
    [self setDatePicker:nil];
    [self setMapView:nil];
    [super viewDidUnload];
}
#pragma mark - (Ad parts)

-(void) savePostToDB:(STRPost*)currentPost
{
    
    //Create PFobject from STRPost Properties
    PFObject* post = [[PFObject alloc]initWithClassName:KeyClassPosts];
    
    //set the description of the post
    [post setObject:[NSString stringWithFormat:@"%@", currentPost.activityDesc] forKey: KeyActivityDesc];
    
    //set the user to the PFobject
    [post setObject:currentPost.user forKey:KeyClassUser];
    
    //set the username to the post
    [post setObject:currentPost.user.username forKey:KeyUserName];
    
    //set the location of the activity
    [post setObject:currentPost.activityPoint forKey:KeyActivityLocation];
    
    
    //set the activity Type
    [post setObject:currentPost.activityType forKey:KeyActivityType];
    
    
    
    //set the workout Level
    [post setObject:currentPost.workoutLevel forKey:KeyWorkoutLevel];
    
    
    //if activityTime is not nil  we will set activityTime key
    if(self.currentActivityTime!=nil)
    {
        //set the time of the activity
        [post setObject:currentPost.activityTime forKey:KeyActivityTime];

    }
    
    

    //Commit to DB
    [post save];

}

-(NSString*) activityTypeEnamToString: (NSInteger) enumType
{
     NSString *string ;
    
    if(enumType==running)
    {
        string= @"running";
    }
    else if(enumType==swimming)
    {
        string= @"swimming";
    }
    else if(enumType==walking)
    {
       string= @"walking";
    }
    else if(enumType==gim)
    {
        string= @"gim";
    }
    else if(enumType==tennis)
    {
       string= @"tennis";
    }
    else if(enumType==basketball)
    {
        string= @"basketball";
    }
    else if(enumType==soccer)
    {
        string= @"soccer";
    }
    else if(enumType==bicycle)
    {
       string= @"bicycle";
    }
    else if(enumType==spiritual)
    {
       string= @"spiritual";
    }
    else if(enumType==other)
    {
        string=@"other";
    }
    

    return string;
}

-(NSString*) getActivityType
{
    
    //get the tag number from Activity segmant
    int enumType = self.segActivityType.selectedSegmentIndex;
    //convert to string
    NSString *activityType=[self activityTypeEnamToString:enumType];
    
    return activityType;
    
}

-(NSString*) workoutLevelEnamToString: (NSInteger) enumType
{
    NSString *string ;
    
    
    if(enumType==olympic)
    {
        string=@"olympic";
    }
    else if(enumType==athlete)
    {
        string=@"athlete";
    }
    else if(enumType==amature)
    {
        string=@"amature";
    }
    else if(enumType==lazyAss)
    {
        string=@"lazyAss";
    }

    
    
    return string;
    
}

-(NSString*) getWorkoutLevel
{
    
    //get the tag number from Workout Level segmant
    int enumWorkoutLevel = self.segWorkoutLevel.selectedSegmentIndex;
    //convert to string
    NSString *WorkoutLevel=[self workoutLevelEnamToString:enumWorkoutLevel];
    
    return WorkoutLevel;
    
}


-(STRPost*) collectAdData
{
    
    //Get the current User
    PFUser* currentUser = [PFUser currentUser];
    
    //create a post object
    STRPost *post=[[STRPost alloc]init];

    //set the post' user
    post.user = currentUser;
    
    //set description from the descrtiption field
    post.activityDesc = self.lblSportDescr.text;
    
    //get current location
    CLLocation *currentLocation = self.currentLocation;
    
    //Init the post activity point (PFGeoPoint)
    post.activityPoint = [PFGeoPoint new];
    
    //set user location for activity
    post.activityPoint.latitude=currentLocation.coordinate.latitude;
    post.activityPoint.longitude= currentLocation.coordinate.longitude;
    
    //set activity type
    post.activityType=[self getActivityType];
    //set workout level
    post.workoutLevel=[self getWorkoutLevel];
    
    // add the description to the post
    post.activityDesc=self.lblSportDescr.text;
    
    
    //No need to set create time, parse do it automaticly set the time of the creation

    
    // Create date from the elapsed time
//    NSDate *currentDate = [NSDate date];
//    NSDate *startDate = [NSDate date];
//    NSTimeInterval timeInterval = [currentDate timeIntervalSinceDate:startDate];
//    post.postTime=[NSDate dateWithTimeIntervalSince1970:timeInterval];
    

    
    //if user didn't set a specific time for activity
    if(self.currentActivityTime==nil)
    {
        //we will send nothing
      post.activityTime =nil;
    }
    else
    {
        //if he set time we will set the specifc time
        post.activityTime =self.currentActivityTime;
    }
    
  
    //verfay all data is correct

    
    
    return post;
}


#pragma mark - (Map parts)

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    //every time we get a new location (moved) we will move the map
    [self recenterMap:userLocation.location];
    
}

-(void) createPinOnMapWithStreetDetails: (CLLocation*)location
{

    
    if(!self.geocoder)
    {
        self.geocoder=[[CLGeocoder alloc]init];
        
        [self.geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error)
         {
             if(error ==nil)
             {
                 if(placemarks.count>0)
                 {
                     CLPlacemark *placemark = [placemarks objectAtIndex:0];
                     
                     //want to see what we have in placemark? anable this 2 lines
                     //                    NSDictionary *addressDictionary = placemark.addressDictionary;
                     //                    NSLog(@"%@ ", addressDictionary);
                     
                     
                     
                     
                     //create a pin
                     MapLocation *annotation = [[MapLocation alloc]init];
                     //take all details from placemark and put it on pin
                     annotation.street = placemark.name;
                     annotation.city = placemark.locality;
                     //since we are in israel we won't use "state"
                     //annotation.state = placemark.administrativeArea;
                     annotation.zip = placemark.postalCode;
                     annotation.coordinate = location.coordinate;
                     
                     
                     
                     
                     //add pin to map
                     [self.mapView addAnnotation:annotation];
                     
                     //set geocoder to nil for next task
                     self.geocoder=nil;
                     
                 }
                 
                 else
                 {
                     //if we dont get a placemark array we will show alert daialog
                     UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error translating coordinates" message:@"goecoder did not recognize coordinates" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                     
                     [alert show];
                     
                 }
             }
         }];
    }
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    //get the last location from array
    self.currentLocation = locations.lastObject;
    
    //recantere map on it
    [self recenterMap:self.currentLocation];
    
    //make an a pin on this location with the street details as subtitle
    [self createPinOnMapWithStreetDetails:self.currentLocation];
    
    
    
}

-(void) recenterMap: (CLLocation*) location
{
     
    //create a region around the location in size...
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, 500, 500);
    //fit this shape in map view
    MKCoordinateRegion adjustedRegion = [self.mapView regionThatFits:viewRegion];
    //set the map region to this new region
    [self.mapView setRegion:adjustedRegion animated:YES];
    
}


@end
