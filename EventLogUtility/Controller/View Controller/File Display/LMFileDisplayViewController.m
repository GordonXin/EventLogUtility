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
    
    LMFileTextViewController *textController = [[LMFileTextViewController alloc] initWithNibName:nil bundle:nil];
    [textController loadViewForDocument:documentUUID];
    
    [self addTextController:textController];
    [self displayTextController:textController];
}

-(void)addTextController:(LMFileTextViewController *)aController;
{
    if (aController == nil)
    {
        return;
    }
    
    id exist = [self subviewControllerWithIdentifier:[aController identifier]];
    if (exist)
    {
        return;
    }
    
    [self addSubviewController:aController];
}

-(void)displayTextController:(LMFileTextViewController *)aController
{
    if (self.view.subviews.count)
    {
        for (NSView *aView in self.view.subviews)
        {
            [aView removeFromSuperview];
        }
    }
    
    if (aController == nil)
    {
        return;
    }
    
    [self.view addSubview:aController.view];
    
    [aController.view setFrame:self.view.bounds];
    [aController.view setAutoresizesSubviews:NSViewHeightSizable | NSViewWidthSizable];
    [aController.view setTranslatesAutoresizingMaskIntoConstraints:YES];
}


@end
