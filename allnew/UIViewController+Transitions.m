//
//  UIViewController+Transitions.m
//  Start-App
//
//  Created by Jörg Polakowski on 28/03/13.
//  Copyright (c) 2013 mCRUMBS GmbH. All rights reserved.
//

#import "UIViewController+Transitions.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIViewController (Transitions)

- (void)presentViewController:(UIViewController *)viewController withPushDirection:(NSString *)direction {
    [CATransaction begin];
    
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionPush;
    transition.subtype = [self adjustAnimationDirectionAccordingToInterfaceOrientation:direction];
    transition.duration = 0.25f;
    transition.fillMode = kCAFillModeForwards;
    transition.removedOnCompletion = YES;
    
    [[UIApplication sharedApplication].keyWindow.layer addAnimation:transition forKey:@"transition"];
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    [CATransaction setCompletionBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t) (transition.duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        });
    }];
    [self presentViewController:viewController animated:NO completion:NULL];
    [CATransaction commit];
}

- (void)dismissViewControllerWithPushDirection:(NSString *)direction {
    [CATransaction begin];
    
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionPush;
    transition.subtype = [self adjustAnimationDirectionAccordingToInterfaceOrientation:direction];
    transition.duration = 0.25f;
    transition.fillMode = kCAFillModeForwards;
    transition.removedOnCompletion = YES;
    
    [[UIApplication sharedApplication].keyWindow.layer addAnimation:transition forKey:@"transition"];
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    [CATransaction setCompletionBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t) (transition.duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        });
    }];
    [self dismissViewControllerAnimated:NO completion:NULL];
    [CATransaction commit];
}

//    'fromLeft', 'fromRight', 'fromTop' and 'fromBottom'.
- (NSString *)adjustAnimationDirectionAccordingToInterfaceOrientation:(NSString *)direction {
    UIInterfaceOrientation current = [[UIApplication sharedApplication] statusBarOrientation];
    NSString *adjustedDirection = direction;
    if ([direction isEqualToString:@"fromRight"]) {
        if (current == UIInterfaceOrientationPortrait) {
            adjustedDirection = @"fromRight";
        }
        else if (current == UIInterfaceOrientationPortraitUpsideDown) {
            adjustedDirection = @"fromLeft";
        }
        else if (current == UIInterfaceOrientationLandscapeLeft) {
            adjustedDirection = @"fromBottom";
        }
        else if (current == UIInterfaceOrientationLandscapeRight) {
            adjustedDirection = @"fromTop";
        }
    }
    else if ([direction isEqualToString:@"fromLeft"]) {
        if (current == UIInterfaceOrientationPortrait) {
            adjustedDirection = @"fromLeft";
        }
        else if (current == UIInterfaceOrientationPortraitUpsideDown) {
            adjustedDirection = @"fromRight";
        }
        else if (current == UIInterfaceOrientationLandscapeLeft) {
            adjustedDirection = @"fromTop";
        }
        else if (current == UIInterfaceOrientationLandscapeRight) {
            adjustedDirection = @"fromBottom";
        }
    }
    else if ([direction isEqualToString:@"fromTop"]) {
        if (current == UIInterfaceOrientationPortrait) {
            adjustedDirection = @"fromTop";
        }
        else if (current == UIInterfaceOrientationPortraitUpsideDown) {
            adjustedDirection = @"fromBottom";
        }
        else if (current == UIInterfaceOrientationLandscapeLeft) {
            adjustedDirection = @"fromLeft";
        }
        else if (current == UIInterfaceOrientationLandscapeRight) {
            adjustedDirection = @"fromRight";
        }
    }
    else if ([direction isEqualToString:@"fromBottom"]) {
        if (current == UIInterfaceOrientationPortrait) {
            adjustedDirection = @"fromBottom";
        }
        else if (current == UIInterfaceOrientationPortraitUpsideDown) {
            adjustedDirection = @"fromTop";
        }
        else if (current == UIInterfaceOrientationLandscapeLeft) {
            adjustedDirection = @"fromRight";
        }
        else if (current == UIInterfaceOrientationLandscapeRight) {
            adjustedDirection = @"fromLeft";
        }
    }
    return adjustedDirection;
}

@end



