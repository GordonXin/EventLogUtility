//
//  LMMasterViewController.m
//  EventLogUtility
//
//  Created by cynthia on 3/25/16.
//  Copyright © 2016 Sapphire. All rights reserved.
//

#import "LMMasterViewController.h"
#import "LMMasterNavigateView.h"
#import "LMMasterFileListViewController.h"
#import "LMConstant.h"

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
    
}

-(void)loadViewForDocument:(NSDocument *)document
{
    [super loadViewForDocument:document];
    
    
}

-(void)naviageButtonClicked:(id)sender
{

}

@end
