//
//  ThirdViewController.h
//  allnew
//
//  Created by Martin Adam on 12.03.13.
//  Copyright (c) 2013 mCRUMBS GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThirdViewController : UIViewController <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView3;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingSign3;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;

// ARView button and UI action handling
@property(weak) IBOutlet UIButton *startARViewButton;

- (IBAction)startARViewAction:(id)sender;

@end
