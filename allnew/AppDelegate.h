//
//  AppDelegate.h
//  allnew
//
//  Created by Martin Adam on 11.03.13.
//  Copyright (c) 2013 mCRUMBS GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "ARViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

// Concrete implementation of UIApplicationDelegate window reference.
@property(strong, nonatomic) UIWindow *window;

@end

//***************************************************************************************
// Location Manager Protocol declaration
//***************************************************************************************
@interface AppDelegate (LocationManagerProtocol) <CLLocationManagerDelegate>

@end

//***************************************************************************************
// AR Protocol declaration
//***************************************************************************************
@interface AppDelegate (ARViewControllerUIProtocoll) <ARViewControllerUIDelegate>

@end
