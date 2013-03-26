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
#import "UAirship.h"
#import "UAPush.h"

//***************************************************************************************
// Private Interface declaration
//***************************************************************************************
@interface AppDelegate ()

@property(assign) BOOL launchURLisHandled;
@property(strong) CLLocationManager *locationManager;

- (void)handleLaunchURL:(NSURL *)url;

- (void)prepareAndShowMainInterface;

- (void)setupPushNotificationsWithOptions:(NSDictionary *)launchOptions application:(UIApplication *)application;

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

    // setup Urban Airship for Push Notifications
    [self setupPushNotificationsWithOptions:launchOptions application:application];

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

//    if (self.locationManager == nil) {
//        self.locationManager = [[CLLocationManager alloc] init];
//        self.locationManager.delegate = self;
//        self.locationManager.purpose = @"Damit wir Ihnen lokale Informationen geben können, möchten wir Sie orten.";
//        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
//        self.locationManager.distanceFilter = 500;
//    }
//    if ([CLLocationManager locationServicesEnabled]) {
//        [self.locationManager startUpdatingLocation];
//    }

    return YES;
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [UAirship land];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    if (url && self.launchURLisHandled == NO) {
        [self handleLaunchURL:url];
        return YES;
    }
    return NO;
}

#pragma mark - Push notifications

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    // Updates the device token and registers the token with UA.
    [[UAPush shared] registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"APNS: %@", [error description]);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {

    // todo the app received a  push notification, now what?
    // todo how should the notification be displayed?


//    if (![AppEnvironment authToken]) {
//        return;
//    }
//    if ([userInfo objectForKey:@"type"]) {
//        NSInteger type = [[userInfo objectForKey:@"type"] intValue];
//        if (type == PNS_SUBJECT_TYPE_QUESTION) {
//            [self.rootViewController showRequestForId:[userInfo objectForKey:@"remote_id"]];
//        } else if (type == PNS_SUBJECT_TYPE_APPOINTMENT) {
//            [self.rootViewController showAppointmentForId:[userInfo objectForKey:@"remote_id"]];
//        }
//    }
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

    [tabBarItem1 setFinishedSelectedImage:[UIImage imageNamed:@"news_aktiv"] withFinishedUnselectedImage:[UIImage imageNamed:@"news"]];
    [tabBarItem2 setFinishedSelectedImage:[UIImage imageNamed:@"stories_aktiv"] withFinishedUnselectedImage:[UIImage imageNamed:@"stories"]];
    [tabBarItem3 setFinishedSelectedImage:[UIImage imageNamed:@"start_up_aktiv"] withFinishedUnselectedImage:[UIImage imageNamed:@"start_up"]];
    [tabBarItem4 setFinishedSelectedImage:[UIImage imageNamed:@"mehr_aktiv"] withFinishedUnselectedImage:[UIImage imageNamed:@"mehr"]];

    [[UITabBar appearance] setBackgroundImage:[UIImage imageNamed:@"tab-bar_hg"]];
    [[UITabBar appearance] setSelectionIndicatorImage:[UIImage imageNamed:@"tab-bar_active"]];

    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
            [UIColor colorWithRed:0 / 255.0 green:0 / 255.0 blue:0 / 255.0 alpha:1.0], UITextAttributeTextColor, [NSValue valueWithUIOffset:UIOffsetMake(0, 0)], UITextAttributeTextShadowOffset,
            [UIFont fontWithName:@"Arial-BoldMT" size:13.0], UITextAttributeFont, nil] forState:UIControlStateNormal];
    UIColor *titleHighlightedColor = [UIColor colorWithRed:189 / 255.0 green:209 / 255.0 blue:222 / 255.0 alpha:1.0];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
            titleHighlightedColor, UITextAttributeTextColor, nil] forState:UIControlStateSelected];
}

#pragma mark - Push notifications

- (void)setupPushNotificationsWithOptions:(NSDictionary *)launchOptions application:(UIApplication *)application {
    //Create Airship options dictionary and add the required UIApplication launchOptions
    NSMutableDictionary *takeOffOptions = [NSMutableDictionary dictionary];
    [takeOffOptions setValue:launchOptions forKey:UAirshipTakeOffOptionsLaunchOptionsKey];

    // Call takeOff (which creates the UAirship singleton), passing in the launch options so the
    // library can properly record when the app is launched from a push notification. This call is
    // required.
    //
    // Populate AirshipConfig.plist with your app's info from https://go.urbanairship.com
    [UAirship takeOff:takeOffOptions];

    // Set the icon badge to zero on startup (optional)
    [[UAPush shared] enableAutobadge:YES];
    [[UAPush shared] resetBadge];

    // Register for remote notfications with the UA Library. This call is required.
    [[UAPush shared] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                         UIRemoteNotificationTypeSound |
                                                         UIRemoteNotificationTypeAlert)];

    // Handle any incoming incoming push notifications.
    // This will invoke `handleBackgroundNotification` on your UAPushNotificationDelegate.
    [[UAPush shared] handleNotification:[launchOptions valueForKey:UIApplicationLaunchOptionsRemoteNotificationKey]
                       applicationState:application.applicationState];
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
    self.launchURLisHandled = NO; // need to reset the flag here for consecutive calls, where the app is coming from background
    [self prepareAndShowMainInterface];
}

@end
