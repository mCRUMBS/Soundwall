//
//  FirstViewController.m
//  allnew
//
//  Created by Martin Adam on 11.03.13.
//  Copyright (c) 2013 mCRUMBS GmbH. All rights reserved.
//

#import "FirstViewController.h"
#import "ChanID.h"
#import "AppEnvironment.h"

@class EAGLView;

//***************************************************************************************
// private interface declaration
//***************************************************************************************
@interface FirstViewController ()

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

    // todo Martin: do we still need to hide / show the tabbar ??
//    [self hideTabBar:self.tabBarController];

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

// todo not needed anymore
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

// todo not needed anymore
- (void)showTabBar:(UITabBarController *)tabbarcontroller {
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
    return YES; // support all orientations
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
//    [self showTabBar:self.tabBarController]; // todo causes the tab bar to disappear in landscape layout
}

-(void)webView:(UIWebView *)webview didFailLoadWithError:(NSError *)error {
    self.webView1.hidden = YES;
    [self.loadingSign1 stopAnimating];
    self.loadingSign1.hidden = YES;
    self.label1.hidden = NO;
    self.image1.hidden = NO;
//    [self showTabBar:self.tabBarController];
}

@end
