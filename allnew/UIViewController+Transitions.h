//
//  UIViewController+Transitions.h
//  Start-App
//
//  Created by Jörg Polakowski on 28/03/13.
//  Copyright (c) 2013 mCRUMBS GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Transitions)

/**
 *
 *
 * @param direction - A type for the transition. Legal values are 'fromLeft', 'fromRight', 'fromTop' and 'fromBottom'.
 */
- (void) presentViewController:(UIViewController *)viewController withPushDirection:(NSString *)direction;

/**
 *
 *
 * @param direction - A type for the transition. Legal values are 'fromLeft', 'fromRight', 'fromTop' and 'fromBottom'.
 */
- (void) dismissViewControllerWithPushDirection:(NSString *)direction completion:(void (^)(void))completion;

@end

