//
//  FirstiPadViewController.m
//  allnew
//
//  Created by Martin Adam on 12.03.13.
//  Copyright (c) 2013 mCRUMBS GmbH. All rights reserved.
//

#import "FirstiPadViewController.h"
#import "ARViewController.h"
#import "ChanID.h"


@interface FirstiPadViewController ()

@end

@implementation FirstiPadViewController

@synthesize window = _window;

@synthesize webViewP1;
@synthesize loadingSignP1;
@synthesize labelP1;

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
    self.tabBarController.tabBar.hidden = YES;
    NSArray * imageArray  = [[NSArray alloc] initWithObjects:
                             [UIImage imageNamed:@"1.png"],
                             [UIImage imageNamed:@"2.png"],
                             [UIImage imageNamed:@"3.png"],
                             [UIImage imageNamed:@"4.png"],
                             [UIImage imageNamed:@"5.png"],
                             nil];
	UIImageView * ryuJump = [[UIImageView alloc] initWithFrame:
                             CGRectMake(0, 0, 320, 568)];
	ryuJump.animationImages = imageArray;
	ryuJump.animationDuration = 1.1;
    ryuJump.animationRepeatCount = 1;
	ryuJump.contentMode = UIViewContentModeBottomLeft;
    [self.view addSubview:ryuJump];
	[ryuJump startAnimating];
    ChanID *user = [ChanID sharedUser];
    if ([user.cusurl isEqualToString:@"channel1"]) {
        ARViewController* junaioPlugin = [[ARViewController alloc] init];
        
        // present the viewcontroller
        [self presentModalViewController:junaioPlugin animated:YES];
    }
}

- (void)viewDidUnload
{
    [self setWebViewP1:nil];
    [self setLoadingSignP1:nil];
    [self setLabelP1:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)viewWillAppear:(BOOL)animated {
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillAppear:animated];
    self.webViewP1.hidden = NO;
    self.labelP1.hidden = YES;
    NSString *myAppUniqueID =[self createUUID];
    NSString *fullURL = [NSString stringWithFormat:@"http://mcrumbs.com?uid=%@", myAppUniqueID];
    NSURL *websiteURL = [NSURL URLWithString:fullURL];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:websiteURL];
    [self.webViewP1 loadRequest:requestObj];
}


-(void) webViewDidStartLoad:(UIWebView *)webView {
    [self.loadingSignP1 startAnimating];
    self.loadingSignP1.hidden = NO;
}

-(void) webViewDidFinishLoad:(UIWebView *)webView {
    [self.loadingSignP1 stopAnimating];
    self.loadingSignP1.hidden = YES;
    self.tabBarController.tabBar.hidden = NO;
}

-(void)webView:(UIWebView *)webview didFailLoadWithError:(NSError *)error {
    self.webViewP1.hidden = YES;
    [self.loadingSignP1 stopAnimating];
    self.loadingSignP1.hidden = YES;
    self.labelP1.hidden = NO;
    self.tabBarController.tabBar.hidden = NO;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
