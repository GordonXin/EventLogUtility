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

- (void)initView
{
    [_scrollView setHasHorizontalScroller:YES];
    [_scrollView setHasVerticalScroller:YES];
    
    [_textView setVerticallyResizable:YES];
    [_textView setHorizontallyResizable:YES];
    //[_textView setMaxSize:NSMakeSize(CGFLOAT_MAX, CGFLOAT_MAX)];
    
    [_textView.textContainer setWidthTracksTextView:NO];
    [_textView.textContainer setSize:NSMakeSize(CGFLOAT_MAX, CGFLOAT_MAX)];
}

-(void)loadViewForDocument:(NSString *)documentUUID
{
    [super loadViewForDocument:documentUUID];
    
    [self initView];
    
    LMFileStorage *aStorage = [[LMFileStorageManager sharedManager] fileStorageWithUUID:documentUUID];
    if (aStorage == nil)
        return;
    
    NSTextStorage *textStorage = aStorage.textStorage;
    if (textStorage == nil)
        return;
    
    [_textView.layoutManager replaceTextStorage:textStorage];
}

-(void)unloadView
{
    NSTextStorage *textStorage = [[NSTextStorage alloc] initWithString:@""];
    [_textView.layoutManager replaceTextStorage:textStorage];
}

@end
