//
//  AppDelegate.m
//  allnew
//
//  Created by Martin Adam on 11.03.13.
//  Copyright (c) 2013 mCRUMBS GmbH. All rights reserved.
//

#import "AppDelegate.h"
#import "ChanID.h"
#import "SplashScreenViewController.h"

//***************************************************************************************
// Private Interface declaration
//***************************************************************************************
@interface AppDelegate ()

@property(assign) BOOL launchURLisHandled;
@property(strong) CLLocationManager *locationManager;

- (void)handleLaunchURL:(NSURL *)url;

- (void)prepareAndShowMainInterface;

@end

@implementation AppDelegate

#pragma mark -
#pragma mark initialization

- (id)init {
    self = [super init];
    if (self) {
        self.launchURLisHandled = NO;
    }
    return self;
}

#pragma mark -
#pragma mark app lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
     (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];

    self.launchURLisHandled = YES;

    SplashScreenViewController *splash = [[SplashScreenViewController alloc] initWithCallbackBlock:^{

        [self.window.rootViewController removeFromParentViewController]; // remove splash view controller

        if (launchOptions && [launchOptions objectForKey:UIApplicationLaunchOptionsURLKey]) {
            // when opened with an start URL, we want to show the ARViewController
            NSURL *url = (NSURL *) [launchOptions objectForKey:UIApplicationLaunchOptionsURLKey];
            [self handleLaunchURL:url];
        }
        else {
            // if no url is present, then present default UI
            [self prepareAndShowMainInterface];
        }
    }];
    [self.window setRootViewController:splash];
    [self.window makeKeyAndVisible];

    if (self.locationManager == nil) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        self.locationManager.purpose = @"Damit wir Ihnen lokale Informationen geben können, möchten wir Sie orten.";
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        self.locationManager.distanceFilter = 500;
    }
    if ([CLLocationManager locationServicesEnabled]) {
        [self.locationManager startUpdatingLocation];
    }
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    if (url && self.launchURLisHandled == NO) {
        [self handleLaunchURL:url];
        return YES;
    }
    return NO;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSLog(@"My token is: %@", deviceToken);
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"Failed to get token, error: %@", error);
}

#pragma mark -
#pragma mark private methods

- (void)handleLaunchURL:(NSURL *)url {
    self.launchURLisHandled = YES;

    NSString *text = [[url host] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    ChanID *user = [ChanID sharedUser];
    if ([text isEqualToString:@"channel1"]) {
        user.cusurl = text;
        user.starter = @"1";

        // create proxy view controller and add it to the window
        UIViewController *blender = [[UIViewController alloc] init];
        blender.view.frame = self.window.frame;
        [self.window setRootViewController:blender];
        // prepare main window
        [self.window makeKeyAndVisible];
        // show AR controller
        ARViewController *junaioPlugin = [[ARViewController alloc] init];
        junaioPlugin.delegate = self; // we want to be notified when the ARViewController is closed !!
        [blender presentViewController:junaioPlugin animated:YES completion:nil];

        // reset
        user.starter = @"0";
    }
    else if ([text isEqualToString:@"channel2"]) {
        user.cusurl = text;
    }
}

- (void)prepareAndShowMainInterface {

    // load main interface from storyboard
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
    UITabBarController *tabBarController = (UITabBarController *) [storyboard instantiateViewControllerWithIdentifier:@"mainTabBarController"];

    // set main view controller as root and prepare window
    [self.window setRootViewController:tabBarController];
    [self.window makeKeyAndVisible];

    UITabBar *tabBar = tabBarController.tabBar;
    UITabBarItem *tabBarItem1 = [tabBar.items objectAtIndex:0];
    UITabBarItem *tabBarItem2 = [tabBar.items objectAtIndex:1];
    UITabBarItem *tabBarItem3 = [tabBar.items objectAtIndex:2];
    UITabBarItem *tabBarItem4 = [tabBar.items objectAtIndex:3];

    tabBarItem1.title = @"news";
    tabBarItem2.title = @"stories";
    tabBarItem3.title = @"start-up";
    tabBarItem4.title = @"mehr";

    [tabBarItem1 setFinishedSelectedImage:[UIImage imageNamed:@"news_aktiv.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"news.png"]];
    [tabBarItem2 setFinishedSelectedImage:[UIImage imageNamed:@"stories_aktiv.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"stories.png"]];
    [tabBarItem3 setFinishedSelectedImage:[UIImage imageNamed:@"start_up_aktiv.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"start_up.png"]];
    [tabBarItem4 setFinishedSelectedImage:[UIImage imageNamed:@"mehr_aktiv.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"mehr.png"]];

    [[UITabBar appearance] setBackgroundImage:[[UIImage imageNamed:@"tab-bar_hg"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)]];
    [[UITabBar appearance] setSelectionIndicatorImage:[[UIImage imageNamed:@"tab-bar_active"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)]];

    [[UITabBarItem appearance]                                           setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
            [UIColor colorWithRed:0 / 255.0 green:0 / 255.0 blue:0 / 255.0 alpha:1.0], UITextAttributeTextColor, [NSValue valueWithUIOffset:UIOffsetMake(0, 0)], UITextAttributeTextShadowOffset,
            [UIFont fontWithName:@"Arial-BoldMT" size:13.0], UITextAttributeFont, nil] forState:UIControlStateNormal];
    UIColor *titleHighlightedColor = [UIColor colorWithRed:189 / 255.0 green:209 / 255.0 blue:222 / 255.0 alpha:1.0];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
            titleHighlightedColor, UITextAttributeTextColor,
            nil]                             forState:UIControlStateSelected];
}

@end


//***************************************************************************************
// Location Manager Protocol implementation
//***************************************************************************************
@implementation AppDelegate (LocationManagerProtocol)

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation {

    if (newLocation != nil) {
        ChanID *user = [ChanID sharedUser];
        user.lon = [NSString stringWithFormat:@"%.8f", newLocation.coordinate.longitude];
        user.lat = [NSString stringWithFormat:@"%.8f", newLocation.coordinate.latitude];
        [self.locationManager stopUpdatingLocation];
    }
}

@end

//***************************************************************************************
// AR Protocol implementation
//***************************************************************************************
@implementation AppDelegate (ARViewControllerUIProtocoll)

- (void)closeButtonPushed {
    [self prepareAndShowMainInterface];
}

@end
