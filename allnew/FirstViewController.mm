//
//  FirstViewController.m
//  allnew
//
//  Created by Martin Adam on 11.03.13.
//  Copyright (c) 2013 mCRUMBS GmbH. All rights reserved.
//

#import "FirstViewController.h"
#import "ARViewController.h"
#import "ChanID.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

@synthesize window = _window;

@synthesize webView1;
@synthesize loadingSign1;
@synthesize label1;
@synthesize image1;

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
    
    // Animierter SplashScreen
    [self hideTabBar:self.tabBarController];
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    if (screenSize.height > 480.0f) {
        NSArray * imageArray  = [[NSArray alloc] initWithObjects:
                                 [UIImage imageNamed:@"Splash1-568h.png"],
                                 [UIImage imageNamed:@"Splash2-568h.png"],
                                 [UIImage imageNamed:@"Splash3-568h.png"],
                                 [UIImage imageNamed:@"Splash4-568h.png"],
                                 [UIImage imageNamed:@"Splash5-568h.png"],
                                 [UIImage imageNamed:@"Splash6-568h.png"],
                                 [UIImage imageNamed:@"Splash7-568h.png"],
                                 [UIImage imageNamed:@"Splash8-568h.png"],
                                 [UIImage imageNamed:@"Splash9-568h.png"],
                                 [UIImage imageNamed:@"Splash10-568h.png"],
                                 [UIImage imageNamed:@"Splash11-568h.png"],
                                 [UIImage imageNamed:@"Splash12-568h.png"],
                                 [UIImage imageNamed:@"Splash13-568h.png"],
                                 [UIImage imageNamed:@"Splash14-568h.png"],
                                 [UIImage imageNamed:@"Splash15-568h.png"],
                                 [UIImage imageNamed:@"Splash16-568h.png"],
                                 [UIImage imageNamed:@"Splash17-568h.png"],
                                 [UIImage imageNamed:@"Splash18-568h.png"],
                                 [UIImage imageNamed:@"Splash19-568h.png"],
                                 [UIImage imageNamed:@"Splash20-568h.png"],
                                 [UIImage imageNamed:@"Splash21-568h.png"],
                                 [UIImage imageNamed:@"Splash22-568h.png"],
                                 [UIImage imageNamed:@"Splash23-568h.png"],
                                 [UIImage imageNamed:@"Splash24-568h.png"],
                                 [UIImage imageNamed:@"Splash25-568h.png"],
                                 [UIImage imageNamed:@"Splash26-568h.png"],
                                 [UIImage imageNamed:@"Splash27-568h.png"],
                                 [UIImage imageNamed:@"Splash28-568h.png"],
                                 [UIImage imageNamed:@"Splash29-568h.png"],
                                 [UIImage imageNamed:@"Splash30-568h.png"],
                                 [UIImage imageNamed:@"Splash31-568h.png"],
                                 [UIImage imageNamed:@"Splash32-568h.png"],
                                 [UIImage imageNamed:@"Splash33-568h.png"],
                                 [UIImage imageNamed:@"Splash34-568h.png"],
                                 [UIImage imageNamed:@"Splash35-568h.png"],
                                 [UIImage imageNamed:@"Splash36-568h.png"],
                                 [UIImage imageNamed:@"Splash37-568h.png"],
                                 [UIImage imageNamed:@"Splash38-568h.png"],
                                 [UIImage imageNamed:@"Splash39-568h.png"],
                                 [UIImage imageNamed:@"Splash40-568h.png"],
                                 [UIImage imageNamed:@"Splash41-568h.png"],
                                 [UIImage imageNamed:@"Splash42-568h.png"],
                                 [UIImage imageNamed:@"Splash43-568h.png"],
                                 [UIImage imageNamed:@"Splash44-568h.png"],
                                 [UIImage imageNamed:@"Splash45-568h.png"],
                                 [UIImage imageNamed:@"Splash46-568h.png"],
                                 [UIImage imageNamed:@"Splash47-568h.png"],
                                 [UIImage imageNamed:@"Splash48-568h.png"],
                                 [UIImage imageNamed:@"Splash49-568h.png"],
                                 [UIImage imageNamed:@"Splash50-568h.png"],
                                 [UIImage imageNamed:@"Splash51-568h.png"],
                                 [UIImage imageNamed:@"Splash52-568h.png"],
                                 [UIImage imageNamed:@"Splash53-568h.png"],
                                 [UIImage imageNamed:@"Splash54-568h.png"],
                                 [UIImage imageNamed:@"Splash55-568h.png"],
                                 [UIImage imageNamed:@"Splash56-568h.png"],
                                 [UIImage imageNamed:@"Splash57-568h.png"],
                                 [UIImage imageNamed:@"Splash58-568h.png"],
                                 [UIImage imageNamed:@"Splash59-568h.png"],
                                 [UIImage imageNamed:@"Splash60-568h.png"],
                                 [UIImage imageNamed:@"Splash61-568h.png"],
                                 [UIImage imageNamed:@"Splash62-568h.png"],
                                 [UIImage imageNamed:@"Splash63-568h.png"],
                                 [UIImage imageNamed:@"Splash64-568h.png"],
                                 [UIImage imageNamed:@"Splash65-568h.png"],
                                 [UIImage imageNamed:@"Splash66-568h.png"],
                                 [UIImage imageNamed:@"Splash67-568h.png"],
                                 [UIImage imageNamed:@"Splash68-568h.png"],
                                 [UIImage imageNamed:@"Splash69-568h.png"],
                                 [UIImage imageNamed:@"Splash70-568h.png"],
                                 [UIImage imageNamed:@"Splash71-568h.png"],
                                 [UIImage imageNamed:@"Splash72-568h.png"],
                                 [UIImage imageNamed:@"Splash73-568h.png"],
                                 [UIImage imageNamed:@"Splash74-568h.png"],
                                 [UIImage imageNamed:@"Splash75-568h.png"],
                                 [UIImage imageNamed:@"Splash76-568h.png"],
                                 [UIImage imageNamed:@"Splash77-568h.png"],
                                 [UIImage imageNamed:@"Splash78-568h.png"],
                                 [UIImage imageNamed:@"Splash79-568h.png"],
                                 [UIImage imageNamed:@"Splash80-568h.png"],
                                 [UIImage imageNamed:@"Splash81-568h.png"],
                                 [UIImage imageNamed:@"Splash82-568h.png"],
                                 [UIImage imageNamed:@"Splash83-568h.png"],
                                 [UIImage imageNamed:@"Splash84-568h.png"],
                                 [UIImage imageNamed:@"Splash85-568h.png"],
                                 [UIImage imageNamed:@"Splash86-568h.png"],
                                 [UIImage imageNamed:@"Splash87-568h.png"],
                                 [UIImage imageNamed:@"Splash88-568h.png"],
                                 [UIImage imageNamed:@"Splash89-568h.png"],
                                 [UIImage imageNamed:@"Splash90-568h.png"],
                                 [UIImage imageNamed:@"Splash91-568h.png"],
                                 [UIImage imageNamed:@"Splash92-568h.png"],
                                 [UIImage imageNamed:@"Splash93-568h.png"],
                                 [UIImage imageNamed:@"Splash94-568h.png"],
                                 [UIImage imageNamed:@"Splash95-568h.png"],
                                 [UIImage imageNamed:@"Splash96-568h.png"],
                                 [UIImage imageNamed:@"Splash97-568h.png"],
                                 [UIImage imageNamed:@"Splash98-568h.png"],
                                 [UIImage imageNamed:@"Splash98-568h.png"],
                                 [UIImage imageNamed:@"Splash98-568h.png"],
                                 [UIImage imageNamed:@"Splash98-568h.png"],
                                 [UIImage imageNamed:@"Splash98-568h.png"],
                                 [UIImage imageNamed:@"Splash98-568h.png"],
                                 [UIImage imageNamed:@"Splash98-568h.png"],
                                 [UIImage imageNamed:@"Splash98-568h.png"],
                                 [UIImage imageNamed:@"Splash98-568h.png"],
                                 [UIImage imageNamed:@"Splash98-568h.png"],
                                 [UIImage imageNamed:@"Splash98-568h.png"],
                                 [UIImage imageNamed:@"Splash98-568h.png"],
                                 [UIImage imageNamed:@"Splash98-568h.png"],
                                 [UIImage imageNamed:@"Splash98-568h.png"],
                                 [UIImage imageNamed:@"Splash98-568h.png"],
                                 [UIImage imageNamed:@"Splash98-568h.png"],
                                 [UIImage imageNamed:@"Splash98-568h.png"],
                                 [UIImage imageNamed:@"Splash98-568h.png"],
                                 [UIImage imageNamed:@"Splash98-568h.png"],
                                 [UIImage imageNamed:@"Splash98-568h.png"],
                                 [UIImage imageNamed:@"Splash98-568h.png"],
                                 [UIImage imageNamed:@"Splash98-568h.png"],
                                 [UIImage imageNamed:@"Splash98-568h.png"],
                                 [UIImage imageNamed:@"Splash98-568h.png"],
                                 [UIImage imageNamed:@"Splash98-568h.png"],
                                 [UIImage imageNamed:@"Splash98-568h.png"],
                                 [UIImage imageNamed:@"Splash98-568h.png"],
                                 [UIImage imageNamed:@"Splash98-568h.png"],
                                 [UIImage imageNamed:@"Splash98-568h.png"],
                                 [UIImage imageNamed:@"Splash98-568h.png"],
                                 [UIImage imageNamed:@"Splash98-568h.png"],
                                 [UIImage imageNamed:@"Splash98-568h.png"],
                                 [UIImage imageNamed:@"Splash98-568h.png"],
                                 [UIImage imageNamed:@"Splash98-568h.png"],
                                 [UIImage imageNamed:@"Splash98-568h.png"],
                                 [UIImage imageNamed:@"Splash98-568h.png"],
                                 [UIImage imageNamed:@"Splash98-568h.png"],
                                 [UIImage imageNamed:@"Splash98-568h.png"],
                                 [UIImage imageNamed:@"Splash98-568h.png"],
                                 [UIImage imageNamed:@"Splash98-568h.png"],
                                 [UIImage imageNamed:@"Splash98-568h.png"],
                                 [UIImage imageNamed:@"Splash98-568h.png"],
                                 [UIImage imageNamed:@"Splash98-568h.png"],
                                 [UIImage imageNamed:@"Splash98-568h.png"],
                                 [UIImage imageNamed:@"Splash98-568h.png"],
                                 [UIImage imageNamed:@"Splash98-568h.png"],
                                 [UIImage imageNamed:@"Splash98-568h.png"],
                                 [UIImage imageNamed:@"Splash98-568h.png"],
                                 [UIImage imageNamed:@"Splash98-568h.png"],
                                 [UIImage imageNamed:@"Splash98-568h.png"],
                                 [UIImage imageNamed:@"Splash98-568h.png"],
                             nil];
            UIImageView * ryuJump = [[UIImageView alloc] initWithFrame:
                                 CGRectMake(0, 0, 320, 568)];
            ryuJump.animationImages = imageArray;
            ryuJump.animationDuration = 5.0;
            ryuJump.animationRepeatCount = 1;
            ryuJump.contentMode = UIViewContentModeBottomLeft;
            [self.view addSubview:ryuJump];
            [ryuJump startAnimating];
        } else {
            NSArray * imageArray  = [[NSArray alloc] initWithObjects:
                                     [UIImage imageNamed:@"Splash1.png"],
                                     [UIImage imageNamed:@"Splash2.png"],
                                     [UIImage imageNamed:@"Splash3.png"],
                                     [UIImage imageNamed:@"Splash4.png"],
                                     [UIImage imageNamed:@"Splash5.png"],
                                     [UIImage imageNamed:@"Splash6.png"],
                                     [UIImage imageNamed:@"Splash7.png"],
                                     [UIImage imageNamed:@"Splash8.png"],
                                     [UIImage imageNamed:@"Splash9.png"],
                                     [UIImage imageNamed:@"Splash10.png"],
                                     [UIImage imageNamed:@"Splash11.png"],
                                     [UIImage imageNamed:@"Splash12.png"],
                                     [UIImage imageNamed:@"Splash13.png"],
                                     [UIImage imageNamed:@"Splash14.png"],
                                     [UIImage imageNamed:@"Splash15.png"],
                                     [UIImage imageNamed:@"Splash16.png"],
                                     [UIImage imageNamed:@"Splash17.png"],
                                     [UIImage imageNamed:@"Splash18.png"],
                                     [UIImage imageNamed:@"Splash19.png"],
                                     [UIImage imageNamed:@"Splash20.png"],
                                     [UIImage imageNamed:@"Splash21.png"],
                                     [UIImage imageNamed:@"Splash22.png"],
                                     [UIImage imageNamed:@"Splash23.png"],
                                     [UIImage imageNamed:@"Splash24.png"],
                                     [UIImage imageNamed:@"Splash25.png"],
                                     [UIImage imageNamed:@"Splash26.png"],
                                     [UIImage imageNamed:@"Splash27.png"],
                                     [UIImage imageNamed:@"Splash28.png"],
                                     [UIImage imageNamed:@"Splash29.png"],
                                     [UIImage imageNamed:@"Splash30.png"],
                                     [UIImage imageNamed:@"Splash31.png"],
                                     [UIImage imageNamed:@"Splash32.png"],
                                     [UIImage imageNamed:@"Splash33.png"],
                                     [UIImage imageNamed:@"Splash34.png"],
                                     [UIImage imageNamed:@"Splash35.png"],
                                     [UIImage imageNamed:@"Splash36.png"],
                                     [UIImage imageNamed:@"Splash37.png"],
                                     [UIImage imageNamed:@"Splash38.png"],
                                     [UIImage imageNamed:@"Splash39.png"],
                                     [UIImage imageNamed:@"Splash40.png"],
                                     [UIImage imageNamed:@"Splash41.png"],
                                     [UIImage imageNamed:@"Splash42.png"],
                                     [UIImage imageNamed:@"Splash43.png"],
                                     [UIImage imageNamed:@"Splash44.png"],
                                     [UIImage imageNamed:@"Splash45.png"],
                                     [UIImage imageNamed:@"Splash46.png"],
                                     [UIImage imageNamed:@"Splash47.png"],
                                     [UIImage imageNamed:@"Splash48.png"],
                                     [UIImage imageNamed:@"Splash49.png"],
                                     [UIImage imageNamed:@"Splash50.png"],
                                     [UIImage imageNamed:@"Splash51.png"],
                                     [UIImage imageNamed:@"Splash52.png"],
                                     [UIImage imageNamed:@"Splash53.png"],
                                     [UIImage imageNamed:@"Splash54.png"],
                                     [UIImage imageNamed:@"Splash55.png"],
                                     [UIImage imageNamed:@"Splash56.png"],
                                     [UIImage imageNamed:@"Splash57.png"],
                                     [UIImage imageNamed:@"Splash58.png"],
                                     [UIImage imageNamed:@"Splash59.png"],
                                     [UIImage imageNamed:@"Splash60.png"],
                                     [UIImage imageNamed:@"Splash61.png"],
                                     [UIImage imageNamed:@"Splash62.png"],
                                     [UIImage imageNamed:@"Splash63.png"],
                                     [UIImage imageNamed:@"Splash64.png"],
                                     [UIImage imageNamed:@"Splash65.png"],
                                     [UIImage imageNamed:@"Splash66.png"],
                                     [UIImage imageNamed:@"Splash67.png"],
                                     [UIImage imageNamed:@"Splash68.png"],
                                     [UIImage imageNamed:@"Splash69.png"],
                                     [UIImage imageNamed:@"Splash70.png"],
                                     [UIImage imageNamed:@"Splash71.png"],
                                     [UIImage imageNamed:@"Splash72.png"],
                                     [UIImage imageNamed:@"Splash73.png"],
                                     [UIImage imageNamed:@"Splash74.png"],
                                     [UIImage imageNamed:@"Splash75.png"],
                                     [UIImage imageNamed:@"Splash76.png"],
                                     [UIImage imageNamed:@"Splash77.png"],
                                     [UIImage imageNamed:@"Splash78.png"],
                                     [UIImage imageNamed:@"Splash79.png"],
                                     [UIImage imageNamed:@"Splash80.png"],
                                     [UIImage imageNamed:@"Splash81.png"],
                                     [UIImage imageNamed:@"Splash82.png"],
                                     [UIImage imageNamed:@"Splash83.png"],
                                     [UIImage imageNamed:@"Splash84.png"],
                                     [UIImage imageNamed:@"Splash85.png"],
                                     [UIImage imageNamed:@"Splash86.png"],
                                     [UIImage imageNamed:@"Splash87.png"],
                                     [UIImage imageNamed:@"Splash88.png"],
                                     [UIImage imageNamed:@"Splash89.png"],
                                     [UIImage imageNamed:@"Splash90.png"],
                                     [UIImage imageNamed:@"Splash91.png"],
                                     [UIImage imageNamed:@"Splash92.png"],
                                     [UIImage imageNamed:@"Splash93.png"],
                                     [UIImage imageNamed:@"Splash94.png"],
                                     [UIImage imageNamed:@"Splash95.png"],
                                     [UIImage imageNamed:@"Splash96.png"],
                                     [UIImage imageNamed:@"Splash97.png"],
                                     [UIImage imageNamed:@"Splash98.png"],
                                     [UIImage imageNamed:@"Splash98.png"],
                                     [UIImage imageNamed:@"Splash98.png"],
                                     [UIImage imageNamed:@"Splash98.png"],
                                     [UIImage imageNamed:@"Splash98.png"],
                                     [UIImage imageNamed:@"Splash98.png"],
                                     [UIImage imageNamed:@"Splash98.png"],
                                     [UIImage imageNamed:@"Splash98.png"],
                                     [UIImage imageNamed:@"Splash98.png"],
                                     [UIImage imageNamed:@"Splash98.png"],
                                     [UIImage imageNamed:@"Splash98.png"],
                                     [UIImage imageNamed:@"Splash98.png"],
                                     [UIImage imageNamed:@"Splash98.png"],
                                     [UIImage imageNamed:@"Splash98.png"],
                                     [UIImage imageNamed:@"Splash98.png"],
                                     [UIImage imageNamed:@"Splash98.png"],
                                     [UIImage imageNamed:@"Splash98.png"],
                                     [UIImage imageNamed:@"Splash98.png"],
                                     [UIImage imageNamed:@"Splash98.png"],
                                     [UIImage imageNamed:@"Splash98.png"],
                                     [UIImage imageNamed:@"Splash98.png"],
                                     [UIImage imageNamed:@"Splash98.png"],
                                     [UIImage imageNamed:@"Splash98.png"],
                                     [UIImage imageNamed:@"Splash98.png"],
                                     [UIImage imageNamed:@"Splash98.png"],
                                     [UIImage imageNamed:@"Splash98.png"],
                                     [UIImage imageNamed:@"Splash98.png"],
                                     [UIImage imageNamed:@"Splash98.png"],
                                     [UIImage imageNamed:@"Splash98.png"],
                                     [UIImage imageNamed:@"Splash98.png"],
                                     [UIImage imageNamed:@"Splash98.png"],
                                     [UIImage imageNamed:@"Splash98.png"],
                                     [UIImage imageNamed:@"Splash98.png"],
                                     [UIImage imageNamed:@"Splash98.png"],
                                     [UIImage imageNamed:@"Splash98.png"],
                                     [UIImage imageNamed:@"Splash98.png"],
                                     [UIImage imageNamed:@"Splash98.png"],
                                     [UIImage imageNamed:@"Splash98.png"],
                                     [UIImage imageNamed:@"Splash98.png"],
                                     [UIImage imageNamed:@"Splash98.png"],
                                     [UIImage imageNamed:@"Splash98.png"],
                                     [UIImage imageNamed:@"Splash98.png"],
                                     [UIImage imageNamed:@"Splash98.png"],
                                     [UIImage imageNamed:@"Splash98.png"],
                                     [UIImage imageNamed:@"Splash98.png"],
                                     [UIImage imageNamed:@"Splash98.png"],
                                     [UIImage imageNamed:@"Splash98.png"],
                                     [UIImage imageNamed:@"Splash98.png"],
                                     [UIImage imageNamed:@"Splash98.png"],
                                     [UIImage imageNamed:@"Splash98.png"],
                                     [UIImage imageNamed:@"Splash98.png"],
                                     nil];
            UIImageView * ryuJump = [[UIImageView alloc] initWithFrame:
                                     CGRectMake(0, 0, 320, 480)];
            ryuJump.animationImages = imageArray;
            ryuJump.animationDuration = 5.0;
            ryuJump.animationRepeatCount = 1;
            ryuJump.contentMode = UIViewContentModeBottomLeft;
            [self.view addSubview:ryuJump];
            [ryuJump startAnimating];
        }
    
}

