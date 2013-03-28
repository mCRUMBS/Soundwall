//
//  ARViewController.h
//
//  Created by Stefan Misslinger on 3/1/11.
//  Copyright 2012 metaio GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JunaioPlugin/JunaioPluginViewController.h>


//***************************************************************************************
// ARViewController UI delegate
//***************************************************************************************
@protocol ARViewControllerUIDelegate <NSObject>
/**
* Gets called when the ARViewController has been closed.
*/
-(void)closeButtonPushed;
@end


/** This class represents the AR view. Implement the JunaioPluginDelegate protocol to define the channel ID to use */
@interface ARViewController : JunaioPluginViewController {
	bool	m_useLocationAtStartup;	//!< Flag to indicate if we should use the location at startup
}

@property(weak) IBOutlet UIView *headerView;
@property(weak) IBOutlet UIImageView *headerImageView;
@property(weak) IBOutlet UIButton *backButton;

@property(nonatomic, assign) id <ARViewControllerUIDelegate> delegate;

// Interface action handling
- (IBAction)onBackButtonAction:(id)sender;
- (IBAction)onBtnClosePushed:(id)sender;

@end
