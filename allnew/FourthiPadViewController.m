//
//  FourthiPadViewController.m
//  allnew
//
//  Created by Martin Adam on 12.03.13.
//  Copyright (c) 2013 mCRUMBS GmbH. All rights reserved.
//

#import "FourthiPadViewController.h"

@interface FourthiPadViewController ()

@end

@implementation FourthiPadViewController

@synthesize webViewP4;
@synthesize loadingSignP4;
@synthesize labelP4;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (NSString *)createUUID {
    
    NSString *uIdentifier = [[NSUserDefaults standardUserDefaults] objectForKey:@"Unique identifier for myApp"];
    
    if (!uIdentifier) {
        
        CFUUIDRef uuidRef = CFUUIDCreate(NULL);
        
        CFStringRef uuidStringRef = CFUUIDCreateString(NULL, uuidRef);
        
        CFRelease(uuidRef);
        
        uIdentifier = [NSString stringWithString:(__bridge NSString *)uuidStringRef];
        
        CFRelease(uuidStringRef);
        
        [[NSUserDefaults standardUserDefaults] setObject:uIdentifier forKey:@"Unique identifier for myApp"];
        
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    }
    
    return uIdentifier;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
   
}

- (void)viewDidUnload
{
    [self setWebViewP4:nil];
    [self setLoadingSignP4:nil];
    [self setLabelP4:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)viewWillAppear:(BOOL)animated {
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillAppear:animated];
    self.webViewP4.hidden = NO;
    self.labelP4.hidden = YES;
    NSString *myAppUniqueID =[self createUUID];
    NSString *fullURL = [NSString stringWithFormat:@"http://mcrumbs.com?uid=%@", myAppUniqueID];
    NSURL *websiteURL = [NSURL URLWithString:fullURL];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:websiteURL];
    [self.webViewP4 loadRequest:requestObj];
}


-(void) webViewDidStartLoad:(UIWebView *)webView {
    [self.loadingSignP4 startAnimating];
    self.loadingSignP4.hidden = NO;
}

-(void) webViewDidFinishLoad:(UIWebView *)webView {
    [self.loadingSignP4 stopAnimating];
    self.loadingSignP4.hidden = YES;
}

-(void)webView:(UIWebView *)webview didFailLoadWithError:(NSError *)error {
    self.webViewP4.hidden = YES;
    [self.loadingSignP4 stopAnimating];
    self.loadingSignP4.hidden = YES;
    self.labelP4.hidden = NO;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
