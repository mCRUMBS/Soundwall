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

@interface SecondViewController ()

@end

@implementation SecondViewController

@synthesize webView2;
@synthesize loadingSign2;
@synthesize label2;

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self updateContentAccordingToCurrentInterfaceOrientation];
}

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
    [self updateContentAccordingToCurrentInterfaceOrientation];
}

- (void)updateContentAccordingToCurrentInterfaceOrientation {
    UIInterfaceOrientation current = [[UIApplication sharedApplication] statusBarOrientation];
    UIImage *headerImageViewBackgroundImage = nil;
    if (UIInterfaceOrientationIsPortrait(current)) { // current layout is "Portrait"
        headerImageViewBackgroundImage = [[UIImage imageNamed:@"header.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 200, 0, 300)];
    }
    else if (UIInterfaceOrientationIsLandscape(current)) { // current layout is "Landscape"
        headerImageViewBackgroundImage = [[UIImage imageNamed:@"header_wide.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 200, 0, 300)];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.headerImageView setImage:headerImageViewBackgroundImage];
    });
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
