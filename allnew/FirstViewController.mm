//
//  FirstViewController.m
//  allnew
//
//  Created by Martin Adam on 11.03.13.
//  Copyright (c) 2013 mCRUMBS GmbH. All rights reserved.
//

#import "FirstViewController.h"
#import "ARViewController.h"
#import "ChanID.h"
#import "AppEnvironment.h"
#import "AppDelegate.h"

@class EAGLView;

static BOOL START_ANIMATION_FINISHED = NO;

//***************************************************************************************
// private interface declaration
//***************************************************************************************
@interface FirstViewController ()

- (void)trackNotifications:(NSNotification *)notification;

- (void)presentARViewController;

@end


//***************************************************************************************
// public interface implementation
//***************************************************************************************
@implementation FirstViewController

@synthesize window = _window;

@synthesize webView1;
@synthesize loadingSign1;
@synthesize label1;
@synthesize image1;

- (void)viewDidLoad {
    [super viewDidLoad];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(trackNotifications:)
                                                 name:kAppShouldSwitchToChannel1 object:nil];

    // Animierter SplashScreen
    START_ANIMATION_FINISHED = NO;
    [self hideTabBar:self.tabBarController];

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

    CGFloat h = (screenSize.height > 480.0f) ? 568 : 480;
    UIImageView *ryuJump = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, h)];
    ryuJump.animationImages = imageArray;
    ryuJump.animationDuration = 5;
    ryuJump.animationRepeatCount = 1;
    ryuJump.contentMode = UIViewContentModeScaleToFill;
    [self.view addSubview:ryuJump];
    [ryuJump startAnimating];
    ChanID *user = [ChanID sharedUser];
    user.starter = @"1";
}

- (void)viewDidUnload {
    [self setWebView1:nil];
    [self setLoadingSign1:nil];
    [self setImage1:nil];
    [self setHeaderImageView:nil];
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated {
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillAppear:animated];

    [self updateContentAccordingToCurrentInterfaceOrientation];

    self.webView1.hidden = NO;
    self.label1.hidden = YES;
    self.image1.hidden = YES;
    ChanID *user = [ChanID sharedUser];
    NSString *fullURL = [NSString stringWithFormat:@"http://bmwi.marways.com/web/news/?uid=%@&lat=%@&lon=%@",
                    [AppEnvironment createUUID], user.lat, user.lon];
    NSURL *websiteURL = [NSURL URLWithString:fullURL];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:websiteURL];
    [self.webView1 loadRequest:requestObj];
    
}

//- (void)applicationWillEnterForeground:(UIApplication *)application

- (void)viewDidAppear:(BOOL)animated {
    [self presentARViewController];
}

- (void)hideTabBar:(UITabBarController *) tabbarcontroller {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.01];
    for (UIView *view in tabbarcontroller.view.subviews) {
        CGSize screenSize = [[UIScreen mainScreen] bounds].size;
        if ([view isKindOfClass:[UITabBar class]]) {
            CGFloat y = (screenSize.height > 480.0f) ? 568 : 480;
            [view setFrame:CGRectMake(view.frame.origin.x, y, view.frame.size.width, view.frame.size.height)];
        }
        else {
            CGFloat height = (screenSize.height > 480.0f) ? 568 : 480;
            [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, height)];
        }
    }
    [UIView commitAnimations];
}

- (void)showTabBar:(UITabBarController *)tabbarcontroller {
    START_ANIMATION_FINISHED = YES;
    NSLog(@"Showing tab bar ....");
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    for (UIView *view in tabbarcontroller.view.subviews) {
        CGSize screenSize = [[UIScreen mainScreen] bounds].size;
        CGFloat y = (screenSize.height > 480.0f) ? 519 : 431;
        if ([view isKindOfClass:[UITabBar class]]) {
            [view setFrame:CGRectMake(view.frame.origin.x, y, view.frame.size.width, view.frame.size.height)];
        }
        else {
            CGFloat height = (screenSize.height > 480.0f) ? 519 : 431;
            [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, height)];
        }
    }
    [UIView commitAnimations];
}

