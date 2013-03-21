//
//  AppDelegate.m
//  allnew
//
//  Created by Martin Adam on 11.03.13.
//  Copyright (c) 2013 mCRUMBS GmbH. All rights reserved.
//

#import "AppDelegate.h"
#import "ChanID.h"
#import "FirstViewController.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize locationManager=_locationManager;
@synthesize viewController=_viewController;

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation *currentLocation = newLocation;
    
    if (currentLocation != nil) {
        ChanID *user = [ChanID sharedUser];
        user.lon = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude];
        user.lat = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude];
        [_locationManager stopUpdatingLocation];
    }
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    [_window addSubview:_viewController.view];
    [_window makeKeyAndVisible];
    
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
     (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
    
    UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
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
    
    UIImage* tabBarBackground = [[UIImage imageNamed:@"tab-bar_hg.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [[UITabBar appearance] setBackgroundImage:tabBarBackground];
    [[UITabBar appearance] setSelectionIndicatorImage:[UIImage imageNamed:@"tab-bar_active.png"]];
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1.0], UITextAttributeTextColor, [NSValue valueWithUIOffset:UIOffsetMake(0,0)], UITextAttributeTextShadowOffset,
                                                       [UIFont fontWithName:@"Arial-BoldMT" size:13.0], UITextAttributeFont,                                                       nil] forState:UIControlStateNormal];
    UIColor *titleHighlightedColor = [UIColor colorWithRed:189/255.0 green:209/255.0 blue:222/255.0 alpha:1.0];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       titleHighlightedColor, UITextAttributeTextColor,
                                                       nil] forState:UIControlStateSelected];

    if(self.locationManager==nil){
        _locationManager=[[CLLocationManager alloc] init];
        //I'm using ARC with this project so no need to release
        
        _locationManager.delegate=self;
        _locationManager.purpose = @"Damit wir Ihnen lokale Informationen geben können, möchten wir Sie orten.";
        _locationManager.desiredAccuracy=kCLLocationAccuracyBest;
        _locationManager.distanceFilter=500;
        self.locationManager=_locationManager;
    }
    if([CLLocationManager locationServicesEnabled]){
        [self.locationManager startUpdatingLocation];
    }
    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    
    NSString *text = [[url host] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    if ([text isEqualToString:@"channel1"]) {
        ChanID *user = [ChanID sharedUser];
        user.cusurl = @"channel1";
    }
    if ([text isEqualToString:@"channel2"]) {
        ChanID *user = [ChanID sharedUser];
        user.cusurl = @"channel2";
    }
    return 0;
}

							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
	NSLog(@"My token is: %@", deviceToken);
}

- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
	NSLog(@"Failed to get token, error: %@", error);
}

@end
