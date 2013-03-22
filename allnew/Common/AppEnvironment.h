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

@end
