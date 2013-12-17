//
//  STRPostsTable.m
//  SportyTest2
//
//  Created by נמרוד בר on 08/09/13.
//
//

#import "STRPostsTable.h"
#import "STRPostCell.h"
#import "STRAddNewPostVC.h"
#import "STRPostDetailsVC.h"
#import "STRPost.h"
#import "RESideMenu.h"


@interface STRPostsTable () <CLLocationManagerDelegate>
@property (strong, nonatomic) STRPostCell* cellPost;
@property (strong, nonatomic) CLLocationManager* locationManager;
@property (strong, nonatomic) CLLocation* currentLocation;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray* posts;
@property (strong, nonatomic) NSArray* sortedPosts;

@end

@implementation STRPostsTable

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
    [self GetPostsByLocation];
    UIBarButtonItem* addButton = [[UIBarButtonItem alloc]initWithTitle:@"Post" style:UIBarButtonItemStylePlain target:self action:@selector(newPostButtonTapped)];
    self.title = @"מישהו לרוץ איתו";
    self.navigationItem.rightBarButtonItem = addButton;
    
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    
    // Do any additional setup after loading the view from its nib.
    
    //Get the current location of the user to show the close-Locations Posts
    if (self.locationManager == nil) {
        self.locationManager = [[CLLocationManager alloc]init];
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest ;
    }
    [self.locationManager startUpdatingLocation];
    self.locationManager.delegate = self;
    
    self.currentLocation = self.locationManager.location;
    
    //init Posts Array
    self.posts = [NSMutableArray new];
    
#pragma mark - sideBar
    
	self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Menu" style:UIBarButtonItemStyleBordered target:self action:@selector(showMenu)];
    
    UIPanGestureRecognizer *gestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(swipeHandler:)];
    [self.view addGestureRecognizer:gestureRecognizer];

}


- (void)swipeHandler:(UIPanGestureRecognizer *)sender
{
    [[self sideMenu] showFromPanGesture:sender];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (![PFUser currentUser]) { // No user logged in
        // Create the log in view controller
        PFLogInViewController *logInViewController = [[PFLogInViewController alloc] init];
        [logInViewController setDelegate:self]; // Set ourselves as the delegate
        
        // Create the sign up view controller
        PFSignUpViewController *signUpViewController = [[PFSignUpViewController alloc] init];
        [signUpViewController setDelegate:self]; // Set ourselves as the delegate
        
        // Assign our sign up controller to be displayed from the login controller
        [logInViewController setSignUpController:signUpViewController];
        
        // Present the log in view controller
        [self presentViewController:logInViewController animated:YES completion:NULL];
    }
    
}


#pragma mark -
#pragma mark Button actions

- (void)showMenu
{
    self.sideMenu.backgroundImage = [UIImage imageNamed:@"back.png"];
     [self.sideMenu show];
}
 

