//
//  UIViewController+RotationHandler.m
//  Start-App
//
//  Created by Jörg Polakowski on 24/03/13.
//  Copyright (c) 2013 mCRUMBS GmbH. All rights reserved.
//

#import "UIViewController+RotationHandler.h"
#import "AppEnvironment.h"

@implementation UIViewController (RotationHandler)

- (void)updateContentAccordingToCurrentInterfaceOrientation:(UIImageView *)header
                                                 tabBarCtrl:(UITabBarController *)ctrl {

    UIImage *tabBarBackgroundImage = nil;
    UIImage *tabBarSelectionIndicatorImage = nil;
    UIImage *headerImageViewBackgroundImage = nil;

    UIEdgeInsets imgInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    UIInterfaceOrientation current = [[UIApplication sharedApplication] statusBarOrientation];

    if (UIInterfaceOrientationIsPortrait(current)) { // current layout is "Portrait"
        tabBarBackgroundImage = [UIImage imageNamed:@"tab-bar_hg"];
        tabBarSelectionIndicatorImage = [[UIImage imageNamed:@"tab-bar_active.png"] resizableImageWithCapInsets:imgInsets];
        headerImageViewBackgroundImage = [[UIImage imageNamed:@"header.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 200, 0, 300)];
    }
    else if (UIInterfaceOrientationIsLandscape(current)) { // current layout is "Landscape"
        NSString *tabBarImageName = @"tab-bar_hg_wide";
        NSString *headerImageName = @"header_wide";
        if (IS_IPHONE_5) {
            tabBarImageName = [NSString stringWithFormat:@"%@-568h", tabBarImageName];
            headerImageName = [NSString stringWithFormat:@"%@-568h", headerImageName];
        }
        tabBarBackgroundImage = [UIImage imageNamed:tabBarImageName];
        tabBarSelectionIndicatorImage = [[UIImage imageNamed:@"tab-bar_active_wide.png"] resizableImageWithCapInsets:imgInsets];
        headerImageViewBackgroundImage = [[UIImage imageNamed:headerImageName] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 200, 0, 300)];
    }

    dispatch_async(dispatch_get_main_queue(), ^{
        [ctrl.tabBar setBackgroundImage:tabBarBackgroundImage];
        [ctrl.tabBar setSelectionIndicatorImage:tabBarSelectionIndicatorImage];
        [header setImage:headerImageViewBackgroundImage];
    });
}

@end
