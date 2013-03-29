//
//  SplashScreenViewController.m
//  Start-App
//
//  Created by Jörg Polakowski on 24/03/13.
//  Copyright (c) 2013 mCRUMBS GmbH. All rights reserved.
//

#import "SplashScreenViewController.h"
#import "AppEnvironment.h"

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

    // setup background image view
    NSString *backgroundImageName = nil;
    if (IS_IPHONE_5) {
        backgroundImageName = @"Splash_bg-568h@2x";
        self.animatedImageView.frame = CGRectMake(68, 80, 184, 302);
    }
    else {
        self.animatedImageView.frame = CGRectMake(68, 41, 184, 390);
        if ([AppEnvironment isRetina]) {
            backgroundImageName = @"Splash_bg@2x";
        }
        else {
            backgroundImageName = @"Splash_bg";
        }
    }
    self.imageView.image = [UIImage imageNamed:backgroundImageName];

    // setup animation image view
    CGFloat nRed = 217.0 / 255.0;
    CGFloat nGreen = 229.0 / 255.0;
    CGFloat nBlue = 237.0 / 255.0;
    [self.view setBackgroundColor:[UIColor colorWithRed:nRed green:nGreen blue:nBlue alpha:1]];

    NSMutableArray *imageArray = [NSMutableArray arrayWithCapacity:100];
    for (int j = 1; j < 99; j++) {
        NSString *imageName = [NSString stringWithFormat:@"Splash%d@2x.png", j];
        UIImage *image = [UIImage imageNamed:imageName];
        if (image == nil) {
            NSLog(@"WARNING: trying to load image '%@' failed, because the image file does not exist.", imageName);
        }
        [imageArray addObject:image];
    }

    NSTimeInterval duration = 5.0;

    self.animatedImageView.animationImages = imageArray;
    self.animatedImageView.animationDuration = duration;
    self.animatedImageView.animationRepeatCount = 1;
    self.animatedImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.animatedImageView startAnimating];

    [self performSelector:@selector(animationDone) withObject:nil afterDelay:duration];
}

#pragma mark -
#pragma mark interface rotation

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationPortrait;
}

- (BOOL)shouldAutorotate {
    return NO;
}

#pragma mark -
#pragma mark private methods

- (void)animationDone {
    if (self.callbackBlock) {
        self.callbackBlock();
    }
}

@end
