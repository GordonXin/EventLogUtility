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

@property (nonatomic, readwrite, weak) IBOutlet LMBaseView *masterView;
@property (nonatomic, readwrite, weak) IBOutlet LMBaseView *contentView;
@property (nonatomic, readwrite, weak) IBOutlet LMBaseView *statusView;

@property (nonatomic, readwrite, weak) IBOutlet LMSplitView *splitView;

@end

@implementation LMDocumentViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.splitView setDividerStyle:NSSplitViewDividerStylePaneSplitter];
    
    [self loadConentView];
}

-(void)loadViewForDocument:(NSDocument *)document
{
    [super loadViewForDocument:document];
}

-(void)loadConentView
{
    // init file display
    LMBaseViewController *displayController = [[LMFileDisplayViewController alloc] initWithNibName:nil
                                                                                            bundle:nil];
    
    [displayController.view setFrame:self.contentView.bounds];
    [displayController.view setAutoresizingMask:NSViewHeightSizable | NSViewWidthSizable];
    [displayController.view setTranslatesAutoresizingMaskIntoConstraints:YES];
    
    [self.contentView addSubview:displayController.view];
    [self addSubviewController:displayController];
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
