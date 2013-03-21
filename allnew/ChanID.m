//
//  ChanID.m
//  allnew
//
//  Created by Martin Adam on 11.03.13.
//  Copyright (c) 2013 mCRUMBS GmbH. All rights reserved.
//

#import "ChanID.h"

@implementation ChanID

static ChanID *sharedUser = nil;

+ (ChanID *)sharedUser {
    @synchronized (self) {
        if (sharedUser == nil) {
            [[self alloc] init]; // assignment not done here
        }
    }
    return sharedUser;
}

+ (id)allocWithZone:(NSZone *)zone {
    @synchronized (self) {
        if (sharedUser == nil) {
            return [super allocWithZone:zone]; // assignment and return on first allocation
        }
    }
    return sharedUser;
}

- (id)init {
    Class myClass = [self class];
    @synchronized (myClass) {
        if (sharedUser == nil) {
            if (self = [super init]) {
                sharedUser = self;
                // custom initialization here
            }
        }
    }
    return sharedUser;
}

- (id)copyWithZone:(NSZone *)zone {
    return self;
}

@end

