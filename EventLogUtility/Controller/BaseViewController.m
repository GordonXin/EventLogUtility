//
//  BaseViewController.m
//  EventLogUtility
//
//  Created by GordonXIn on 12/30/15.
//  Copyright © 2015 Sapphire. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()
{
    NSMutableArray      *_arySubviewControllers;
    BOOL                 _isDealloced;
}

@end

@implementation BaseViewController

@dynamic subviewControllers;
@dynamic subViewControllerIdentifers;

#pragma mark init methods

-(instancetype)init
{
    if (self = [super init])
    {
        [self baseInitInner];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)coder
{
    if (self = [super initWithCoder:coder])
    {
        [self baseInitInner];
    }
    return self;
}

-(instancetype)initWithNibName:(NSString *)nibNameOrNil
                        bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
    {
        [self baseInitInner];
    }
    return self;
}

-(void)baseInitInner
{
    _arySubviewControllers = [NSMutableArray array];
    _isDealloced = NO;
}

#pragma mark over ride methods
- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)viewWillAppear
{
    [super viewWillDisappear];
}

-(void)viewDidAppear
{
    [super viewDidAppear];
}

-(void)viewWillLayout
{
    [super viewWillLayout];
}

-(void)viewDidLayout
{
    [super viewDidLayout];
}

-(void)viewWillDisappear
{
    [super viewWillDisappear];
}

-(void)viewDidDisappear
{
    [super viewDidDisappear];
}

-(void)dealloc
{
    if (!_isDealloced)
    {
        [self prepareDealloc];
        _isDealloced = NO;
    }
}

-(void)awakeFromNib
{
    [super awakeFromNib];
}

-(void)prepareDealloc
{
    
}

-(void)awakeFromDocument:(Document *)document
{
    if (!document)
    {
        return;
    }
    
    [self setDocument:document];
}

-(NSString *)identifier
{
    if ([[super identifier] length])
    {
        return [super identifier];
    }
    
    return NSStringFromClass([self class]);
}

#pragma mark subview controllers methods
-(void)addSubviewController:(BaseViewController *)aController
{
    if (!aController)
    {
        return;
    }
    if (![[aController identifier] length])
    {
        return;
    }
    [aController setSuperViewController:self];
    [_arySubviewControllers addObject:aController];
}

-(void)addSubviewController:(BaseViewController *)aController
             withIdentifier:(NSString *)aIdentifier
{
    if (!aController)
    {
        return;
    }
    if (![aIdentifier length])
    {
        return;
    }
    [aController setSuperViewController:self];
    [aController setIdentifier:aIdentifier];
    [_arySubviewControllers addObject:aController];
}

-(NSArray *)subviewControllers
{
    return [NSArray arrayWithArray:_arySubviewControllers];
}

-(NSArray *)subviewControllerIdentifiers
{
    NSMutableArray *ary = [NSMutableArray arrayWithCapacity:[_arySubviewControllers count]];
    for (NSViewController *aController in _arySubviewControllers)
    {
        [ary addObject:[aController identifier]];
    }
    return [NSArray arrayWithArray:ary];
}

-(BaseViewController *)subviewControllerWithIdentifier:(NSString *)aIdentifier
{
    if ([aIdentifier length])
    {
        for (NSViewController *aController in _arySubviewControllers)
        {
            if ([[aController identifier] isEqualToString:aIdentifier])
            {
                return (BaseViewController *)aController;
            }
        }
    }
    return nil;
}

-(BaseViewController *)subviewControllerAtIndex:(NSUInteger)index
{
    if (index < [_arySubviewControllers count])
    {
        return [_arySubviewControllers objectAtIndex:index];
    }
    return nil;
}

-(void)removeSubviewController:(BaseViewController *)aController
{
    if (!aController)
    {
        return;
    }
    if (![_arySubviewControllers containsObject:aController])
    {
        return;
    }
    [aController setSuperViewController:nil];
    [aController setDocument:nil];
    [_arySubviewControllers removeObject:aController];
}

-(void)removeAllSubviewControllers
{
    NSArray *array = [self subviewControllers];
    
    for (BaseViewController * aController in array)
    {
        [self removeSubviewController:aController];
    }
}

#pragma mark data

@end

@implementation NavigateBaseViewController

@end