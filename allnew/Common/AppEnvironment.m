//
//  AppEnvironment.m
//  Start-App
//
//  Created by Jörg Polakowski on 22/03/13.
//  Copyright (c) 2013 mCRUMBS GmbH. All rights reserved.
//

#import "AppEnvironment.h"

#define kMCrumbsStartupAppUniqueAppIdentifierKey @"Unique identifier for myApp"


@implementation AppEnvironment

+ (NSString *)createUUID {
    NSString *uIdentifier = [[NSUserDefaults standardUserDefaults] objectForKey:kMCrumbsStartupAppUniqueAppIdentifierKey];
    if (!uIdentifier) {
        CFUUIDRef uuidRef = CFUUIDCreate(NULL);
        CFStringRef uuidStringRef = CFUUIDCreateString(NULL, uuidRef);
        CFRelease(uuidRef);
        uIdentifier = [NSString stringWithString:(__bridge NSString *)uuidStringRef];
        CFRelease(uuidStringRef);
        [[NSUserDefaults standardUserDefaults] setObject:uIdentifier forKey:kMCrumbsStartupAppUniqueAppIdentifierKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    return uIdentifier;
}

@end
