//
//  LMSplitView.m
//  EventLogUtility
//
//  Created by cynthia on 3/25/16.
//  Copyright © 2016 Sapphire. All rights reserved.
//

#import "LMSplitView.h"

@interface LMSplitView ()

@property (nonatomic, readwrite, strong) NSImage *dividerImage;

@end

@implementation LMSplitView

-(void)awakeFromNib
{
    _dividerImage = [NSImage imageNamed:@"SplitViewDivider"];
}

-(CGFloat)dividerThickness
{
    if (self.isVertical)
    {
        NSInteger collapsed = [self collapsedSubviewIndex];
        if (collapsed >=0)
        {
            return 30.0f;
        }
        else
        {
            return 20.0f;
        }
    }
    return [super dividerThickness];
}

-(void)drawDividerInRect:(NSRect)rect
{
    if (self.isVertical)
    {
        NSRect targetRect = NSMakeRect(0, 0, rect.size.width, rect.size.height);
        targetRect.origin.y -= (rect.size.height - self.dividerImage.size.height) / 2;
        targetRect.origin.x -= (rect.size.width - self.dividerImage.size.width) / 2;
        
        [self lockFocus];
        [self.dividerImage drawInRect:rect fromRect:targetRect operation:NSCompositeSourceOver fraction:1.0];
        [self unlockFocus];
    }
    else
    {
        [super drawDividerInRect:rect];
    }
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
