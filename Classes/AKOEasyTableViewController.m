//
//  AKOEasyTableViewController.m
//  EasyTableView
//
//  Created by Adrian on 11/22/09.
//  Copyright 2009 akosma software. All rights reserved.
//

#import "AKOEasyTableViewController.h"

@interface AKOEasyTableViewController ()
- (id)objectAtIndexPath:(NSIndexPath *)indexPath;
@end


@implementation AKOEasyTableViewController

@synthesize delegate = _delegate;
@synthesize autoDeselect = _autoDeselect;
@synthesize accessoryType = _accessoryType;

@dynamic dataSource;
@dynamic rowHeight;
@dynamic dataSourceFileName;

#pragma mark -
#pragma mark Init and dealloc

- (id)initWithStyle:(UITableViewStyle)style 
{
    if (self = [super initWithStyle:style]) 
    {
        _dataSource = nil;
        _delegate = nil;
        _autoDeselect = NO;
        _hasSections = NO;
        _rowHeight = 44.0;
        _accessoryType = UITableViewCellAccessoryNone;
    }
    return self;
}

- (void)dealloc 
{
    _delegate = nil;
    [_dataSource release];
    [super dealloc];
}

#pragma mark -
#pragma mark Public properties

- (NSString *)dataSourceFileName
{
    return _dataSourceFileName;
}

- (void)setDataSourceFileName:(NSString *)newFileName
{
    [_dataSourceFileName release];
    _dataSourceFileName = [newFileName copy];
    NSString *path = [[NSBundle mainBundle] pathForResource:newFileName ofType:@"plist"];
    NSArray *data = [[NSArray alloc] initWithContentsOfFile:path];
    self.dataSource = data;
    [data release];
}

- (CGFloat)rowHeight
{
    return _rowHeight;
}

- (void)setRowHeight:(CGFloat)value
{
    _rowHeight = value;
    [self.tableView reloadData];
}

- (id)dataSource
{
    return _dataSource;
}

- (void)setDataSource:(id)object
{
    if (object != _dataSource)
    {
        [_dataSource release];
        _dataSource = [object retain];
        
        if ([_dataSource count] > 0)
        {
            id obj = [_dataSource objectAtIndex:0];
            _hasSections = [obj isKindOfClass:[NSDictionary class]];
        }
        [self.tableView reloadData];
    }
}

#pragma mark -
#pragma mark Public methods

- (void)deselectSelectedRow
{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)viewDidLoad 
{
    [super viewDidLoad];

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning 
{
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{
    if (_hasSections)
    {
        return [_dataSource count];
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
    if (_hasSections)
    {
        NSDictionary *dict = [_dataSource objectAtIndex:section];
        NSArray *values = [dict objectForKey:@"values"];
        return [values count];
    }
    return [_dataSource count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _rowHeight;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (_hasSections)
    {
        NSDictionary *dict = [_dataSource objectAtIndex:section];
        return [dict objectForKey:@"title"];
    }
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    id obj = [self objectAtIndexPath:indexPath];
    static NSString *CellIdentifier = @"AKOEasyTableViewControllerCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) 
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault 
                                       reuseIdentifier:CellIdentifier] autorelease];
    }
    cell.accessoryType = _accessoryType;
    cell.textLabel.text = [obj description];
    return cell;
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    id obj = [self objectAtIndexPath:indexPath];
    
    if ([_delegate respondsToSelector:@selector(easyTableViewController:didTapAccessoryForItem:)])
    {
        [_delegate easyTableViewController:self didTapAccessoryForItem:obj];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
    id obj = [self objectAtIndexPath:indexPath];
    
    if ([_delegate respondsToSelector:@selector(easyTableViewController:didSelectItem:)])
    {
        [_delegate easyTableViewController:self didSelectItem:obj];
    }
    
    if (_autoDeselect)
    {
        [self deselectSelectedRow];
    }
}

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath 
{
    if (editingStyle == UITableViewCellEditingStyleDelete) 
    {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) 
    {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath 
{
}
*/

#pragma mark -
#pragma mark Private methods

- (id)objectAtIndexPath:(NSIndexPath *)indexPath
{
    if (_hasSections)
    {
        NSDictionary *dict = [_dataSource objectAtIndex:indexPath.section];
        NSArray *values = [dict objectForKey:@"values"];
        return [values objectAtIndex:indexPath.row];
    }
    return [_dataSource objectAtIndex:indexPath.row];
}

@end
