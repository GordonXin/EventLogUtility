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

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)loadViewForDocument:(NSString *)documentUUID
{
    [super loadViewForDocument:documentUUID];
    
    // init file display
    LMBaseViewController *displayController = [[LMFileDisplayViewController alloc] initWithNibName:nil
                                                                                            bundle:nil];
    [self.contentView addSubviewController:displayController];

    [displayController.view setFrame:self.contentView.bounds];
    [displayController.view setAutoresizesSubviews:NSViewHeightSizable | NSViewWidthSizable];
    [displayController.view setTranslatesAutoresizingMaskIntoConstraints:YES];

    [self.contentView addSubview: displayController.view];
    
    [displayController loadViewForDocument:documentUUID];
}

@end
