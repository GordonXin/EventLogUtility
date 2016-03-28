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
    
    
}

-(void)loadViewForDocument:(NSDocument *)document
{
    [super loadViewForDocument:document];
    
    
}

@end
