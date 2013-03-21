//
//  FirstViewController.h
//  allnew
//
//  Created by Martin Adam on 11.03.13.
//  Copyright (c) 2013 mCRUMBS GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIWebView *webView1;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingSign1;
@property (weak, nonatomic) IBOutlet UILabel *label1;

@property (strong, nonatomic) UIWindow *window;
@property (weak, nonatomic) IBOutlet UIImageView *image1;

@end
