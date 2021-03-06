//
//  AppEnvironment.h
//  Start-App
//
//  Created by Jörg Polakowski on 22/03/13.
//  Copyright (c) 2013 mCRUMBS GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_IPHONE_5 (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 568.0f)
#define IS_IPHONE_4 (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 480.0f)

@interface AppEnvironment : NSObject

/**
* Creates and returns a unique app identifier.
* The returned identifier is always the same over multiple method calls.
*/
+ (NSString *)createUUID;

/**
* Returns 'YES' if the device's display is a retina display, otherwise 'NO'.
*/
+ (BOOL)isRetina;

/**
* Checks if the current device screen is retina display and adopts the provided image name accordingly.
 * e.g. "some_image_name" will be transformed to "some_image_name" when the display is retina
*/
+ (NSString *)imageNameRetinizer:(NSString *)imageName;

@end
