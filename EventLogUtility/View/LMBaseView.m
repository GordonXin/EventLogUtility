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
#pragma mark        view size
#pragma mark -

-(CGFloat)minHeight
{
    return 0.0f;
}

-(CGFloat)minWidth
{
    CGFloat min = 0.0f;
    
    for (NSView *aView in self.subviews)
    {
        if ([aView isKindOfClass:[LMBaseView class]])
        {
            CGFloat new = [(LMBaseView *)aView minWidth];
            if (new > min)
            {
                min = new;
            }
        }
    }
    
    return min;
}

@end
