//
//  FirstViewController.h
//  allnew
//
//  Created by Martin Adam on 11.03.13.
//  Copyright (c) 2013 mCRUMBS GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstViewController : UIViewController <UIWebViewDelegate>

@property(weak, nonatomic) IBOutlet UIWebView *webView1;
@property(weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingSign1;
@property(weak, nonatomic) IBOutlet UILabel *label1;
@property(weak, nonatomic) IBOutlet UIImageView *image1;
@property(weak, nonatomic) IBOutlet UIImageView *headerImageView; // view controller's header

// ARView button and UI action handling
@property(weak) IBOutlet UIButton *startARViewButton;

- (IBAction)startARViewAction:(id)sender;

@end
