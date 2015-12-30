//
//  MasterViewController.m
//  EventLogUtility
//
//  Created by GordonXIn on 12/30/15.
//  Copyright © 2015 Sapphire. All rights reserved.
//

#import "MasterViewController.h"
#import "BaseView.h"

NSString * const kFileListIdentifier = @"FileListController";
NSString * const kSearchIdentifier = @"SearchController";
NSString * const kResultIdentifier = @"ResultController";

@interface MasterNavigateViewController : BaseViewController

@property (weak) IBOutlet id<NavigateDelegate> delegate;

@end

@implementation MasterNavigateViewController

-(void)viewDidLoad
{
    if ([[self view] isKindOfClass:[BaseView class]])
    {
        [(BaseView *)[self view] setHasBottomBorder:YES];
    }
}

- (IBAction)userClickButton:(id)sender
{
    if (!sender)
    {
        return;
    }
    if (![sender identifier])
    {
        return;
    }
    if ([self delegate])
    {
        [[self delegate] navigateController:self didSelect:[sender identifier]];
    }
}


@end

@interface MasterViewController () <NavigateDelegate>

@property (strong) IBOutlet MasterNavigateViewController *navigateViewController;

@property (strong) IBOutlet BaseView *presentView;

@end

@implementation MasterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    BaseViewController *aController = [self subviewControllerWithIdentifier:kFileListIdentifier];
    if (aController)
    {
        
    }
    
    [self navigateController:[self navigateViewController] didSelect:kFileListIdentifier];
}

-(void)awakeFromDocument:(Document *)document
{
    [super awakeFromDocument:document];
    
    for (BaseViewController *aController in [self subviewControllers])
    {
        [aController awakeFromDocument:document];
    }
}

-(void)navigateController:(BaseViewController *)aController
                didSelect:(NSString *)name
{
    if (![name length])
    {
        return;
    }
    if (!aController)
    {
        return;
    }
    if (![aController isEqualTo:[self navigateViewController]])
    {
        return;
    }
    if ([[[self presentView] subviews] count])
    {
        NSString *current = [[[[self presentView] subviews] objectAtIndex:0] identifier];
        if ([current isEqualToString:name])
        {
            return;
        }
        
        [[[self presentView] subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    BaseViewController *target = [self subviewControllerWithIdentifier:name];
    if (!target)
    {
        return;
    }
    [[target view] setIdentifier:name];
    [[target view] setFrame:[[self presentView] bounds]];
    [[target view] setAutoresizingMask:NSViewHeightSizable|NSViewWidthSizable];
    [[target view] setTranslatesAutoresizingMaskIntoConstraints:YES];
    [[self presentView] addSubview:[target view]];
}

@end
