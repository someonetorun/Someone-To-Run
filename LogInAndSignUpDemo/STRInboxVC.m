//
//  STRInboxVC.m
//  Sporty
//
//  Created by נמרוד בר on 18/11/13.
//
//

#import "STRInboxVC.h"
#import "STRInboxCell.h"
#import "RESideMenu.h"

@interface STRInboxVC ()
@property (strong, nonatomic) NSMutableArray *inboxArray;
@property (strong, nonatomic) NSMutableArray *userNameArray;
@property (strong, nonatomic) NSString* tempUserId;
@end

@implementation STRInboxVC

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
    self.inboxArray = [NSMutableArray array];
    self.userNameArray = [NSMutableArray array];
    [self ExecuteGetInboxData];
    
#pragma mark - sideBar
    
    //set the left navigation item
	self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Menu" style:UIBarButtonItemStyleBordered target:self action:@selector(showMenu)];
    //set the refrash bar item
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"refrash" style:UIBarButtonItemStyleBordered target:self action:@selector(refrashTable)];
    
    //set the gesture to bring the side menu
    UIPanGestureRecognizer *gestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(swipeHandler:)];
    [self.view addGestureRecognizer:gestureRecognizer];

}

-(void)refrashTable
{
     [self.myInboxTableView reloadData];
    NSLog(@"table refrashed");
}

- (void)swipeHandler:(UIPanGestureRecognizer *)sender
{
    [[self sideMenu] showFromPanGesture:sender];
}

- (void)showMenu
{
    self.sideMenu.backgroundImage = [UIImage imageNamed:@"back.png"];
    [self.sideMenu show];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"inboxCell";
    STRInboxCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"STRInboxCell" owner:self options:nil][0];
    }
    if (self.inboxArray.count != 0)
    {
        //if we git more then 0 posts we will send the post details to the cell class to handle it.
        [cell SetCurrentPostInCell:[self.inboxArray objectAtIndex:indexPath.row]];
    }
    else
    {
        //No post return from quary
        NSLog(@"There are 0 posts found" );
    }
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.inboxArray.count;
}

-(void)ExecuteGetInboxData
{
    NSString* objectID =  [PFUser currentUser].objectId;;
    NSThread* userPostsThread = [[NSThread alloc]initWithTarget:self selector:@selector(getPostsByUser:) object:objectID];
    [userPostsThread start];
}
-(void)getPostsByUser:(NSString*)objectID
{
    
    
    //create query on posts class
    PFQuery *query = [PFQuery queryWithClassName:KeyClassPosts];
    
    //look under the user key for the same key from current user
    [query whereKey:KeyClassUser equalTo:[PFUser currentUser]];
    
    //get the array of objects
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d scores.", objects.count);
            // Do something with the found object
            for (PFObject *object in objects) {
                
                NSDictionary *postDict = [object valueForKey:@"estimatedData"];
                
                [self.inboxArray addObject:postDict];
                
                
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
            NSLog(@"shit");
        }
        [self.myInboxTableView reloadData];
        
    }];
    
    
//    //create a query on posts class
//    PFQuery *inboxQ = [PFQuery queryWithClassName:@"Posts"];
//    
//    [inboxQ whereKey:KeyObjectId equalTo:objectID];
//    //NSString* empty = @"";
//    //[inboxQ whereKey:@"ApprovedByUserId" greaterThan:empty];
//    
//    [inboxQ findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error)
//    {
//        
//        if (!error)
//        {
//            // The find succeeded.
//            NSLog(@"Successfully retrieved %d scores.", posts.count);
//            // Do something with the found object
//            for (PFObject *post in posts)
//            {
//                
//                NSDictionary *postDict = [post valueForKey:@"estimatedData"];
//                self.tempUserId = [postDict valueForKey:@"ApprovedByUserId"];
////                PFQuery *userQuery = [PFQuery queryWithClassName:@"User"];
////                [userQuery getObjectInBackgroundWithId:self.tempUserId block:^(PFObject *user, NSError *error)
////                 {
////                     [self.userNameArray addObject:[user objectForKey:@"username"]];
////                 }];
//                
//                NSLog(@"adedd item to array");
//                [self.inboxArray addObject:postDict];
//                
//                
//            }
//            //refrash the table
//            [self.myInboxTableView reloadData];
//            
//        }
//        else
//        {
//            // Log details of the failure
//            NSLog(@"Error: %@ %@", error, [error userInfo]);
//        }
//       
//        
//        
//    }];
    
    
}

@end
