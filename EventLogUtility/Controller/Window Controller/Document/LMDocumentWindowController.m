//
//  LMDocumentWindowController.m
//  EventLogUtility
//
//  Created by GordonXIn on 3/9/16.
//  Copyright © 2016 Sapphire. All rights reserved.
//

#import "LMDocumentWindowController.h"
#import "Document.h"

@interface LMDocumentWindowController ()

@property (nonatomic, readwrite, weak) IBOutlet NSView *masterView;
@property (nonatomic, readwrite, weak) IBOutlet NSView *contentView;
@property (nonatomic, readwrite, weak) IBOutlet NSView *statusView;
@property (nonatomic, readwrite, weak) IBOutlet NSSplitView *splitView;

@end

@implementation LMDocumentWindowController

#pragma mark -
#pragma mark        super overide methods
#pragma mark -
- (void)windowDidLoad
{
    [super windowDidLoad];
    //initialize uuid with a radom value
    _documentUUID = [[NSUUID UUID] UUIDString];
}

-(NSString *)windowNibName
{
    return @"DocumentWindow";
}

#pragma mark -
#pragma mark        custom loading
#pragma mark -
-(void)loadForDocument:(NSString *)uuid
{
    _documentUUID = [uuid copy];
    
    Document *doc = nil;
    
    
}

@end
