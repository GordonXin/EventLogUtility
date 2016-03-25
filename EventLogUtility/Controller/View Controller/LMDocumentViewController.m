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

@interface LMDocumentViewController ()

@property (nonatomic, readwrite, weak) IBOutlet LMBaseView *masterView;
@property (nonatomic, readwrite, weak) IBOutlet LMBaseView *contentView;
@property (nonatomic, readwrite, weak) IBOutlet LMBaseView *statusView;

@property (nonatomic, readwrite, weak) IBOutlet NSSplitView *splitView;

@end

@implementation LMDocumentViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
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

@end
