//
//  FirstiPadViewController.h
//  allnew
//
//  Created by Martin Adam on 12.03.13.
//  Copyright (c) 2013 mCRUMBS GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstiPadViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIWebView *webViewP1;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingSignP1;
@property (weak, nonatomic) IBOutlet UILabel *labelP1;

@property (strong, nonatomic) UIWindow *window;


@end
