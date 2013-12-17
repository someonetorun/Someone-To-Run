//
//  STRUserDetailsVC.m
//  Sporty
//
//  Created by נמרוד בר on 10/11/13.
//
//

#import "STRUserDetailsVC.h"
#import "STRMyPostsCell.h"
#import "RESideMenu.h"

@interface STRUserDetailsVC ()
@property (strong, nonatomic)NSMutableArray* myPostsArray;
@end

@implementation STRUserDetailsVC

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
    self.myPostsArray = [NSMutableArray array];
    PFUser *user = [PFUser currentUser];
    [self ExecuteGetPostsByUser];
    
    //set the user details in the labels
    //set the user name
    self.lblUserName.text=user.username;
    //set the user phone
    NSDictionary *serverData =[user valueForKey:KeyServerData];
    NSString *phone = [serverData valueForKey:KeyPhoneNumber];
    self.lblMyPhone.text = phone;
#pragma mark - sideBar
    
    //set the left navigation item
	self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Menu" style:UIBarButtonItemStyleBordered target:self action:@selector(showMenu)];
    //set the gesture to bring the side menu
    UIPanGestureRecognizer *gestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(swipeHandler:)];
    [self.view addGestureRecognizer:gestureRecognizer];
    
}

-(void)ExecuteGetPostsByUser
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
                
                [self.myPostsArray addObject:postDict];
                
                
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
        [self.MyPostsTableView reloadData];
        
    }];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - TableView Delegate
//Table view Delegate methods
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.myPostsArray.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellPost";
    STRMyPostsCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"STRMyPostsCell" owner:self options:nil][0];
    }
    if (self.myPostsArray.count != 0)
    {
        //if we git more then 0 posts we will send the post details to the cell class to handle it.
        [cell SetCurrentPostInCell:[self.myPostsArray objectAtIndex:indexPath.row]];
    }
    else
    {
        //No post return from quary
        NSLog(@"There are 0 posts found" );
    }
    
    return cell;
}


//Hight of the cell
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    //create the VC which will present the post
//    STRPostDetailsVC* postDetails = [[STRPostDetailsVC alloc]initWithNibName:nil bundle:nil];
    
    //set the post details for the presented VC
//    postDetails.currentPost = [self.posts objectAtIndex:indexPath.row];
    
    //push the post details VC
//    [self.navigationController pushViewController:postDetails animated:YES];
    
    //deselacte the row
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)showMenu
{
    self.sideMenu.backgroundImage = [UIImage imageNamed:@"back.png"];
    [self.sideMenu show];
}

- (void)swipeHandler:(UIPanGestureRecognizer *)sender
{
    [[self sideMenu] showFromPanGesture:sender];
}
    


@end
