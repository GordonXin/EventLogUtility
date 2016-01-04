//
//  FileListViewController.m
//  EventLogUtility
//
//  Created by GordonXIn on 12/30/15.
//  Copyright © 2015 Sapphire. All rights reserved.
//

#import "FileListViewController.h"

@interface FileListItem : NSObject

@property (nonatomic, readwrite, copy) NSString *displayName;

@property (nonatomic, readonly, strong) NSMutableArray *children;

@property (nonatomic, readwrite, assign) BOOL isRoot;

@end

@implementation FileListItem

-(instancetype)init
{
    if (self = [super init])
    {
        _children = [NSMutableArray array];
        _isRoot = NO;
    }
    return self;
}

@end

@interface FileListTabelCellView : NSTableCellView
{
    NSTrackingArea  *_trackingArea;
}

@property (nonatomic, weak) IBOutlet NSButton *closeButton;

@end

@implementation FileListTabelCellView

-(instancetype)init
{
    if (self = [super init])
    {
        _trackingArea = [[NSTrackingArea alloc] initWithRect:[self bounds]
                                                     options:(NSTrackingActiveAlways | NSTrackingInVisibleRect | NSTrackingMouseEnteredAndExited)
                                                       owner:self
                                                    userInfo:nil];
        [self addTrackingArea:_trackingArea];
    }
    return self;
}

-(void)updateTrackingAreas
{
    [super updateTrackingAreas];
    [self removeTrackingArea:_trackingArea];
    
    _trackingArea = [[NSTrackingArea alloc] initWithRect:[self bounds]
                                                 options:(NSTrackingActiveAlways | NSTrackingInVisibleRect | NSTrackingMouseEnteredAndExited)
                                                   owner:self
                                                userInfo:nil];
    [self addTrackingArea:_trackingArea];

}

-(void)mouseEntered:(NSEvent *)theEvent
{
    if ([self objectValue])
    {
        if ([[self objectValue] isKindOfClass:[FileListItem class]])
        {
            FileListItem *item = (FileListItem *)[self objectValue];
            if ([item isRoot])
            {
                return;
            }
        }
    }
    if ([self closeButton])
    {
        if ([[self closeButton] isHidden])
        {
            [[self closeButton] setHidden:NO];
        }
    }
}

-(void)mouseExited:(NSEvent *)theEvent
{
    if ([self objectValue])
    {
        if ([[self objectValue] isKindOfClass:[FileListItem class]])
        {
            FileListItem *item = (FileListItem *)[self objectValue];
            if ([item isRoot])
            {
                return;
            }
        }
    }
    if ([self closeButton])
    {
        if (![[self closeButton] isHidden])
        {
            [[self closeButton] setHidden:YES];
        }
    }
}

@end


@interface FileListViewController () <NSOutlineViewDataSource, NSOutlineViewDelegate>
{
    FileListItem *_myItem;
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
    _myItem = nil;
}

-(void)awakeFromDocument:(Document *)document
{
    [super awakeFromDocument:document];
    
    [self simulateSomeData];
    
    [[self outlineView] reloadData];
    [[self outlineView] expandItem:nil expandChildren:YES];
}

-(void)simulateSomeData
{
    FileListItem *item = [[FileListItem alloc] init];
    [item setDisplayName:@"Original File"];
    [[item children] addObject:@"Search result 1"];
    [[item children] addObject:@"Search result 2"];
    [[item children] addObject:@"Search result 3"];
    [[item children] addObject:@"Search result 4"];
    [[item children] addObject:@"Search result 5"];
    [[item children] addObject:@"Search result 6"];
    [[item children] addObject:@"Search result 7"];
    [item setIsRoot:YES];
    
    _myItem = item;
}

-(NSInteger)outlineView:(NSOutlineView *)outlineView numberOfChildrenOfItem:(id)item
{
    if (!item)
    {
        return 1;
    }
    else if ([item isKindOfClass:[FileListItem class]])
    {
        return [[item children] count];
    }
    return 0;
}

-(id)outlineView:(NSOutlineView *)outlineView child:(NSInteger)index ofItem:(id)item
{
    if (!item)
    {
        return _myItem;
    }
    else if ([item isKindOfClass:[FileListItem class]])
    {
        return [[item children] objectAtIndex:index];
    }
    return nil;
}

