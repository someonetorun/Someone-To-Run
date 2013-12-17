//
//  AppDelegate.m
//  LogInAndSignUpDemo
//
//  Created by Mattieu Gamache-Asselin on 6/14/12.
//

#import "AppDelegate.h"
#import "DemoTableViewController.h"
#import "STRPostsTable.h"
#import "STRUserDetailsVC.h"
#import "STRConstants.h"
#import "STRInboxVC.h"

#define IS_WIDESCREEN ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

@implementation AppDelegate {
NSMutableArray *_addedItems;
NSMutableArray *_menuItems;
}

+ (NSInteger)OSVersion
{
    static NSUInteger _deviceSystemMajorVersion = -1;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _deviceSystemMajorVersion = [[[[[UIDevice currentDevice] systemVersion] componentsSeparatedByString:@"."] objectAtIndex:0] intValue];
    });
    return _deviceSystemMajorVersion;
}


#pragma mark - UIApplicationDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    
    _addedItems = [NSMutableArray array];
    _menuItems = [NSMutableArray array];
    
    
    
    
    // Home "item" menu
    //
    RESideMenuItem *homeItem = [[RESideMenuItem alloc] initWithTitle:KeyMenuHome action:^(RESideMenu *menu, RESideMenuItem *item) {
        STRPostsTable *postTable = [[STRPostsTable alloc] init];
        postTable.title = item.title;
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:postTable];
        [menu displayContentController:navigationController];
    }];
    
    //create My Posts "item" menu
    RESideMenuItem *exploreItem =
    [[RESideMenuItem alloc] initWithTitle:KeyMenuUserDetails action:^(RESideMenu *menu, RESideMenuItem *item) {
        STRUserDetailsVC *userDetails = [[STRUserDetailsVC alloc] init];
        userDetails.title = item.title;
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:userDetails];
        [menu displayContentController:navigationController];
    }];
    
    //create inbox "item" menu
    RESideMenuItem *inboxItem = [[RESideMenuItem alloc] initWithTitle:KeymenuMessegesBox action:^(RESideMenu *menu, RESideMenuItem *item) {
        STRInboxVC *userDetails = [[STRInboxVC alloc] init];
        userDetails.title = item.title;
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:userDetails];
        [menu displayContentController:navigationController];
    }];

    //Other catagories
    
    RESideMenuItem *activityRunning=[[RESideMenuItem alloc]initWithTitle:KeyMenuRunning action:^(RESideMenu *menu, RESideMenuItem *item) {
        [menu show];
    }];
    RESideMenuItem *activitySwimming=[[RESideMenuItem alloc]initWithTitle:KeyMenuSwimming action:^(RESideMenu *menu, RESideMenuItem *item) {
        [menu show];
    }];
    RESideMenuItem *activityGim=[[RESideMenuItem alloc]initWithTitle:KeyMenuGim action:^(RESideMenu *menu, RESideMenuItem *item) {
        [menu show];
    }];
    RESideMenuItem *activityWalking=[[RESideMenuItem alloc]initWithTitle:KeyMenuWalking action:^(RESideMenu *menu, RESideMenuItem *item) {
        [menu show];
    }];
    RESideMenuItem *activityTennis=[[RESideMenuItem alloc]initWithTitle:KeyMenuTennis action:^(RESideMenu *menu, RESideMenuItem *item) {
        [menu show];
    }];
    RESideMenuItem *activityGroups=[[RESideMenuItem alloc]initWithTitle:KeyMenuGroups action:^(RESideMenu *menu, RESideMenuItem *item) {
        [menu show];
    }];
    RESideMenuItem *activityOther=[[RESideMenuItem alloc]initWithTitle:KeyMenuOther action:^(RESideMenu *menu, RESideMenuItem *item) {
        [menu show];
    }];
    
    //Administration
    RESideMenuItem *activityAboutUs=[[RESideMenuItem alloc]initWithTitle:KeyMenuAboutUs action:^(RESideMenu *menu, RESideMenuItem *item) {
        [menu show];
    }];
    RESideMenuItem *underLine=[[RESideMenuItem alloc]initWithTitle:@"_________" action:^(RESideMenu *menu, RESideMenuItem *item) {
        [menu show];
    }];
    
    
