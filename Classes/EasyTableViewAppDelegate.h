//
//  EasyTableViewAppDelegate.h
//  EasyTableView
//
//  Created by Adrian on 11/22/09.
//  Copyright akosma software 2009. All rights reserved.
//

#import "AKOEasyTableViewControllerDelegate.h"

@class AKOEasyNavigationController;

@interface EasyTableViewAppDelegate : NSObject <UIApplicationDelegate,
                                                AKOEasyTableViewControllerDelegate> 
{
@private
    IBOutlet UIWindow *_window;
    AKOEasyNavigationController *_navigationController;
}

@end