- (BOOL)outlineView:(NSOutlineView*)outlineView isItemExpandable:(id)item
{
    if (!item)
    {
        return YES;
    }
    else if ([item isKindOfClass:[FileListItem class]])
    {
        return [[item children] count] > 0;
    }
    return NO;
}

-(id)outlineView:(NSOutlineView *)outlineView objectValueForTableColumn:(NSTableColumn *)tableColumn byItem:(id)item
{
    return item;
}

- (NSView*)outlineView:(NSOutlineView*)outlineView
    viewForTableColumn:(NSTableColumn*)tableColumn
                  item:(id)item
{
    NSTableCellView* tableCellView =
    [outlineView makeViewWithIdentifier:tableColumn.identifier owner:nil];
    
    if (!tableCellView)
    {
        tableCellView = [[FileListTabelCellView alloc] init];
        tableCellView.identifier = tableColumn.identifier;
    }
    if ([item isKindOfClass:[FileListItem class]])
    {
        tableCellView.textField.stringValue = [(FileListItem *)item displayName];
    }
    else if ([item isKindOfClass:[NSString class]])
    {
        tableCellView.textField.stringValue = (NSString *)item;
    }
    if ([tableCellView isKindOfClass:[FileListTabelCellView class]])
    {
        FileListTabelCellView *cell = (FileListTabelCellView *)tableCellView;
        [cell.closeButton setTarget:self];
        [cell.closeButton setAction:@selector(userClickCloseButton:)];
        [cell.closeButton setHidden:YES];
    }
    
    return tableCellView;
}

-(BOOL)outlineView:(NSOutlineView *)outlineView shouldSelectItem:(id)item
{
    NSString *name = nil;
    
    if (!item)
    {
        name = [_myItem displayName];
    }
    else if ([item isKindOfClass:[FileListItem class]])
    {
        name = [(FileListItem *)item displayName];
    }
    else if ([item isKindOfClass:[NSString class]])
    {
        name = (NSString *)item;
    }
    if (![name length])
    {
        return NO;
    }
    if ([self navigateDelegate])
    {
        if (![[self navigateDelegate] navigateController:self shouldSelect:name])
        {
            return NO;
        }
    }
    return YES;
}

-(void)outlineViewSelectionDidChange:(NSNotification *)notification
{
    if (![NSThread isMainThread])
    {
        [self performSelectorOnMainThread:_cmd withObject:notification waitUntilDone:NO];
    }
    
    NSInteger row = [[self outlineView] selectedRow];
    id item = [[self outlineView] itemAtRow:row];
    if (!item)
    {
        return;
    }
    NSString *name = nil;
    if ([item isKindOfClass:[FileListItem class]])
    {
        name = [(FileListItem *)item displayName];
    }
    else if ([item isKindOfClass:[NSString class]])
    {
        name = (NSString *)item;
    }
    if (![name length])
    {
        return;
    }
    if ([self navigateDelegate])
    {
        [[self navigateDelegate] navigateController:self didSelect:name];
    }
}

-(IBAction)userClickCloseButton:(id)sender
{
    NSInteger row = [[self outlineView] rowForView:sender];
    id item = [[self outlineView] itemAtRow:row];
    if (!item)
    {
        return;
    }
    NSString *name = nil;
    if ([item isKindOfClass:[FileListItem class]])
    {
        name = [item displayName];
    }
    else if ([item isKindOfClass:[NSString class]])
    {
        name = (NSString *)item;
    }
    if (![name length])
    {
        return;
    }
    
    if ([self navigateDelegate])
    {
        if ([[self navigateDelegate] respondsToSelector:@selector(navigateController:shouldClose:)])
        {
            BOOL ret = [[self navigateDelegate] navigateController:self shouldClose:name];
            if (!ret)
            {
                return;
            }
        }
    }
    
    [[_myItem children] removeObject:item];
    
    if ([self navigateDelegate])
    {
        if ([[self navigateDelegate] respondsToSelector:@selector(navigateController:didClose:)])
        {
            [[self navigateDelegate] navigateController:self didClose:name];
        }
    }
}

-(void)addItem:(id)item
{
    if (!item)
    {
        return;
    }
    
    if ([item isKindOfClass:[NSString class]])
    {
        [[_myItem children] addObject:item];
        [[self outlineView] reloadData];
        [[self outlineView] selectRowIndexes:[NSIndexSet indexSetWithIndex:[[_myItem children] count] + 1] byExtendingSelection:NO];
    }
}

@end
