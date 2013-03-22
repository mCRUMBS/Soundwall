//
//  AppEnvironment.h
//  Start-App
//
//  Created by Jörg Polakowski on 22/03/13.
//  Copyright (c) 2013 mCRUMBS GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>

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
