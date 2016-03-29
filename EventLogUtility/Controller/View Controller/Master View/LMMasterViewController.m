//
//  LMMasterViewController.m
//  EventLogUtility
//
//  Created by cynthia on 3/25/16.
//  Copyright © 2016 Sapphire. All rights reserved.
//

#import "LMConstant.h"
#import "LMMasterViewController.h"
#import "LMMasterNavigateView.h"
#import "LMMasterFileListViewController.h"

@interface LMMasterViewController ()

@property (nonatomic, readwrite, weak) IBOutlet LMMasterNavigateView *navigateView;

@property (nonatomic, readwrite, weak) IBOutlet LMBaseView *contentView;

@end

@implementation LMMasterViewController

-(NSString *)nibName
{
    return @"MasterView";
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //
    // set up navigate view
    //
    SEL action = @selector(naviageButtonClicked:);
    
    NSArray *buttonArray = @[
                             [[LMMasterNavigateButton alloc] initWithName:kLMMasterNavigateListActionKey
                                                                    image:@"MasterNavigateFile"
                                                                   action:action
                                                                   target:self],
                             [[LMMasterNavigateButton alloc] initWithName:kLMMasterNavigateSearchActionKey
                                                                    image:@"MasterNavigateSearch"
                                                                   action:action
                                                                   target:self],
                             [[LMMasterNavigateButton alloc] initWithName:kLMMasterNavigateResultActionKey
                                                                    image:@"MasterNavigateResult"
                                                                   action:action
                                                                   target:self],
                             ];
    [self.navigateView setButtons:buttonArray];
    
    //
    // set up file list view
    //
    LMMasterFileListViewController *aController = [[LMMasterFileListViewController alloc] initWithNibName:nil bundle:nil];
    [aController.view setFrame:self.contentView.bounds];
    [aController.view setAutoresizingMask:NSViewHeightSizable | NSViewWidthSizable];
    [aController.view setTranslatesAutoresizingMaskIntoConstraints:YES];
    [self.contentView addSubview:aController.view];
    [self addSubviewController:aController];
}

-(void)loadViewForDocument:(NSDocument *)document
{
    [super loadViewForDocument:document];
    
    
}

-(void)naviageButtonClicked:(id)sender
{

}

@end
