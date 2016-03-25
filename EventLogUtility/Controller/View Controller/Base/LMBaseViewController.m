//
//  LMBaseViewController.m
//  EventLogUtility
//
//  Created by GordonXIn on 3/9/16.
//  Copyright © 2016 Sapphire. All rights reserved.
//

#import "LMBaseViewController.h"
#import "Document.h"
#import "DocumentController.h"

@interface LMBaseViewController ()
{
    NSMutableArray      *_subviewControllersArray;
}

@end

@implementation LMBaseViewController

@dynamic subviewControllerCount;
@dynamic subviewControllers;
@dynamic subviewControllerIdentifiers;

-(instancetype)init
{
    if (self = [super init])
    {
        [self baseViewControlerInit];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)coder
{
    if (self  = [super initWithCoder:coder])
    {
        [self baseViewControlerInit];
    }
    return self;
}

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
    {
        [self baseViewControlerInit];
    }
    return self;
}

-(void)baseViewControlerInit
{
    _subviewControllersArray = [NSMutableArray array];
}

#pragma mark -
#pragma mark        subview controller handlers
#pragma mark -

-(void)addSubviewController:(LMBaseViewController *)aController
{
    if (aController && ![_subviewControllersArray containsObject:aController])
    {
        [_subviewControllersArray addObject:aController];
    }
}

-(void)removeSubviewController:(LMBaseViewController *)aContoller
{
    if (aContoller && [_subviewControllersArray containsObject:aContoller])
    {
        [_subviewControllersArray removeObject:aContoller];
    }
}

-(void)removeSubviewControllerWithIdentifier:(NSString *)identifer
{
    LMBaseViewController *aController = [self subviewControllerWithIdentifier:identifer];
    [self removeSubviewController:aController];
}

-(LMBaseViewController *)subviewControllerWithIdentifier:(NSString *)identifier
{
    if ([identifier length])
    {
        for (LMBaseViewController *aController in _subviewControllersArray)
        {
            if (aController.identifier && [aController.identifier isEqualToString:identifier])
            {
                return aController;
            }
        }
    }
    return nil;
}

-(NSUInteger)subviewControllerCount
{
    return [_subviewControllersArray count];
}

-(NSArray *)subviewControllers
{
    return [NSArray arrayWithArray:_subviewControllersArray];
}

-(NSArray *)subviewControllerIdentifiers
{
    NSMutableArray *ary = [NSMutableArray array];
    
    for (LMBaseViewController *aController in _subviewControllersArray)
    {
        if (aController.identifier && aController.identifier.length)
        {
            [ary addObject:[aController identifier]];
        }
    }
    return [NSArray arrayWithArray:ary];
}


#pragma mark -
#pragma mark        view behaviour
#pragma mark -

-(void)loadViewForDocument:(NSDocument *)document;
{
    _document = document;
    
    for (LMBaseViewController *aController in _subviewControllersArray)
    {
        [aController loadViewForDocument:document];
    }
}

-(void)unloadView
{
    for (LMBaseViewController *aController in _subviewControllersArray)
    {
        [aController unloadView];
    }
    
    _subviewControllersArray = [NSMutableArray array];
    _document = nil;
}

#pragma mark -
#pragma mark        model accessing
#pragma mark -

-(id)documentForType:(Class)documentType
{
    if ([_document isKindOfClass:documentType])
    {
        return _document;
    }
    return nil;
}

@end
