//
//  SplashScreenViewController.h
//  Start-App
//
//  Created by Jörg Polakowski on 24/03/13.
//  Copyright (c) 2013 mCRUMBS GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SplashScreenCustomBlockType)(void);

@interface SplashScreenViewController : UIViewController

@property(weak) IBOutlet UIImageView *imageView;
@property(weak) IBOutlet UIImageView *animatedImageView;

@property(strong) SplashScreenCustomBlockType callbackBlock;

- (id)initWithCallbackBlock:(void (^)())block;

@end
