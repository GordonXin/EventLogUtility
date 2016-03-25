//
//  LMFileTextViewController.m
//  EventLogUtility
//
//  Created by cynthia on 3/24/16.
//  Copyright © 2016 Sapphire. All rights reserved.
//

#import "LMFileTextViewController.h"
#import "LMFileStorage.h"
#import "LMFileStorageManager.h"

@interface LMFileTextViewController ()

@end

@implementation LMFileTextViewController

-(NSString *)nibName
{
    return @"FileTextViewController";
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [_scrollView setHasHorizontalScroller:YES];
    [_scrollView setHasVerticalScroller:YES];
    
    [_textView setVerticallyResizable:YES];
    [_textView setHorizontallyResizable:YES];
    
    [_textView.textContainer setWidthTracksTextView:NO];
    [_textView.textContainer setSize:NSMakeSize(CGFLOAT_MAX, CGFLOAT_MAX)];
}

-(void)loadFileStorage:(NSString *)fileStorageUUID
{
    [self setIdentifier:fileStorageUUID];
    
    [[self.textView undoManager] disableUndoRegistration];
    
    LMFileStorage *aStorage = [[LMFileStorageManager sharedManager] fileStorageWithUUID:fileStorageUUID];
    if (aStorage && aStorage.textStorage)
    {
        [_textView.layoutManager replaceTextStorage:aStorage.textStorage];
    }
    
    [[self.textView undoManager] enableUndoRegistration];
}

-(void)unloadView
{
    [[self.textView undoManager] disableUndoRegistration];
    
    NSTextStorage *textStorage = [[NSTextStorage alloc] initWithString:@""];
    [_textView.layoutManager replaceTextStorage:textStorage];
    
    [[self.textView undoManager] enableUndoRegistration];
}

@end
