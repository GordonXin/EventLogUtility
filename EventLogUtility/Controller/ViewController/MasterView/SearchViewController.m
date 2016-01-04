//
//  SearchViewController.m
//  EventLogUtility
//
//  Created by GordonXIn on 1/4/16.
//  Copyright © 2016 Sapphire. All rights reserved.
//

#import "SearchViewController.h"
#import "DetailView.h"

@interface SearchOptionViewController ()

@property (weak) IBOutlet NSButton *cbxStartTime;

@property (weak) IBOutlet NSButton *cbxEndTime;

@property (weak) IBOutlet NSDatePicker *startTime;

@property (weak) IBOutlet NSDatePicker *endTime;

@property (weak) IBOutlet NSButton *cbxNewTab;

@property (weak) IBOutlet NSTextField *textTabName;

@end

@implementation SearchOptionViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [[self cbxStartTime] setState:NSOffState];
    [[self cbxEndTime] setState:NSOffState];
    [[self cbxNewTab] setState:NSOnState];
    [[self textTabName] setStringValue:@""];
}

@end


@interface SearchViewController ()

@property (strong) IBOutlet SearchOptionViewController *optionController;

@end

@implementation SearchViewController

-(NSString *)nibName
{
    return @"SearchView";
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    DetailContainerView *containerView = (DetailContainerView *)[self view];
    [containerView addDetailViewWithContent:[[self optionController] view] title:@"Option"];
    [self addSubviewController:[self optionController]];
    
    
    [[self view] setAutoresizesSubviews:YES];
}

@end
