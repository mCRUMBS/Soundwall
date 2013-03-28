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

- (void)updateHeaderAccordingToCurrentInterfaceOrientation:(UIImageView *)header baseName:(NSString *)base {
    UIInterfaceOrientation current = [[UIApplication sharedApplication] statusBarOrientation];

    UIImage *headerImageViewBackgroundImage = nil;
    if (UIInterfaceOrientationIsPortrait(current)) { // current layout is "Portrait"
        headerImageViewBackgroundImage = [[UIImage imageNamed:base] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 200, 0, 300)];
    }
    else if (UIInterfaceOrientationIsLandscape(current)) { // current layout is "Landscape"
        NSString *headerImageName = [NSString stringWithFormat:@"%@_wide", base];
        if (IS_IPHONE_5) {
            headerImageName = [NSString stringWithFormat:@"%@-568h", headerImageName];
        }
        headerImageViewBackgroundImage = [[UIImage imageNamed:headerImageName] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 200, 0, 300)];
    }

    [header setImage:headerImageViewBackgroundImage];
}

- (void)updateContentAccordingToCurrentInterfaceOrientation:(UIImageView *)header
                                                 tabBarCtrl:(UITabBarController *)ctrl {

    UIImage *tabBarBackgroundImage = nil;
    UIImage *tabBarSelectionIndicatorImage = nil;

    UIInterfaceOrientation current = [[UIApplication sharedApplication] statusBarOrientation];

    if (UIInterfaceOrientationIsPortrait(current)) { // current layout is "Portrait"
        tabBarBackgroundImage = [UIImage imageNamed:@"tab-bar_hg"];
        tabBarSelectionIndicatorImage = [UIImage imageNamed:@"tab-bar_active"];
    }
    else if (UIInterfaceOrientationIsLandscape(current)) { // current layout is "Landscape"
        NSString *tabBarImageName = @"tab-bar_hg_wide";
        NSString *tabBarSelectionImageName = @"tab-bar_active_wide";
        if (IS_IPHONE_5) {
            tabBarImageName = [NSString stringWithFormat:@"%@-568h", tabBarImageName];
            tabBarSelectionImageName = [NSString stringWithFormat:@"%@-568h", tabBarSelectionImageName];
        }
        tabBarBackgroundImage = [UIImage imageNamed:tabBarImageName];
        tabBarSelectionIndicatorImage = [UIImage imageNamed:tabBarSelectionImageName];
    }

    [ctrl.tabBar setBackgroundImage:tabBarBackgroundImage];
    [ctrl.tabBar setSelectionIndicatorImage:tabBarSelectionIndicatorImage];
    [self updateHeaderAccordingToCurrentInterfaceOrientation:header baseName:@"header"];
}

@end