-(void) GetPostsByLocation
{
    //Get the current loction of user
    PFGeoPoint *currentGeoPoint = [PFGeoPoint new];
    currentGeoPoint.latitude = self.currentLocation.coordinate.latitude;
    currentGeoPoint.longitude = self.currentLocation.coordinate.longitude;

    
    
    
    //Create quary on the class- Posts
    PFQuery *locQuery = [PFQuery queryWithClassName:KeyClassPosts];
    

    // Searching for post near the current location by key -"location"
    [locQuery whereKey:KeyActivityLocation nearGeoPoint:currentGeoPoint withinKilometers:RadiosForPostSearch];

#pragma mark - BLOCK
    
    //Create thread to run the quary in the back, get all the objects into objects array
    [locQuery findObjectsInBackgroundWithBlock:^(NSArray *postsArray, NSError *error) {
        if (!error) {
            // The search succeeded.
            NSLog(@"Successfully retrieved %d scores.", postsArray.count);
            
            // get each object from the array into post dictionary
            for (PFObject *postDetails in postsArray)
            {
                //using parse key-"estimateData" we convert the PFobject to readble dictionary.
                NSMutableDictionary *postDict = [postDetails valueForKey:KeyEstimatedData];
                
                //get the time of creation for the post
                NSDate *postCreatedAt = [postDetails valueForKey:KeyCreatedAt];
                
                
                //get the object id
                NSString *postObjectId = postDetails.objectId;
                
                //add the post object id to the the dict
                [postDict setObject:postObjectId forKey:KeyObjectId];
                
                //add the creation time of the post to the post
                [postDict setObject:postCreatedAt forKey:KeyCreatedAt];
                
                //Add the dictitionary object to posts array
                [self.posts addObject:postDict];
               
                
            }
            //Reload data when the block is finished
            [self sortArraybyPostDate];
            [self.tableView reloadData];

        }
        else
        {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
        
    }
     
     ];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)sortArraybyPostDate
{
    //Making a temp array for sorting
    self.sortedPosts = [NSArray array];
    
    //sorting by date
    self.sortedPosts = [self.posts sortedArrayUsingComparator:^NSComparisonResult(NSDictionary *dict2, NSDictionary *dict1) {
        return [[dict1 objectForKey:KeyCreatedAt] compare:[dict2 objectForKey:KeyCreatedAt]];
    }];
    
    //convert to mutable array for placing back in original array
    self.posts = (NSMutableArray*) self.sortedPosts;
    
}


//Table view Delegate methods
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.posts.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellPost";
    STRPostCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"STRPostCell" owner:self options:nil][0];
    }
    if (self.posts.count != 0)
    {
        //if we git more then 0 posts we will send the post details to the cell class to handle it.
        [cell SetCurrentPostInCell:[self.posts objectAtIndex:indexPath.row]];
    }
    else
    {
        //No post return from quary
        NSLog(@"There are 0 posts found" );
    }
    
    return cell;
}



- (void)newPostButtonTapped
{
    //cal the new ad edit VC
    STRAddNewPostVC *newPostVC = [[STRAddNewPostVC alloc]initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:newPostVC animated:YES];
}
- (void)viewDidUnload {
    [self setTableView:nil];
    [super viewDidUnload];
    
}
//Hight of the cell
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    //create the VC which will present the post
    STRPostDetailsVC* postDetails = [[STRPostDetailsVC alloc]initWithNibName:nil bundle:nil];
    
    //set the post details for the presented VC
    postDetails.currentPost = [self.posts objectAtIndex:indexPath.row];

    //push the post details VC
    [self.navigationController pushViewController:postDetails animated:YES];

    //deselacte the row
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



-(void)logOutButtonTapAction{
[PFUser logOut];
// Create the log in view controller
PFLogInViewController *logInViewController = [[PFLogInViewController alloc] init];
[logInViewController setDelegate:self]; // Set ourselves as the delegate

// Create the sign up view controller
PFSignUpViewController *signUpViewController = [[PFSignUpViewController alloc] init];
[signUpViewController setDelegate:self]; // Set ourselves as the delegate

// Assign our sign up controller to be displayed from the login controller
[logInViewController setSignUpController:signUpViewController];

    //     Present the log in view controller
    [self presentViewController:logInViewController animated:YES completion:NULL];
    

}

#pragma mark - Login class
//************************************ log in classes ************************************

#pragma mark - PFLogInViewControllerDelegate

// Sent to the delegate to determine whether the log in request should be submitted to the server.
- (BOOL)logInViewController:(PFLogInViewController *)logInController shouldBeginLogInWithUsername:(NSString *)username password:(NSString *)password {
    // Check if both fields are completed
    if (username && password && username.length && password.length) {
        return YES; // Begin login process
    }
    
    [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Missing Information", nil) message:NSLocalizedString(@"Make sure you fill out all of the information!", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil] show];
    return NO; // Interrupt login process
}

// Sent to the delegate when a PFUser is logged in.
- (void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

// Sent to the delegate when the log in attempt fails.
- (void)logInViewController:(PFLogInViewController *)logInController didFailToLogInWithError:(NSError *)error {
    NSLog(@"Failed to log in...");
}

// Sent to the delegate when the log in screen is dismissed.
- (void)logInViewControllerDidCancelLogIn:(PFLogInViewController *)logInController {
    [self.navigationController popViewControllerAnimated:YES];
}


@end
