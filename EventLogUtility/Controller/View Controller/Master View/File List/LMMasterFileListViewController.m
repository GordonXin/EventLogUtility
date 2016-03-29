//
//  LMMasterFileListViewController.m
//  EventLogUtility
//
//  Created by cynthia on 3/28/16.
//  Copyright © 2016 Sapphire. All rights reserved.
//

#import "LMMasterFileListViewController.h"
#import "LMMasterFileListTableRowView.h"
#import "LMColorUtlity.h"
#import "Document.h"
#import "LMFileStorage.h"
#import "LMFileStorageManager.h"


@interface LMMasterFileListViewController()

@property (nonatomic, readwrite, weak) IBOutlet NSScrollView *scrollView;

@property (nonatomic, readwrite, weak) IBOutlet NSTableView *tableView;

@end

@implementation LMMasterFileListViewController

-(NSString *)nibName
{
    return @"MasterFileListView";
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView setBackgroundColor:[LMColorUtlity commonBackgroundColor]];
}

-(void)loadViewForDocument:(NSDocument *)document
{
    [super loadViewForDocument:document];
    
    [self.tableView reloadData];
}

#pragma mark -
#pragma mark        Model for table view
#pragma mark -

-(NSInteger)fileStorageCount
{
    Document *doc = [self documentForType:[Document class]];
    if (doc)
    {
        return 1 + doc.fileStorageArray.count;
    }
    return 0;
}

-(NSString *)fileStorageUUIDAtIndex:(NSInteger)index
{
    Document *doc = [self documentForType:[Document class]];
    if (doc)
    {
        if (index == 0)
        {
            return [doc.documentUUID copy];
        }
        else
        {
            return [[doc.fileStorageArray objectAtIndex:index - 1] copy];
        }
    }
    return @"";
}

-(NSString *)fileStorageNameWithUUID:(NSString *)UUID
{
    if ([UUID length])
    {
        LMFileStorage *fileStorage = [[LMFileStorageManager sharedManager] fileStorageWithUUID:UUID];
        if (fileStorage)
        {
            return fileStorage.prettyName;
        }
        return UUID;
    }
    return @"unknown name";
}

-(NSString *)fileStorageNameAtIndex:(NSInteger)index
{
    NSString *UUID = [self fileStorageUUIDAtIndex:index];
    return [self fileStorageNameWithUUID:UUID];
}

#pragma mark -
#pragma mark        table view data source
#pragma mark -

// don't allow drop
-(BOOL)tableView:(NSTableView *)tableView
      acceptDrop:(id<NSDraggingInfo>)info
             row:(NSInteger)row
   dropOperation:(NSTableViewDropOperation)dropOperation
{
    return NO;
}

-(NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return [self fileStorageCount];
}

#pragma mark -
#pragma mark        table view delegate
#pragma mark -

-(BOOL)tableView:(NSTableView *)tableView isGroupRow:(NSInteger)row
{
    if (row == 0)
        return YES;
    
    return NO;
}

-(NSIndexSet *)tableView:(NSTableView *)tableView selectionIndexesForProposedSelection:(NSIndexSet *)proposedSelectionIndexes
{
    // only allow single line selection
    if (proposedSelectionIndexes.count)
    {
        return [[NSIndexSet alloc] initWithIndex:[proposedSelectionIndexes firstIndex]];
    }
    return proposedSelectionIndexes;
}

-(void)tableViewSelectionDidChange:(NSNotification *)notification
{
}

-(void)tableView:(NSTableView *)tableView
   didAddRowView:(NSTableRowView *)rowView
          forRow:(NSInteger)row
{

}

-(void)tableView:(NSTableView *)tableView
didRemoveRowView:(NSTableRowView *)rowView
          forRow:(NSInteger)row
{

}

-(CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row
{
    if (row == 0)
        return 30;
    
    return 25.0f;
}

-(NSTableRowView *)tableView:(NSTableView *)tableView rowViewForRow:(NSInteger)row
{
    return [[NSTableRowView alloc] initWithFrame:NSZeroRect];
}

-(NSView *)tableView:(NSTableView *)tableView
  viewForTableColumn:(NSTableColumn *)tableColumn
                 row:(NSInteger)row
{
    NSString *textString = [self fileStorageNameAtIndex:row];
    
    if (row == 0)
    {
        LMMasterFileListTableTitleView *cellView;
        cellView = [tableView makeViewWithIdentifier:@"TitleCell" owner:self];
        cellView.textField.textColor = [NSColor textColor];
        cellView.textField.stringValue = textString;
        return cellView;
    }
    else
    {
        LMMasterFileListTableTextView *cellView;
        cellView = [tableView makeViewWithIdentifier:@"TextCell" owner:self];
        cellView.textField.stringValue = textString;
        return cellView;
    }
    return nil;
}

-(IBAction)imageButtonClicked:(id)sender
{
    NSInteger row = [self.tableView rowForView:sender];
    
    [self.tableView removeRowsAtIndexes:[NSIndexSet indexSetWithIndex:row] withAnimation:NSTableViewAnimationEffectFade];
}

@end