- (void)viewDidUnload
{
    [self setWebView1:nil];
    [self setLoadingSign1:nil];
    [self setImage1:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)viewWillAppear:(BOOL)animated {
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillAppear:animated];
    self.webView1.hidden = NO;
    self.label1.hidden = YES;
    self.image1.hidden = YES;
    ChanID *user = [ChanID sharedUser];
    NSString *myAppUniqueID =[self createUUID];
    NSString *fullURL = [NSString stringWithFormat:@"http://bmwi.marways.com/web/news/?uid=%@&lat=%@&lon=%@", myAppUniqueID, user.lat, user.lon];
    NSURL *websiteURL = [NSURL URLWithString:fullURL];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:websiteURL];
    [self.webView1 loadRequest:requestObj];
    
}

- (void)viewDidAppear:(BOOL)animated {
    ChanID *user = [ChanID sharedUser];
    if ([user.cusurl isEqualToString:@"channel1"]) {
        [self.window makeKeyAndVisible];
        ARViewController* junaioPlugin = [[ARViewController alloc] init];
    
        // present the viewcontroller
        [self presentViewController:junaioPlugin animated:YES completion:nil];
        
    }
}


-(void) webViewDidStartLoad:(UIWebView *)webView {
    [self.loadingSign1 startAnimating];
    self.loadingSign1.hidden = NO;
}


