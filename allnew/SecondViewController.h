//
//  SecondViewController.h
//  allnew
//
//  Created by Martin Adam on 11.03.13.
//  Copyright (c) 2013 mCRUMBS GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondViewController : UIViewController <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView2;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingSign2;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;

@end
