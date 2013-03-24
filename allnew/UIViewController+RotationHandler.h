//
//  UIViewController+RotationHandler.h
//  Start-App
//
//  Created by Jörg Polakowski on 24/03/13.
//  Copyright (c) 2013 mCRUMBS GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (RotationHandler)

- (void)updateContentAccordingToCurrentInterfaceOrientation:(UIImageView *)header
                                                 tabBarCtrl:(UITabBarController *)ctrl;

@end
