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
#import "ARViewController.h"

// Categories
#import "UIViewController+RotationHandler.h"
#import "UIViewController+Transitions.h"
#import "AppDelegate.h"


//***************************************************************************************
// private interface declaration
//***************************************************************************************
@interface FirstViewController ()

@end


//***************************************************************************************
// public interface implementation
//***************************************************************************************
@implementation FirstViewController

@synthesize webView1;
@synthesize loadingSign1;
@synthesize label1;
@synthesize image1;

- (void)viewDidLoad {
    [super viewDidLoad];
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

    [self updateContentAccordingToCurrentInterfaceOrientation:self.headerImageView
                                                   tabBarCtrl:self.tabBarController];

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

#pragma mark -
#pragma mark Interface Rotation

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES; // support all orientations
}

- (void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    [self updateContentAccordingToCurrentInterfaceOrientation:self.headerImageView
                                                   tabBarCtrl:self.tabBarController];
}

#pragma mark -
#pragma mark UI action handling

- (IBAction)startARViewAction:(id)sender {
    ARViewController *junaioPlugin = [[ARViewController alloc] init];
    [self presentViewController:junaioPlugin withPushDirection:@"fromRight"];
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
}

-(void)webView:(UIWebView *)webview didFailLoadWithError:(NSError *)error {
    self.webView1.hidden = YES;
    [self.loadingSign1 stopAnimating];
    self.loadingSign1.hidden = YES;
    self.label1.hidden = NO;
    self.image1.hidden = NO;
}

@end