#pragma mark -
#pragma mark Interface Rotation

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    if (START_ANIMATION_FINISHED == NO) {
        return UIInterfaceOrientationIsPortrait(interfaceOrientation);
    }
    else {
        return YES; // support all orientations
    }
}

- (void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    [self updateContentAccordingToCurrentInterfaceOrientation];
}

- (void)updateContentAccordingToCurrentInterfaceOrientation {
    UIImage *tabBarBackgroundImage = nil;
    UIImage *tabBarSelectionIndicatorImage = nil;
    UIImage *headerImageViewBackgroundImage = nil;

    UIEdgeInsets imgInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    UIInterfaceOrientation current = [[UIApplication sharedApplication] statusBarOrientation];

    if (UIInterfaceOrientationIsPortrait(current)) { // current layout is "Portrait"
        tabBarBackgroundImage = [UIImage imageNamed:@"tab-bar_hg"];
        tabBarSelectionIndicatorImage = [[UIImage imageNamed:@"tab-bar_active.png"] resizableImageWithCapInsets:imgInsets];
        headerImageViewBackgroundImage = [[UIImage imageNamed:@"header.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 200, 0, 300)];
    }
    else if (UIInterfaceOrientationIsLandscape(current)) { // current layout is "Landscape"
        NSString *tabBarImageName = @"tab-bar_hg_wide";
        NSString *headerImageName = @"header_wide";
        if (IS_IPHONE_5) {
            tabBarImageName = [NSString stringWithFormat:@"%@-568h", tabBarImageName];
            headerImageName = [NSString stringWithFormat:@"%@-568h", headerImageName];
        }
        tabBarBackgroundImage = [UIImage imageNamed:tabBarImageName];
        tabBarSelectionIndicatorImage = [[UIImage imageNamed:@"tab-bar_active_wide.png"] resizableImageWithCapInsets:imgInsets];
        headerImageViewBackgroundImage = [[UIImage imageNamed:headerImageName] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 200, 0, 300)];
    }

    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tabBarController.tabBar setBackgroundImage:tabBarBackgroundImage];
        [self.tabBarController.tabBar setSelectionIndicatorImage:tabBarSelectionIndicatorImage];
        [self.headerImageView setImage:headerImageViewBackgroundImage];
    });
}

#pragma mark -
#pragma mark UIWebViewDelegate

-(void) webViewDidStartLoad:(UIWebView *)webView {
    [self.loadingSign1 startAnimating];
    self.loadingSign1.hidden = NO;
}

-(void) webViewDidFinishLoad:(UIWebView *)webView {
    [self.loadingSign1 stopAnimating];
    self.loadingSign1.hidden = YES;
    [NSThread sleepForTimeInterval:5.0];
    [self showTabBar:self.tabBarController]; // todo causes the tab bar to disappear in landscape layout
}

-(void)webView:(UIWebView *)webview didFailLoadWithError:(NSError *)error {
    self.webView1.hidden = YES;
    [self.loadingSign1 stopAnimating];
    self.loadingSign1.hidden = YES;
    self.label1.hidden = NO;
    self.image1.hidden = NO;
    [NSThread sleepForTimeInterval:5.0];
    [self showTabBar:self.tabBarController];
}

#pragma mark -
#pragma mark private methods

#pragma mark NSNotificationCenter callback

- (void)trackNotifications:(NSNotification *)notification {
    if ([[notification name] isEqualToString:kAppShouldSwitchToChannel1]) {
        [self presentARViewController];
    }
}

- (void)presentARViewController {
    ChanID *user = [ChanID sharedUser];
    if ([user.starter isEqualToString:@"1"]) {
        if ([user.cusurl isEqualToString:@"channel1"]) {
            [self.window makeKeyAndVisible];
            ARViewController *junaioPlugin = [[ARViewController alloc] init];
            [self presentViewController:junaioPlugin animated:YES completion:nil];
        }
    }
    user.starter = @"0";
}


@end
