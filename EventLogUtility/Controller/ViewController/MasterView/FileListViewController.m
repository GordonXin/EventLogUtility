//
//  FileListViewController.m
//  EventLogUtility
//
//  Created by GordonXIn on 12/30/15.
//  Copyright © 2015 Sapphire. All rights reserved.
//

#import "FileListViewController.h"

@interface FileListViewController () <NSOutlineViewDataSource, NSOutlineViewDelegate>
{
    NSArray *_myArray;
}

@property (strong) IBOutlet NSOutlineView *outlineView;

@end

@implementation FileListViewController

-(NSString *)nibName
{
    return @"FileListView";
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    _myArray = [NSArray array];
}

-(void)awakeFromDocument:(Document *)document
{
    [super awakeFromDocument:document];
    [self simulateSomeData];
    [[self outlineView] reloadData];
}

-(void)simulateSomeData
{
    NSMutableArray *array = [NSMutableArray array];
    
    [array addObject:@"Search result 1"];
    [array addObject:@"Search result 2"];
    [array addObject:@"Search result 3"];
    [array addObject:@"Search result 4"];
    [array addObject:@"Search result 5"];
    [array addObject:@"Search result 6"];
    [array addObject:@"Search result 7"];
    
    _myArray = [NSArray arrayWithArray:array];
}

-(NSInteger)outlineView:(NSOutlineView *)outlineView numberOfChildrenOfItem:(id)item
{
    if (!item)
    {
        return 1;
    }
    else if ([item isEqualToString:@""])
    {
        return [_myArray count];
    
    }
    
    return 0;
}

-(id)outlineView:(NSOutlineView *)outlineView child:(NSInteger)index ofItem:(id)item
{
    if (!item)
    {
        return @"";
    }
    else if ([item isEqualToString:@""])
    {
        return [_myArray objectAtIndex:index];
    
    }
    
    return nil;
}

- (BOOL)outlineView:(NSOutlineView*)outlineView isItemExpandable:(id)item
{
    return NO;
}

- (NSView*)outlineView:(NSOutlineView*)outlineView
    viewForTableColumn:(NSTableColumn*)tableColumn
                  item:(id)item
{
    NSTableCellView* tableCellView =
    [outlineView makeViewWithIdentifier:tableColumn.identifier owner:nil];
    
    if (!tableCellView) {
        tableCellView = [[NSTableCellView alloc] init];
        tableCellView.identifier = tableColumn.identifier;
    }
    
    tableCellView.textField.stringValue = (NSString*)item;
    
    return tableCellView;
}

@end
