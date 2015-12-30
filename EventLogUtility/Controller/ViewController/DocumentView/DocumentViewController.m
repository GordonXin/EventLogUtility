//
//  DocumentViewController.m
//  EventLogUtility
//
//  Created by GordonXIn on 12/30/15.
//  Copyright © 2015 Sapphire. All rights reserved.
//

#import "DocumentViewController.h"
#import "MasterViewController.h"

@interface DocumentViewController () <NavigateDelegate>

@property (weak) IBOutlet NSView *masterView;

@property (weak) IBOutlet NSView *contentView;

@property (weak) IBOutlet NSView *statusView;

@end

@implementation DocumentViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    BaseViewController *aController;
    aController = [[MasterViewController alloc] initWithNibName:nil bundle:nil];
    [[aController view] setAutoresizingMask:NSViewHeightSizable|NSViewWidthSizable];
    [[aController view] setTranslatesAutoresizingMaskIntoConstraints:YES];
    [[aController view] setFrame:[[self masterView] bounds]];
    [[self masterView] addSubview:[aController view]];
    [self addSubviewController:aController withIdentifier:@"Master"];
}

-(void)setNavigateController:(NavigateBaseViewController *)navigateController
{
    _navigateController = navigateController;
    [_navigateController setNavigateDelegate:self];
}

-(void)navigateController:(BaseViewController *)aController
                didSelect:(NSString *)name
{

}

@end
