//
//  LMDocumentViewController.m
//  EventLogUtility
//
//  Created by cynthia on 3/24/16.
//  Copyright © 2016 Sapphire. All rights reserved.
//

#import "LMDocumentViewController.h"
#import "LMBaseView.h"
#import "LMFileDisplayViewController.h"
#import "LMSplitView.h"

@interface LMDocumentViewController ()

@property (nonatomic, readwrite, weak) IBOutlet LMFileDisplayViewController *fileDisplayController;

@property (nonatomic, readwrite, weak) IBOutlet LMSplitView *splitView;

@end

@implementation LMDocumentViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.splitView setDividerThicknessIfCollapsed:30.0f];
    [self.splitView setDividerImageIfCollapsed:[NSImage imageNamed:@"SplitViewDivider"]];
}

-(void)loadViewForDocument:(NSDocument *)document
{
    [super loadViewForDocument:document];
    
    [self.fileDisplayController loadViewForDocument:document];
}

-(void)unloadView
{
    [super unloadView];
}

#pragma mark -
#pragma mark        splive view delegate
#pragma mark -

-(CGFloat)splitView:(NSSplitView *)splitView constrainMaxCoordinate:(CGFloat)proposedMaximumPosition ofSubviewAt:(NSInteger)dividerIndex
{
    CGFloat constrainedCoordinate = proposedMaximumPosition;
    if (dividerIndex == 0)
    {
        constrainedCoordinate = proposedMaximumPosition - 100.0f;
    }
    return constrainedCoordinate;
}

-(CGFloat)splitView:(NSSplitView *)splitView constrainMinCoordinate:(CGFloat)proposedMinimumPosition ofSubviewAt:(NSInteger)dividerIndex
{
    CGFloat constrainedCoordinate = proposedMinimumPosition;
    if (dividerIndex == 0)
    {
        constrainedCoordinate = proposedMinimumPosition + 100.0f;
    }
    return constrainedCoordinate;
}

-(BOOL)splitView:(NSSplitView *)splitView canCollapseSubview:(NSView *)subview
{
    return YES;
}

@end
