//
//  STRPostDetailsVC.m
//  Sporty
//
//  Created by נמרוד בר on 31/10/13.
//
//

#import "STRPostDetailsVC.h"

@interface STRPostDetailsVC () <MKMapViewDelegate>

@property (strong,nonatomic)PFUser* postUser;

@end



@implementation STRPostDetailsVC



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
    [self setCurrentPostLabels];
    
    // Create thread to run in the background query for getting post user
    NSThread *thread=[[NSThread alloc]initWithTarget:self selector:@selector(getUserDetails) object:nil];
    [thread start];
    
    //set this calss to be the map delegate
    self.mapView.delegate=self;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Run this function only in thread
-(void)getUserDetails
{
    
    //Because user is complicated object inside the currentPost, we use double getting
    PFObject* userObj = [self.currentPost valueForKey:KeyClassUser];
    NSString *userId = [userObj valueForKey:KeyObjectId];
    
    //postUser is Global variable of PFUser
    self.postUser = [PFQuery getUserObjectWithId:userId];
    
    // Put the data to the labels only after the thread is done (we are inside thread)
    [self setCurrentUserDetails];
    
    
    
}

-(void) setCurrentPostLabels
{
    //set the user name labal
    self.lblUserName.text = [self.currentPost valueForKey:KeyUserName];
    //get the create date of the post
    NSString* date = [[AppData sharedInstance] dateOrgenizer:[self.currentPost valueForKey:KeyCreatedAt]];
    //set the post creation date labal
    self.lblCreatedAt.text = date;
    //get the activity timr
    NSString* time = [[AppData sharedInstance] dateOrgenizer:[self.currentPost valueForKey:KeyActivityTime]];
    //set the activity time label
    self.lblActivityTime.text = time;
    //set the activity type label
    self.lblActivityType.text  =[self.currentPost valueForKey:KeyActivityType];
    //set avtivity dexcreption
    self.lblActivityDesc.text = [self.currentPost valueForKey:KeyActivityDesc];
    //get the PFGeoPoint of the activity
    PFGeoPoint *pfgeoPointLocation =[self.currentPost valueForKey:KeyActivityLocation];
    //create location based on geo point from latitude and longitude
    CLLocation *activityLocation=[[CLLocation alloc]initWithLatitude:pfgeoPointLocation.latitude longitude:pfgeoPointLocation.longitude];
    
    //recantere map on the location
    [self recenterMap:activityLocation];
    
    //set a pin on the location
    [self createPinOnMapWithStreetDetails:activityLocation];
    
    
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

-(void) createPinOnMapWithStreetDetails: (CLLocation*)location
{
    //create a geo coder
    CLGeocoder *geocoder=[[CLGeocoder alloc]init];
    //get array of placemarks based on location
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error)
     {
         if(error ==nil)
         {
             if(placemarks.count>0)
             {
                 //get the first name from the list
                 CLPlacemark *placemark = [placemarks objectAtIndex:0];
                 
                 
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


// Set the details only after the thread is done.
-(void) setCurrentUserDetails
{
    NSDictionary *userServerData= [self.postUser valueForKey:KeyServerData];
    NSString *userPhone=[userServerData valueForKey:KeyPhoneNumber];
    
    self.lblUserPhoneNumber.text=userPhone;
}

- (IBAction)contactButonTapped:(UIButton *)sender
{
    //set the current user id as approving in parse
    
    //get current user
    PFUser *currentUser=[PFUser currentUser];
    
    //get the current user id
    NSString *currentUserId =[currentUser objectId];
    
    //get the object id from server data
    NSString *postId=[self.currentPost objectForKey:KeyObjectId];
    
    //create a query for post class
    PFQuery *query = [PFQuery queryWithClassName:KeyClassPosts];
    
    // Retrieve the post to be updated by id
    [query getObjectInBackgroundWithId:postId block:^(PFObject *post, NSError *error) {
        

        
        //set the current user id in the approved user id
        post[@"ApprovedByUserId"]=currentUserId;
        
        //////////we have a problem saving to ather pepole posts!!!!!!!//////////
        
        //save the changes
        [post saveInBackground];
        
    }];
    
    
    
}


@end
