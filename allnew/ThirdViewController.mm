//
//  ThirdViewController.m
//  allnew
//
//  Created by Martin Adam on 12.03.13.
//  Copyright (c) 2013 mCRUMBS GmbH. All rights reserved.
//

#import "ThirdViewController.h"
#import "ChanID.h"
#import "AppEnvironment.h"

@interface ThirdViewController ()

@end

@implementation ThirdViewController

@synthesize webView3;
@synthesize loadingSign3;
@synthesize label3;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self updateContentAccordingToCurrentInterfaceOrientation];
}

- (void)viewDidUnload {
    [self setWebView3:nil];
    [self setLoadingSign3:nil];
    [self setLabel3:nil];
    [self setHeaderImageView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)viewWillAppear:(BOOL)animated {
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillAppear:animated];
    self.webView3.hidden = NO;
    self.label3.hidden = YES;
    ChanID *user = [ChanID sharedUser];
    NSString *fullURL = [NSString stringWithFormat:@"http://bmwi.marways.com/web/startup/?uid=%@&lat=%@&lon=%@",
                    [AppEnvironment createUUID], user.lat, user.lon];
    NSURL *websiteURL = [NSURL URLWithString:fullURL];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:websiteURL];
    [self.webView3 loadRequest:requestObj];

}

#pragma mark -
#pragma mark Interface Rotation

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
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
    [self.loadingSign3 startAnimating];
    self.loadingSign3.hidden = NO;
}

-(void) webViewDidFinishLoad:(UIWebView *)webView {
    [self.loadingSign3 stopAnimating];
    self.loadingSign3.hidden = YES;
}

-(void)webView:(UIWebView *)webview didFailLoadWithError:(NSError *)error {
    self.webView3.hidden = YES;
    [self.loadingSign3 stopAnimating];
    self.loadingSign3.hidden = YES;
    self.label3.hidden = NO;
}

@end
