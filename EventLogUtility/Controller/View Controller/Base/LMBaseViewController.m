//
//  LMBaseViewController.m
//  EventLogUtility
//
//  Created by GordonXIn on 3/9/16.
//  Copyright © 2016 Sapphire. All rights reserved.
//

#import "LMBaseViewController.h"
#import "Document.h"

#pragma mark -
@interface LMBaseViewController ()
#pragma mark -
{
    NSMutableArray      *_subviewControllersArray;
}

@end

#pragma mark -
@implementation LMBaseViewController

@dynamic subviewControllerCount;
@dynamic subviewControllers;
@dynamic subviewControllerIdentifiers;
@dynamic document;
@dynamic contentController;

#pragma mark -
#pragma mark        init methods
#pragma mark -
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
    _superviewController = nil;
    _documentUuid = [[NSUUID UUID] UUIDString];
}

#pragma mark -
#pragma mark        view controller overide methods
#pragma mark -
- (void)viewDidLoad
{
    [super viewDidLoad];
}

#pragma mark -
#pragma mark        subview controller handlers
#pragma mark -
-(void)addSubviewController:(LMBaseViewController *)aController
{
    if (aController && [aController.identifier length] > 0 && ![_subviewControllersArray containsObject:aController])
    {
        [_subviewControllersArray addObject:aController];
        [aController setSuperviewController:self];
        [aController setDocumentUuid:_documentUuid];
    }
}

-(void)addSubviewController:(LMBaseViewController *)aController withIdentifier:(NSString *)identifier
{
    if (!aController || ![identifier length])
    {
        return;
    }
    [aController setIdentifier:identifier];
    [self addSubviewController:aController];
}

-(void)removeSubviewController:(LMBaseViewController *)aContoller
{
    if (aContoller && [_subviewControllersArray containsObject:aContoller])
    {
        [aContoller setSuperviewController:nil];
        [_subviewControllersArray removeObject:aContoller];
    }
}

-(void)removeSubviewControllerWithIdentifier:(NSString *)identifer
{
    LMBaseViewController *aController = [self subviewControllerWithIdentifier:identifer];
    [self removeSubviewController:aController];
    // reset the uuid to a random value after removed
    [aController setDocumentUuid:[[NSUUID UUID] UUIDString]];
}

-(void)removeSubviewControllerAtIndex:(NSUInteger)index
{
    LMBaseViewController *aController = [self subviewControllerAtIndex:index];
    [self removeSubviewController:aController];
}

-(LMBaseViewController *)subviewControllerAtIndex:(NSUInteger)index
{
    if (index < [_subviewControllersArray count])
    {
        return [_subviewControllersArray objectAtIndex:index];
    }
    return nil;
}

-(LMBaseViewController *)subviewControllerWithIdentifier:(NSString *)identifier
{
    if ([identifier length])
    {
        for (LMBaseViewController *aController in _subviewControllersArray)
        {
            if ([[aController identifier] isEqualToString:identifier])
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
        [ary addObject:[aController identifier]];
    }
    return [NSArray arrayWithArray:ary];
}

-(void)setDocumentUuid:(NSString *)documentUuid
{
    _documentUuid = [documentUuid copy];
    
    for (LMBaseViewController *aController in _subviewControllersArray)
    {
        [aController setDocumentUuid:documentUuid];
    }
}

#pragma mark -
#pragma mark        model accessing
#pragma mark -

-(id)document
{
    return nil;
}

-(id)contentController
{
    return nil;
}

@end