//    RESideMenuItem *helpPlus1 = [[RESideMenuItem alloc] initWithTitle:@"How to use" action:^(RESideMenu *menu, RESideMenuItem *item) {
//        NSLog(@"Item %@", item);
//        [menu hide];
//    }];
//    
//    RESideMenuItem *helpPlus2 = [[RESideMenuItem alloc] initWithTitle:@"Helpdesk" action:^(RESideMenu *menu, RESideMenuItem *item) {
//        NSLog(@"Item %@", item);
//        [menu hide];
//    }];
//    
//    RESideMenuItem *helpCenterItem = [[RESideMenuItem alloc] initWithTitle:@"Help +" action:^(RESideMenu *menu, RESideMenuItem *item) {
//        NSLog(@"Item %@", item);
//    }];
//    helpCenterItem.subItems  = @[helpPlus1,helpPlus2];
    
    // Dynamic addable menus
    //
    RESideMenuItem *tagFieldItem = [[RESideMenuItem alloc] initFieldWithPlaceholder:@"+ Add tag" doneAction:^(RESideMenu *menu, RESideMenuItem *item) {
        __block RESideMenuItem *newTagItem = [[RESideMenuItem alloc] initWithTitle:menu.lastFieldInput image:[UIImage imageNamed:@"minus"] highlightedImage:nil imageAction:^(RESideMenu *menu, RESideMenuItem *item) {
            NSMutableArray * items = menu.items.mutableCopy;
            [items removeObject:newTagItem];
            [_addedItems removeObject:newTagItem];
            [menu reloadWithItems:items push:NO];
        } action:^(RESideMenu *menu, RESideMenuItem *item) {
            NSLog(@"Item %@", item);
            [menu hide];
        }];
        
        NSMutableArray * items = menu.items.mutableCopy;
        [items insertObject:newTagItem atIndex:2];
        [_addedItems addObject:newTagItem];
        [menu reloadWithItems:items push:NO];
    }];
    
    RESideMenuItem *tagMakerItem = [[RESideMenuItem alloc] initWithTitle:@"Tags +" action:^(RESideMenu *menu, RESideMenuItem *item) {
        NSLog(@"Item %@", item);
    }];
    
    NSMutableArray *otherItems = _addedItems;
    [otherItems insertObject:tagFieldItem atIndex:0];
    tagMakerItem.subItems = otherItems;
    
    // Simple menu with an alert
    //
    RESideMenuItem *logOutItem = [[RESideMenuItem alloc] initWithTitle:KeyMenuLogOut action:^(RESideMenu *menu, RESideMenuItem *item) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Confirmation" message:@"Are you sure you want to log out?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Log Out", nil];

        [alertView show];
       
        
       
        
    }];
    
    
    
    _sideMenu = [[RESideMenu alloc] initWithItems:@[homeItem,
                                                    inboxItem,
                                                    exploreItem,
                                                    underLine,
                                                    activityRunning,
                                                    activitySwimming,
                                                    activityGim,
                                                    activityWalking,
                                                    activityTennis,
                                                    activityGroups,
                                                    activityOther,
                                                    underLine,
                                                    activityAboutUs,
                                                    logOutItem]];
    
    _sideMenu.verticalPortraitOffset = IS_WIDESCREEN ? 80 : 60;
    _sideMenu.verticalLandscapeOffset = 16;
    
    _sideMenu.hideStatusBarArea = [AppDelegate OSVersion] < 7;
    
    _sideMenu.openStatusBarStyle = UIStatusBarStyleBlackTranslucent;
    
    // Call the home action rather than duplicating the initialisation
    homeItem.action(_sideMenu, homeItem);
    
    self.window.rootViewController = _sideMenu;
    


    
    // ****************************************************************************
    // Fill in with your Parse and Twitter credentials. Don't forget to add your
    // Facebook id in Info.plist:
    // ****************************************************************************
    [Parse setApplicationId:@"pMWE4MjjrFJ6tCRG9ZQZpP82bqZ6SdHYJNKr5k4S"
                  clientKey:@"D6pfFfC75FYdkFpTpHRrLSGlnFDj2avUZS38hBTa"];
//    [PFFacebookUtils initializeFacebook];
//    [PFTwitterUtils initializeWithConsumerKey:@"your_twitter_consumer_key" consumerSecret:@"your_twitter_consumer_secret"];
    
    // Set default ACLs
    PFACL *defaultACL = [PFACL ACL];
    [defaultACL setPublicReadAccess:YES];
    [PFACL setDefaultACL:defaultACL withAccessForCurrentUser:YES];
   
    PFLogInViewController *logInVC=[[PFLogInViewController alloc]initWithNibName:nil bundle:nil];
    self.welcomView=[[UINavigationController alloc]initWithRootViewController:logInVC];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)alertView:(UIAlertView*)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    // the user clicked OK
    if (buttonIndex == 1)
    {
        NSLog(@"log out");
        [self logOutButtonTapAction];
    }
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
    [self.sideMenu hide];
    // Present the log in view controller
    [self.window.rootViewController presentViewController:logInViewController animated:YES completion:NULL];

    
     //[self.navigationController popViewControllerAnimated:YES];
}
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
    [self.window.rootViewController dismissViewControllerAnimated:YES completion:NULL];
}

// Sent to the delegate when the log in attempt fails.
- (void)logInViewController:(PFLogInViewController *)logInController didFailToLogInWithError:(NSError *)error {
    NSLog(@"Failed to log in...");
}

// Sent to the delegate when the log in screen is dismissed.
//- (void)logInViewControllerDidCancelLogIn:(PFLogInViewController *)logInController {
//    [self.navigationController popViewControllerAnimated:YES];
//}

//************************************ facebook ************************************

#pragma mark - Facebook functions

// Facebook oauth callback
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return [PFFacebookUtils handleOpenURL:url];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [PFFacebookUtils handleOpenURL:url];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Handle an interruption during the authorization flow, such as the user clicking the home button.
    [FBSession.activeSession handleDidBecomeActive];
}

@end
