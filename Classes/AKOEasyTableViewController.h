//
//  AKOEasyTableViewController.h
//  EasyTableView
//
//  Created by Adrian on 11/22/09.
//  Copyright 2009 akosma software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AKOEasyTableViewControllerDelegate.h"

@interface AKOEasyTableViewController : UITableViewController 
{
@private
    NSArray *_dataSource;
    BOOL _hasSections;
    BOOL _autoDeselect;
    UITableViewCellAccessoryType _accessoryType;
    CGFloat _rowHeight;
    NSString *_dataSourceFileName;

    id<AKOEasyTableViewControllerDelegate> _delegate;
}

@property (nonatomic, retain) NSArray *dataSource;
@property (nonatomic, assign) id delegate;
@property (nonatomic) BOOL autoDeselect;
@property (nonatomic) UITableViewCellAccessoryType accessoryType;
@property (nonatomic) CGFloat rowHeight;
@property (nonatomic, copy) NSString *dataSourceFileName;

- (void)deselectSelectedRow;

@end
