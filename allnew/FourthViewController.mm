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

@interface FourthViewController ()

@end

@implementation FourthViewController

@synthesize webView4;
@synthesize loadingSign4;
@synthesize label4;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self updateContentAccordingToCurrentInterfaceOrientation];
}

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
