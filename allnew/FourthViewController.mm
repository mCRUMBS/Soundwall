//
//  FourthViewController.m
//  allnew
//
//  Created by Martin Adam on 12.03.13.
//  Copyright (c) 2013 mCRUMBS GmbH. All rights reserved.
//

#import "FourthViewController.h"
#import "ChanID.h"
#import "AppEnvironment.h"
#import "UIViewController+RotationHandler.h"

@interface FourthViewController ()

@end

@implementation FourthViewController

@synthesize webView4;
@synthesize loadingSign4;
@synthesize label4;

- (void)viewDidUnload {
    [self setWebView4:nil];
    [self setLoadingSign4:nil];
    [self setLabel4:nil];
    [self setHeaderImageView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)viewWillAppear:(BOOL)animated {
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillAppear:animated];

    [self updateContentAccordingToCurrentInterfaceOrientation:self.headerImageView
                                                   tabBarCtrl:self.tabBarController];

    self.webView4.hidden = NO;
    self.label4.hidden = YES;
    ChanID *user = [ChanID sharedUser];
    NSString *fullURL = [NSString stringWithFormat:@"http://bmwi.marways.com/web/mehr/?uid=%@&lat=%@&lon=%@",
                    [AppEnvironment createUUID], user.lat, user.lon];
    NSURL *websiteURL = [NSURL URLWithString:fullURL];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:websiteURL];
    [self.webView4 loadRequest:requestObj];
}

#pragma mark -
#pragma mark Interface Rotation

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

- (void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    [self updateContentAccordingToCurrentInterfaceOrientation:self.headerImageView
                                                   tabBarCtrl:self.tabBarController];
}

#pragma mark -
#pragma mark UIWebViewDelegate

-(void) webViewDidStartLoad:(UIWebView *)webView {
    [self.loadingSign4 startAnimating];
    self.loadingSign4.hidden = NO;
}

-(void) webViewDidFinishLoad:(UIWebView *)webView {
    [self.loadingSign4 stopAnimating];
    self.loadingSign4.hidden = YES;
}

-(void)webView:(UIWebView *)webview didFailLoadWithError:(NSError *)error {
    self.webView4.hidden = YES;
    [self.loadingSign4 stopAnimating];
    self.loadingSign4.hidden = YES;
    self.label4.hidden = NO;
}

@end
