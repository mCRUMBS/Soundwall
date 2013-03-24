//
//  SplashScreenViewController.m
//  Start-App
//
//  Created by Jörg Polakowski on 24/03/13.
//  Copyright (c) 2013 mCRUMBS GmbH. All rights reserved.
//

#import "SplashScreenViewController.h"

@interface SplashScreenViewController ()
- (void)animationDone;
@end

@implementation SplashScreenViewController

#pragma mark -
#pragma mark initialization

- (id)initWithCallbackBlock:(void (^)())block {
    self = [super initWithNibName:@"SplashScreenViewController" bundle:nil];
    if (self) {
        self.callbackBlock = block;
    }
    return self;
}

#pragma mark -
#pragma mark view lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    NSMutableArray *imageArray = [NSMutableArray arrayWithCapacity:100];
    for (int j = 1; j < 99; j++) {
        NSMutableString *imageName = [NSMutableString string];
        [imageName appendString:@"Splash"];
        [imageName appendString:[NSString stringWithFormat:@"%d", j]];
        if (screenSize.height > 480.0f) {
            [imageName appendString:@"-568h"];
        }
        UIImage *image = [UIImage imageNamed:imageName];
        if (image == nil) {
            NSLog(@"WARNING: trying to load image '%@' failed, because the image file does not exist.", imageName);
        }
        [imageArray addObject:image];
    }

    NSTimeInterval duration = 5.0;

    self.imageView.animationImages = imageArray;
    self.imageView.animationDuration = duration;
    self.imageView.animationRepeatCount = 1;
    self.imageView.contentMode = UIViewContentModeScaleToFill;
    [self.imageView startAnimating];

    [self performSelector:@selector(animationDone) withObject:nil afterDelay:duration];
}

#pragma mark -
#pragma mark interface rotation

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}

#pragma mark -
#pragma mark private methods

- (void)animationDone {
    if (self.callbackBlock) {
        self.callbackBlock();
    }
}

@end
