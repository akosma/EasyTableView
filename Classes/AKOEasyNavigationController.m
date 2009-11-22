//
//  AKOEasyNavigationController.m
//  EasyTableView
//
//  Created by Adrian on 11/22/09.
//  Copyright 2009 akosma software. All rights reserved.
//

#import "AKOEasyNavigationController.h"
#import "AKOEasyTableViewController.h"

@implementation AKOEasyNavigationController

@synthesize dataSequence = _dataSequence;
@dynamic dataSequenceFileName;

#pragma mark -
#pragma mark Init and dealloc

- (id)initWithRootViewController:(UIViewController *)rootViewController
{
    if (self = [super initWithRootViewController:rootViewController])
    {
        _dataSequenceFileName = nil;
        _dataSequence = nil;
    }
    return self;
}

- (void)dealloc 
{
    [_dataSequence release];
    [_dataSequenceFileName release];
    [super dealloc];
}

#pragma mark -
#pragma mark Public properties

- (NSString *)dataSequenceFileName
{
    return _dataSequenceFileName;
}

- (void)setDataSequenceFileName:(NSString *)newFileName
{
    [_dataSequenceFileName release];
    _dataSequenceFileName = [newFileName copy];
    NSString *path = [[NSBundle mainBundle] pathForResource:newFileName ofType:@"plist"];
    if (path != nil)
    {
        NSArray *array = [[NSArray alloc] initWithContentsOfFile:path];
        self.dataSequence = array;
        [array release];
    }
}

#pragma mark -
#pragma mark Public methods

- (void)loadNextScreen
{
    if (_dataSequence != nil && [_dataSequence count] >= [self.viewControllers count])
    {
        NSInteger index = [self.viewControllers count] - 1;
        NSDictionary *dict = [_dataSequence objectAtIndex:index];
        UITableViewStyle style = (UITableViewStyle)[[dict objectForKey:@"style"] intValue];
        UITableViewCellAccessoryType accessory = (UITableViewCellAccessoryType)[[dict objectForKey:@"accessory"] intValue];
        CGFloat rowHeight = (CGFloat)[[dict objectForKey:@"rowHeight"] floatValue];
        NSString *fileName = [dict objectForKey:@"fileName"];

        AKOEasyTableViewController *newController = [[AKOEasyTableViewController alloc] initWithStyle:style];
        newController.title = @"Detail View";
        newController.dataSourceFileName = fileName;
        newController.title = fileName;
        newController.autoDeselect = YES;
        newController.delegate = self;
        newController.accessoryType = accessory;
        newController.rowHeight = rowHeight;
        [self pushViewController:newController animated:YES];
        [newController release];
    }
}

#pragma mark -
#pragma mark AKOEasyTableViewControllerDelegate methods

- (void)easyTableViewController:(AKOEasyTableViewController *)controller 
                  didSelectItem:(id)item
{
    [self loadNextScreen];
}

- (void)easyTableViewController:(AKOEasyTableViewController *)controller 
         didTapAccessoryForItem:(id)item
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Accessory Tapped" 
                                                    message:[item description] 
                                                   delegate:nil
                                          cancelButtonTitle:@"OK" 
                                          otherButtonTitles:nil];    
    [alert show];
    [alert release];
}

@end
