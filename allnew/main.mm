//
//  main.m
//  allnew
//
//  Created by Martin Adam on 11.03.13.
//  Copyright (c) 2013 mCRUMBS GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"
// #import "iPadAppDelegate.h"

int main(int argc, char *argv[])
{
    @autoreleasepool {
        
  //      if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
  //      {
  //
  //          return UIApplicationMain(argc, argv, nil, NSStringFromClass([iPadAppDelegate class]));
  //      }
  //      else{
            
            return UIApplicationMain(argc, argv, nil,  NSStringFromClass([AppDelegate class]));
  //      }
    }
}