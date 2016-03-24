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

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)loadViewForDocument:(NSString *)documentUUID
{
    [super loadViewForDocument:documentUUID];
    
    LMFileStorage *aStorage = [[LMFileStorageManager sharedManager] fileStorageWithUUID:documentUUID];
    if (aStorage == nil)
        return;
    
    NSTextStorage *textStorage = aStorage.textStorage;
    if (textStorage == nil)
        return;
    
    [_textView.layoutManager setTextStorage:textStorage];
    //[_textView.layoutManager replaceTextStorage:textStorage];
}

-(void)unloadText
{
    NSTextStorage *textStorage = [[NSTextStorage alloc] initWithString:@""];
    [_textView.layoutManager replaceTextStorage:textStorage];
}

@end
