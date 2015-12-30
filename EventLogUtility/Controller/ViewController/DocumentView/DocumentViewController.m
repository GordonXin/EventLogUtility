//
//  DocumentViewController.m
//  EventLogUtility
//
//  Created by GordonXIn on 12/30/15.
//  Copyright © 2015 Sapphire. All rights reserved.
//

#import "DocumentViewController.h"

@interface DocumentViewController () <NavigateDelegate>

@property (weak) IBOutlet NSView *masterView;

@property (weak) IBOutlet NSView *contentView;

@property (weak) IBOutlet NSView *statusView;

@end

@implementation DocumentViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)navigateController:(BaseViewController *)aController
                didSelect:(NSString *)name
{

}

@end
