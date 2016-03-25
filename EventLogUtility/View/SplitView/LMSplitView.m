//
//  LMSplitView.m
//  EventLogUtility
//
//  Created by cynthia on 3/25/16.
//  Copyright © 2016 Sapphire. All rights reserved.
//

#import "LMSplitView.h"

@interface LMSplitView ()

@end

@implementation LMSplitView

-(CGFloat)dividerThickness
{
    if (self.dividerThicknessIfCollapsed > 0)
    {
        NSInteger collapsed = [self collapsedSubviewIndex];
        if (collapsed >= 0)
        {
            return self.dividerThicknessIfCollapsed;
        }
    }
    
    return [super dividerThickness];
}

-(void)drawDividerInRect:(NSRect)rect
{
    NSInteger collapsed = [self collapsedSubviewIndex];
    if (collapsed >= 0)
    {
        if (self.dividerImageIfCollapsed)
        {
            NSRect targetRect = NSMakeRect(0, 0, rect.size.width, rect.size.height);
            targetRect.origin.y -= (rect.size.height - self.dividerImageIfCollapsed.size.height) / 2;
            targetRect.origin.x -= (rect.size.width - self.dividerImageIfCollapsed.size.width) / 2;
            
            [self lockFocus];
            [self.dividerImageIfCollapsed drawInRect:rect fromRect:targetRect operation:NSCompositeSourceOver fraction:1.0];
            [self unlockFocus];
            
            return;
        }
    }
    
    [super drawDividerInRect:rect];
}

-(NSInteger)collapsedSubviewIndex
{
    for (NSInteger i = 0; i < self.subviews.count; ++i)
    {
        if ([self isSubviewCollapsed:[self.subviews objectAtIndex:i]])
        {
            return i;
        }
    }
    return -1;
}

@end
