//
//  EasyTableViewAppDelegate.m
//  EasyTableView
//
//  Created by Adrian on 11/22/09.
//  Copyright akosma software 2009. All rights reserved.
//

#import "EasyTableViewAppDelegate.h"
#import "AKOEasyNavigationController.h"
#import "AKOEasyTableViewController.h"

@implementation EasyTableViewAppDelegate

#pragma mark -
#pragma mark Application lifecycle

- (void)applicationDidFinishLaunching:(UIApplication *)application 
{    
    //    NSArray *data = [NSArray arrayWithObjects:@"first", @"second", @"third", nil];
    
    NSArray *data1 = [NSArray arrayWithObjects:@"first", @"second", @"third", nil];
    NSArray *data2 = [NSArray arrayWithObjects:@"fourth", @"fifth", @"sixth", @"seventh", nil];
    NSDictionary *dict1 = [NSDictionary dictionaryWithObjectsAndKeys:data1, @"values", @"title1", @"title", nil];
    NSDictionary *dict2 = [NSDictionary dictionaryWithObjectsAndKeys:data2, @"values", @"title2", @"title", nil];
    NSArray *data = [NSArray arrayWithObjects:dict1, dict2, nil];

    AKOEasyTableViewController *rootViewController = [[AKOEasyTableViewController alloc] initWithStyle:UITableViewStylePlain];
    rootViewController.title = @"Easy Table View";
    rootViewController.delegate = self;
    rootViewController.dataSource = data;
    rootViewController.autoDeselect = YES;
    rootViewController.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    _navigationController = [[AKOEasyNavigationController alloc] initWithRootViewController:rootViewController];
    _navigationController.dataSequenceFileName = @"Sequence";
    [rootViewController release];

	[_window addSubview:[_navigationController view]];
    [_window makeKeyAndVisible];
}

- (void)applicationWillTerminate:(UIApplication *)application 
{
}

#pragma mark -
#pragma mark Memory management

- (void)dealloc
{
	[_navigationController release];
	[_window release];
	[super dealloc];
}

#pragma mark -
#pragma mark AKOEasyTableViewControllerDelegate methods

- (void)easyTableViewController:(AKOEasyTableViewController *)controller 
                  didSelectItem:(id)item
{
    [_navigationController loadNextScreen];
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
