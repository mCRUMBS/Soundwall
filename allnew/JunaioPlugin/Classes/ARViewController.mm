//
//  ARViewController.m
//
//  Created by Stefan Misslinger on 3/1/11.
//  Copyright 2012 metaio GmbH. All rights reserved.
//

#import "ARViewController.h"

// categories
#import "UIViewController+RotationHandler.h"
#import "UIViewController+Transitions.h"

//***************************************************************************************
// private interface declaration
//***************************************************************************************
@interface ARViewController ()



@end


//***************************************************************************************
// public interface implementation
//***************************************************************************************
@implementation ARViewController

#pragma mark - View lifecycle
@class EAGLView;

- (void)viewDidLoad {
    [super viewDidLoad];
    [LiveViewObjectContextView class];
    // use this call to move the radar position
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        [self setRadarOffset:CGPointMake(-16, -20) scale:0.825f anchor:ANCHOR_TR];
    }
    else {
        [self setRadarOffset:CGPointMake(-4.5, -20) scale:0.55f anchor:ANCHOR_TR];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [self updateHeaderAccordingToCurrentInterfaceOrientation:self.headerImageView baseName:@"ar_header"];
}

#pragma mark - react to UI events

// Close the UIViewcontroller on pushing the close button.
- (IBAction)onBtnClosePushed:(id)sender {
    [self dismissViewControllerWithPushDirection:@"fromLeft" completion:^{
        if (self.delegate) {
            [self.delegate closeButtonPushed];
        }
    }];
}

#pragma mark -
#pragma mark Interface Rotation

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES; // support all orientations
}

- (void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    [self updateHeaderAccordingToCurrentInterfaceOrientation:self.headerImageView baseName:@"ar_header"];
}

#pragma mark - @protocol JunaioPluginDelegate

/** 
 * Provide the channel number that should be opened by the plugin 
 * In order to get your channel ID, please signup as a developer on http://www.junaio.com/developer
 * and create your own junaio channel.
 *
 * If you want to use a location based channel, be sure to return 'YES' for (BOOL) shouldUseLocation,
 * otherwise 'NO'.
 */
- (NSInteger) getChannelID
{
	// TODO: fill in your channel ID here.
	
//	bool loadLocationBasedChannel = false;
//	if( loadLocationBasedChannel )
//	{
		// set locationAtStartup to YES, because we're loading a location based channel
		// that needs the location at the first request
		m_useLocationAtStartup = YES;
		return 166268;    // Wikipedia EN channel
//	}
//	else
//	{
		// set locationAtStartup to NO, because we don't need a location for the first request
		// This is the default for all AREL XML channels that don't provide location based content
//		m_useLocationAtStartup = NO;
//		return 124471;		// AREL Soccer Shootout channel
//	}
}



/** Optional
 *
 * return YES if the application should support location
 * If you return NO here, your application will never access the location sensors.
 * Most scan channels don't need a location, so NO can be returned here.
 */
- (BOOL) shouldUseLocation
{
    return YES;
}



/** Optional
 *
 * return YES if the application should activate location sensors at startup
 * This will cause the application requesting permission at startup
 * Return YES here if you are using a location based channel that needs location at startup
 * Returning NO will cause the request to the server having no location
 */
- (BOOL) shouldUseLocationAtStartup
{
    return [self shouldUseLocation] && m_useLocationAtStartup;
}



///** Optional
// *
// * return YES to cache downloaded files
// * During the development phase it makes sense to return NO here,
// * if the channel content changes a lot.
// */
//- (BOOL) shouldUseCache
//{
//	return YES;
//}


@end
