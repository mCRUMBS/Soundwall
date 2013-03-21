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
    NSMutableArray *imageArray = [NSMutableArray arrayWithCapacity:100];
    for (int j = 1; j < 99; j++) {
        NSMutableString *imageName = [NSMutableString string];
        [imageName appendString:@"Splash"];
//        if (j <= 9) {
//            [imageName appendString:@"0"];
//        }
        [imageName appendString:[NSString stringWithFormat:@"%d", j]];
        if (screenSize.height > 480.0f) {
            [imageName appendString:@"-568h"];
        }
        NSLog(@"Scale: %2f", screenSize.height);
        if ([UIScreen mainScreen].scale > 1.0) { // retina
            [imageName appendString:@"@2x"];
        }

        NSLog(@"Image name: %@", imageName);
        [imageArray addObject:[UIImage imageNamed:imageName]];
    }

    CGFloat h = (screenSize.height > 480.0f) ? 568 : 480;
    UIImageView *ryuJump = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, h)];
    ryuJump.animationImages = imageArray;
    ryuJump.animationDuration = 5;
    ryuJump.animationRepeatCount = 1;
    ryuJump.contentMode = UIViewContentModeScaleToFill;
    [self.view addSubview:ryuJump];
    [ryuJump startAnimating];
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
