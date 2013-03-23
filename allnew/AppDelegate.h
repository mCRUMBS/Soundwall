//
//  AppDelegate.h
//  allnew
//
//  Created by Martin Adam on 11.03.13.
//  Copyright (c) 2013 mCRUMBS GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

// Broadcasted to signal the app, that the augmented reality channel 1 should be used.
NSString *const kAppShouldSwitchToChannel1 = @"APP_SHOULD_SWITCH_TO_CHANNEL_1";

@interface AppDelegate : UIResponder <UIApplicationDelegate>

// Concrete implementation of UIApplicationDelegate window reference.
@property(strong, nonatomic) UIWindow *window;

@end

//***************************************************************************************
// Location Manager Protocol declaration
//***************************************************************************************
@interface AppDelegate (LocationManagerProtocol) <CLLocationManagerDelegate>

@end
