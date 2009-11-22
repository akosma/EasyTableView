//
//  AKOEasyTableViewControllerDelegate.h
//  EasyTableView
//
//  Created by Adrian on 11/22/09.
//  Copyright 2009 akosma software. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AKOEasyTableViewController;

@protocol AKOEasyTableViewControllerDelegate <NSObject>

@optional
- (void)easyTableViewController:(AKOEasyTableViewController *)controller 
                  didSelectItem:(id)item;

- (void)easyTableViewController:(AKOEasyTableViewController *)controller 
         didTapAccessoryForItem:(id)item;

@end