-(void) webViewDidFinishLoad:(UIWebView *)webView {
    [self.loadingSign1 stopAnimating];
    self.loadingSign1.hidden = YES;
    [NSThread sleepForTimeInterval:5.0];
    [self showTabBar:self.tabBarController];
}

-(void)webView:(UIWebView *)webview didFailLoadWithError:(NSError *)error {
    self.webView1.hidden = YES;
    [self.loadingSign1 stopAnimating];
    self.loadingSign1.hidden = YES;
    self.label1.hidden = NO;
    self.image1.hidden = NO;
    [NSThread sleepForTimeInterval:5.0];
    [self showTabBar:self.tabBarController];
}

- (void)hideTabBar:(UITabBarController *) tabbarcontroller
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.01];
    
    for(UIView *view in tabbarcontroller.view.subviews)
    {
       CGSize screenSize = [[UIScreen mainScreen] bounds].size;
        if([view isKindOfClass:[UITabBar class]])
        {
            
            
            
                if (screenSize.height > 480.0f) {
                    [view setFrame:CGRectMake(view.frame.origin.x, 568, view.frame.size.width, view.frame.size.height)];
                } else {
                    [view setFrame:CGRectMake(view.frame.origin.x, 480, view.frame.size.width, view.frame.size.height)];
                }
          
           
        }
        else
        {
            if (screenSize.height > 480.0f) {
                [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, 568)];
            } else {
                [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, 480)];
            }
        }
    }
    
    [UIView commitAnimations];
}

- (void)showTabBar:(UITabBarController *) tabbarcontroller
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    for(UIView *view in tabbarcontroller.view.subviews)
    {
        NSLog(@"%@", view);
        CGSize screenSize = [[UIScreen mainScreen] bounds].size;
        if([view isKindOfClass:[UITabBar class]])
        {
            if (screenSize.height > 480.0f) {
                [view setFrame:CGRectMake(view.frame.origin.x, 519, view.frame.size.width, view.frame.size.height)];
             } else {
                 [view setFrame:CGRectMake(view.frame.origin.x, 431, view.frame.size.width, view.frame.size.height)];
             }
            
        }
        else
        {
            if (screenSize.height > 480.0f) {
                [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, 519)];
             } else {
                 [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, 431)];
             }
        }
    }
    
    [UIView commitAnimations];
}


@end
