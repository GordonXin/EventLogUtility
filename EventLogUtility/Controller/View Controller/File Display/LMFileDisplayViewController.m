//
//  LMFileDisplayViewController.m
//  EventLogUtility
//
//  Created by cynthia on 3/24/16.
//  Copyright © 2016 Sapphire. All rights reserved.
//

#import "LMFileDisplayViewController.h"
#import "LMFileTextViewController.h"

@interface LMFileDisplayViewController()

@end

@implementation LMFileDisplayViewController

-(NSString *)nibName
{
    return @"FileDisplayViewController";
}

-(void)loadViewForDocument:(NSString *)documentUUID
{
    [super loadViewForDocument:documentUUID];
    
    LMFileTextViewController *textController = [self textControllerWithUUID:documentUUID];
    if (textController)
    {
        [self displayTextController:textController];
    }
}

-(LMFileTextViewController *)textControllerWithUUID:(NSString *)UUID
{
    LMFileTextViewController *textController = (LMFileTextViewController *)[self subviewControllerWithIdentifier:UUID];
    if (textController == nil)
    {
        textController = [[LMFileTextViewController alloc] initWithNibName:nil bundle:nil];
        [textController loadView];
        [textController loadViewForDocument:UUID];
        [self addSubviewController:textController];
    }
    return textController;
}

-(void)displayTextController:(LMFileTextViewController *)textController
{
    // remove all other views
    if (self.view.subviews.count)
    {
        for (NSView *aView in self.view.subviews)
        {
            [aView removeFromSuperview];
        }
    }
    
    if (textController == nil)
    {
        return;
    }
    
    [self.view addSubview:textController.view];
    
    [textController.view setFrame:self.view.bounds];
    [textController.view setAutoresizesSubviews:NSViewHeightSizable | NSViewWidthSizable];
    [textController.view setTranslatesAutoresizingMaskIntoConstraints:YES];
}


@end
