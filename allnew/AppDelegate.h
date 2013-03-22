//
//  AppDelegate.h
//  allnew
//
//  Created by Martin Adam on 11.03.13.
//  Copyright (c) 2013 mCRUMBS GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UIViewController *viewController;

@end

//***************************************************************************************
// Location Manager Protocol declaration
//***************************************************************************************
@interface AppDelegate (LocationManagerProtocol) <CLLocationManagerDelegate>

@end