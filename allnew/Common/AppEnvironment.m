//
//  AppEnvironment.m
//  Start-App
//
//  Created by Jörg Polakowski on 22/03/13.
//  Copyright (c) 2013 mCRUMBS GmbH. All rights reserved.
//

#import "AppEnvironment.h"
#import "UAirship.h"
#import "UAPush.h"

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

+ (BOOL)isRetina {
    return [UIScreen mainScreen].scale > 1.0;
}

+ (NSString *)imageNameRetinizer:(NSString *)imageName {
    NSString *transformedImageName = imageName;
    if ([AppEnvironment isRetina]) {
        transformedImageName = [NSString stringWithFormat:@"%@@2x", transformedImageName];
    }
    NSLog(@"Transformed Image Name: %@", transformedImageName);
    return transformedImageName;
}

#pragma mark - APNS

+ (void)setApnsDeviceToken:(NSData *)token {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:token forKey:@"apnsDeviceToken"];
    [defaults synchronize];
}

+ (NSData *)apnsDeviceToken {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:@"apnsDeviceToken"];
}

#pragma mark - Push notifications

+ (void)setupPushNotificationsWithOptions:(NSDictionary *)options {
    NSMutableDictionary *takeOffOptions = [[NSMutableDictionary alloc] init];
    [takeOffOptions setValue:options forKey:UAirshipTakeOffOptionsLaunchOptionsKey];
    [UAirship takeOff:takeOffOptions];
#if defined (DEVELOPMENT)
    [UAirship setLogging:YES];
#endif
    [[UAPush shared] enableAutobadge:YES];
    [[UAPush shared] resetBadge];

    [[UIApplication sharedApplication]
            registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
}

@end
