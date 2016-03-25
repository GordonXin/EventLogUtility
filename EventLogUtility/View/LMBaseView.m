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

@end
