//
//  BaseView.m
//  EventLogUtility
//
//  Created by GordonXIn on 12/30/15.
//  Copyright © 2015 Sapphire. All rights reserved.
//

#import "BaseView.h"

@interface BaseView ()
{
    NSTrackingArea *_trackingArea;
}

@end

@implementation BaseView

#pragma mark initialization

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

-(instancetype)initWithFrame:(NSRect)frameRect
{
    if (self = [super initWithFrame:frameRect])
    {
        [self baseInitInner];
    }
    return self;
}

-(void)baseInitInner
{
    [self setBackgroundColor:nil];
    [self setBorderColor:nil];
    
    [self setHasLeftBorder:NO];
    [self setHasRightBorder:NO];
    [self setHasTopBorder:NO];
    [self setHasBottomBorder:NO];
    
    _trackingArea = nil;
    _trackingOption = 0;
    _hasMouseTracking = NO;
}

#pragma mark subview

-(NSView *)subviewWithIdentifier:(NSString *)identifier
{
    for (NSView *aView in [self subviews])
    {
        if ([[aView identifier] isEqualToString:identifier])
        {
            return aView;
        }
    }
    return nil;
}

-(void)removeSubview:(NSView *)aView
{
    if ([[self subviews] containsObject:aView])
    {
        [aView removeFromSuperview];
    }
}

-(void)removeallSubviews
{
    [[self subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
}

-(void)removeSubviewWithIdentifier:(NSString *)identifier
{
    NSView *aView = [self subviewWithIdentifier:identifier];
    if (aView)
    {
        [aView removeFromSuperview];
    }
}

-(NSArray *)subviewIdentifiers
{
    NSMutableArray *ary = [NSMutableArray array];
    for (NSView *aView in [self subviews])
    {
        [ary addObject:[aView identifier]];
    }
    return [NSArray arrayWithArray:ary];
}

#pragma mark tracking area

-(void)setHasMouseTracking:(BOOL)hasMouseTracking
{
    if (hasMouseTracking == _hasMouseTracking) return;
    
    int defaultOption = (NSTrackingActiveAlways | NSTrackingInVisibleRect | NSTrackingMouseEnteredAndExited);
    
    if (hasMouseTracking)
    {
        if (![self trackingOption])
        {
            [self setTrackingOption:defaultOption];
        }
        
        _trackingArea = [[NSTrackingArea alloc] initWithRect:[self bounds]
                                                     options:[self trackingOption]
                                                       owner:self
                                                    userInfo:nil];
        [self addTrackingArea:_trackingArea];
    }
    else
    {
        if (_trackingArea)
        {
            [self removeTrackingArea:_trackingArea];
            _trackingArea = nil;
        }
    }
    
    [self setHasMouseTracking:hasMouseTracking];
}

-(void)updateTrackingAreas
{
    [super updateTrackingAreas];
    
    if (_trackingArea)
    {
        [self removeTrackingArea:_trackingArea];
        _trackingArea = nil;
    }
    
    if ([self hasMouseTracking])
    {
        _trackingArea = [[NSTrackingArea alloc] initWithRect:[self bounds]
                                                     options:[self trackingOption]
                                                       owner:self
                                                    userInfo:nil];
        [self addTrackingArea:_trackingArea];
    }
}

#pragma mark draw

- (void)drawRect:(NSRect)dirtyRect
{
    [super drawRect:dirtyRect];
    
    NSColor *color = [self backgroundColor];
    if (!color)
    {
        
    }
    [color set];
    NSRectFill(dirtyRect);
    
    color = [self borderColor];
    if (!color)
    {
        
    }
    [color set];
    
    NSRect  bounds  = self.bounds;
    CGFloat bottomY = [self isFlipped] ? NSMaxY(bounds) : NSMinY(bounds);
    CGFloat topY    = [self isFlipped] ? NSMinY(bounds) : NSMaxY(bounds);
    CGFloat yOffset = [self isFlipped] ? -0.5           : 0.5;
    
    if ([self hasTopBorder])
    {
        NSBezierPath *topLine = [NSBezierPath bezierPathWithRect:NSMakeRect(NSMinX(bounds),
                                                                            topY - yOffset,
                                                                            NSWidth(bounds),
                                                                            0.0)];
        topLine.lineCapStyle = NSButtLineCapStyle;
        [topLine stroke];
    }
    if ([self hasBottomBorder])
    {
        NSBezierPath *BottomLine = [NSBezierPath bezierPathWithRect:NSMakeRect(NSMinX(bounds),
                                                                               bottomY + yOffset,
                                                                               NSWidth(bounds),
                                                                               0.0)];
        BottomLine.lineCapStyle = NSButtLineCapStyle;
        [BottomLine stroke];
    }
    if ([self hasLeftBorder])
    {
        NSBezierPath *leftLine = [NSBezierPath bezierPathWithRect:NSMakeRect(NSMinX(bounds) + 0.5,
                                                                             bottomY,
                                                                             0.0,
                                                                             NSHeight(bounds))];
        leftLine.lineCapStyle = NSButtLineCapStyle;
        [leftLine stroke];
    }
    if ([self hasRightBorder])
    {
        NSBezierPath *rightLine = [NSBezierPath bezierPathWithRect:NSMakeRect(NSMaxX(bounds) - 0.5,
                                                                              bottomY,
                                                                              0.0,
                                                                              NSHeight(bounds))];
        rightLine.lineCapStyle = NSButtLineCapStyle;
        [rightLine stroke];
    }
}

#pragma mark size

-(void)setHeight:(CGFloat)height
{
    NSSize size = self.bounds.size;
    size.height = height;
    [self setBoundsSize:size];
}

-(void)setWidth:(CGFloat)width
{
    NSSize size = self.bounds.size;
    size.width = width;
    [self setBoundsSize:size];
}

-(void)setFrameX:(CGFloat)x
{
    CGPoint origin = self.frame.origin;
    origin.x = x;
    [self setFrameOrigin:origin];
}
-(void)setFrameY:(CGFloat)y
{
    CGPoint origin = self.frame.origin;
    origin.y = y;
    [self setFrameOrigin:origin];
}

@end
