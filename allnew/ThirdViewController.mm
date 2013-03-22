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
@synthesize image3a;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidUnload {
    [self setWebView3:nil];
    [self setLoadingSign3:nil];
    [self setLabel3:nil];
    [self setImage3a:nil];
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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
//    return (interfaceOrientation == UIInterfaceOrientationPortrait);
    return YES;
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
