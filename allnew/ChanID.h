//
//  ChanID.h
//  allnew
//
//  Created by Martin Adam on 11.03.13.
//  Copyright (c) 2013 mCRUMBS GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChanID : NSObject

@property (nonatomic, retain) NSString *chanid;
@property (nonatomic, retain) NSString *junloaded;
@property (nonatomic, retain) NSString *cusurl;
@property (nonatomic, retain) NSString *custest;
@property (nonatomic, retain) NSString *lat;
@property (nonatomic, retain) NSString *lon;

+ (ChanID *)sharedUser;

@end

