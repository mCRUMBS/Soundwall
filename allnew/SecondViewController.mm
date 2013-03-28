//
//  SecondViewController.m
//  allnew
//
//  Created by Martin Adam on 11.03.13.
//  Copyright (c) 2013 mCRUMBS GmbH. All rights reserved.
//

#import "SecondViewController.h"
#import "ChanID.h"
#import "AppEnvironment.h"
#import "UIViewController+RotationHandler.h"
#import "UIViewController+Transitions.h"
#import "ARViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

@synthesize webView2;
@synthesize loadingSign2;
@synthesize label2;

- (void)viewDidUnload {
    [self setWebView2:nil];
    [self setLoadingSign2:nil];
    [self setLabel2:nil];
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

    self.webView2.hidden = NO;
    self.label2.hidden = YES;
    ChanID *user = [ChanID sharedUser];
    NSString *fullURL = [NSString stringWithFormat:@"http://bmwi.marways.com/web/stories/?uid=%@&lat=%@&lon=%@",
                    [AppEnvironment createUUID], user.lat, user.lon];
    NSURL *websiteURL = [NSURL URLWithString:fullURL];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:websiteURL];
    [self.webView2 loadRequest:requestObj];
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
#pragma mark UI action handling

- (IBAction)startARViewAction:(id)sender {
    ARViewController *junaioPlugin = [[ARViewController alloc] init];
    [self presentViewController:junaioPlugin withPushDirection:@"fromRight"];
}

#pragma mark -
#pragma mark UIWebViewDelegate

-(void) webViewDidStartLoad:(UIWebView *)webView {
    [self.loadingSign2 startAnimating];
    self.loadingSign2.hidden = NO;
}

-(void) webViewDidFinishLoad:(UIWebView *)webView {
    [self.loadingSign2 stopAnimating];
    self.loadingSign2.hidden = YES;
}

-(void)webView:(UIWebView *)webview didFailLoadWithError:(NSError *)error {
    self.webView2.hidden = YES;
    [self.loadingSign2 stopAnimating];
    self.loadingSign2.hidden = YES;
    self.label2.hidden = NO;
}

@end
