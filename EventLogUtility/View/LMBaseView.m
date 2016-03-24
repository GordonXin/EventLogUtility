//
//  LMBaseView.m
//  EventLogUtility
//
//  Created by cynthia on 3/24/16.
//  Copyright © 2016 Sapphire. All rights reserved.
//

#import "LMBaseView.h"

@interface LMBaseView ()
{
    NSMutableArray *_subviewControllers;
}

@end

@implementation LMBaseView

#pragma mark -
#pragma mark        subview management
#pragma mark -

-(NSView *)viewWithIdentifier:(NSString *)identifier
{
    if (identifier && identifier.length > 0)
    {
        for (NSView *aView in self.subviews)
        {
            if (aView && aView.identifier && [aView.identifier isEqualToString:identifier])
            {
                return aView;
            }
        }
    }
    return nil;
}


#pragma mark -
#pragma mark        subviewController management
#pragma mark -

-(void)initSubviewControllerArray
{
    if (_subviewControllers == nil)
    {
        _subviewControllers = [NSMutableArray array];
    }
}

-(void)addSubviewController:(LMBaseViewController *)aController
{
    [self initSubviewControllerArray];
    
    if ([_subviewControllers containsObject:aController] == NO)
    {
        [_subviewControllers addObject:aController];
    }
}

-(NSArray *)subviewControllers
{
    [self initSubviewControllerArray];
    
    return [NSArray arrayWithArray:_subviewControllers];
}

-(LMBaseViewController *)firstViewController
{
    [self initSubviewControllerArray];
    
    if (_subviewControllers.count > 0)
    {
        return [_subviewControllers objectAtIndex:0];
    }
    return nil;
}

@end
