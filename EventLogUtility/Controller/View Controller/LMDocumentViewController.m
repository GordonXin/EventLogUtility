//
//  LMDocumentViewController.m
//  EventLogUtility
//
//  Created by cynthia on 3/24/16.
//  Copyright © 2016 Sapphire. All rights reserved.
//

#import "LMDocumentViewController.h"
#import "LMSplitView.h"
#import "LMFileDisplayViewController.h"
#import "LMMasterViewController.h"
#import "LMBaseView.h"

static NSString * const kLMMasterViewKey = @"MasterView";
static NSString * const kLMContentViewKey = @"ContentView";
static NSString * const kLMStatusViewKey = @"StatusView";

@interface LMDocumentViewController ()

@property (nonatomic, readwrite, weak) IBOutlet NSView *masterView;

@property (nonatomic, readwrite, weak) IBOutlet NSView *contentView;

@property (nonatomic, readwrite, weak) IBOutlet NSView *statusView;

@property (nonatomic, readwrite, weak) IBOutlet LMSplitView *splitView;

@end

@implementation LMDocumentViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.masterView setIdentifier:kLMMasterViewKey];
    [self.contentView setIdentifier:kLMContentViewKey];
    [self.statusView setIdentifier:kLMStatusViewKey];
    
    [self.splitView setDividerThicknessIfCollapsed:30.0f];
    [self.splitView setDividerImageIfCollapsed:[NSImage imageNamed:@"SplitViewDivider"]];
    [self.splitView adjustSubviews];
    
    [self loadViewController:[[LMFileDisplayViewController alloc] initWithNibName:nil bundle:nil]
                      onView:self.contentView];
    
    [self loadViewController:[[LMMasterViewController alloc] initWithNibName:nil bundle:nil]
                      onView:self.masterView];
}

-(void)loadViewForDocument:(NSDocument *)document
{
    [super loadViewForDocument:document];
}

-(void)unloadView
{
    [super unloadView];
}

-(void)loadViewController:(LMBaseViewController *)aController onView:(NSView *)aView
{
    [aController.view setFrame:aView.bounds];
    [aController.view setAutoresizingMask:NSViewHeightSizable | NSViewWidthSizable];
    [aController.view setTranslatesAutoresizingMaskIntoConstraints:YES];
    
    [aController setIdentifier:[aView identifier]];
    
    [aView addSubview:aController.view];
    [self addSubviewController:aController];
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
