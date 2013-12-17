//
//  AppDelegate.h
//  LogInAndSignUpDemo
//
//  Created by Mattieu Gamache-Asselin on 6/14/12.
//
#import "RESideMenu.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate, UIAlertViewDelegate>

@property (nonatomic, strong) UIWindow *window;
@property (nonatomic, strong) UINavigationController *welcomView;
@property (strong, readonly, nonatomic) RESideMenu *sideMenu;

+ (NSInteger)OSVersion;

@end
