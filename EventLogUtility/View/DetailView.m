//
//  DetailView.m
//  EventLogUtility
//
//  Created by GordonXIn on 1/4/16.
//  Copyright © 2016 Sapphire. All rights reserved.
//

#import "DetailView.h"

@interface DetailTitleView ()
{
    NSAttributedString *_attributedTitle;
}

@end

@implementation DetailTitleView

@dynamic title;

-(instancetype)initWithFrame:(NSRect)frameRect
{
    return [self initWithFrame:frameRect title:@"" image:nil];
}

-(instancetype)initWithFrame:(NSRect)frameRect title:(NSString *)title
{
    return [self initWithFrame:frameRect title:title image:nil];
}

-(instancetype)initWithFrame:(NSRect)frameRect title:(NSString *)title image:(NSImage *)image
{
    if (self = [super initWithFrame:frameRect])
    {
        [self setTitle:title];
        [self setImage:image];
        [self setHeight:25.0f];
    }
    return self;
}

-(NSString *)title
{
    return [_attributedTitle string];
}

-(void)setTitle:(NSString *)title
{
    NSDictionary *dic = @{NSFontAttributeName:[NSFont boldSystemFontOfSize:11.50]};
    _attributedTitle = [[NSAttributedString alloc] initWithString:title
                                                       attributes:dic];
    [self setNeedsDisplay:YES];
}

-(void)setImage:(NSImage *)image
{
    if (image)
    {
        _image = [image copy];
        [self setNeedsDisplay:YES];
    }
}

-(void)enableMouse
{
    if ([self target] && [self action])
    {
        if ([[self target] respondsToSelector:[self action]])
        {
            [self setTrackingOption:NSTrackingActiveAlways | NSTrackingInVisibleRect];
            [self setHasMouseTracking:YES];
        }
    }
}

-(void)setTarget:(id)target
{
    _target = target;
    
    if (_target)
    {
        [self enableMouse];
    }
    else
    {
        [self setHasMouseTracking:NO];
    }
}

-(void)setAction:(SEL)action
{
    _action = action;
    if (_action)
    {
        [self enableMouse];
    }
    else
    {
        [self setHasMouseTracking:NO];
    }
}

-(void)drawRect:(NSRect)dirtyRect
{
    [super drawRect:dirtyRect];
    
    if (_image)
    {
        CGFloat min    = (self.bounds.size.height < self.bounds.size.width) ? self.bounds.size.height : self.bounds.size.width;
        CGFloat length = min * 0.4f;
        NSRect  rect   = NSMakeRect(15.0f,
                                    (self.bounds.size.height - length) / 2,
                                    length,
                                    length);
        [_image drawInRect:rect];
    }
    
    if ([_attributedTitle length])
    {
        NSSize  size   = [_attributedTitle size];
        NSPoint origin = NSMakePoint(25.0f,
                                     (self.bounds.size.height - size.height)/2);
        [_attributedTitle drawAtPoint:origin];
    }
}

+(CGFloat)height
{
    return 25.0f;
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

-(void)mouseUp:(NSEvent *)theEvent
{
    [super mouseUp:theEvent];
    
    if ([self target] && [self action])
    {
        if ([[self target] respondsToSelector:[self action]])
        {
            [[self target] performSelector:[self action] withObject:self];
        }
    }
}
#pragma clang diagnostic pop

@end

@interface DetailView ()

@property (nonatomic, readwrite, strong) DetailTitleView *titleView;

@property (nonatomic, readwrite, strong) NSView *contentView;

@end

@implementation DetailView

-(instancetype)initWithFrame:(NSRect)frameRect contentView:(NSView *)contentView
{
    if (self  = [super initWithFrame:frameRect])
    {
        [self setHeight:NSHeight([contentView frame])];
        [contentView setFrame:NSMakeRect(0.0f, 0.0f, NSWidth(frameRect), NSHeight([[self contentView] frame]))];
        [contentView setAutoresizingMask:NSViewWidthSizable];
        [contentView setTranslatesAutoresizingMaskIntoConstraints:YES];
        [self addSubview:contentView];
        [self setContentView:contentView];
    }
    return self;
}

-(instancetype)initWithFrame:(NSRect)frameRect contentView:(NSView *)contentView title:(NSString *)title
{
    if (self = [super initWithFrame:frameRect])
    {
        DetailTitleView *titleView = [[DetailTitleView alloc] initWithFrame:frameRect title:title];
        
        [contentView setFrame:NSMakeRect(0.0f, 0.0f, NSWidth(frameRect), NSHeight([contentView frame]))];
        [contentView setAutoresizingMask:NSViewWidthSizable];
        [contentView setTranslatesAutoresizingMaskIntoConstraints:YES];
        [self addSubview:contentView];
        [self setContentView:contentView];
        NSLog(@"x=%f y=%f width=%f, height=%f", contentView.frame.origin.x, contentView.frame.origin.y, contentView.frame.size.width, contentView.frame.size.height);
        
        [titleView setFrame:NSMakeRect(0.0f, NSMaxY([contentView frame]), NSWidth(frameRect), [DetailTitleView height])];
        [titleView setAutoresizingMask:NSViewWidthSizable];
        [titleView setTranslatesAutoresizingMaskIntoConstraints:YES];
        [self addSubview:titleView];
        [self setTitleView:titleView];
        NSLog(@"x=%f y=%f width=%f, height=%f", titleView.frame.origin.x, titleView.frame.origin.y, titleView.frame.size.width, titleView.frame.size.height);
        
        [self setHeight:NSHeight([titleView frame]) + NSHeight([contentView frame])];
        NSLog(@"x=%f y=%f width=%f, height=%f", self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
    }
    return self;
}

-(void)setImage:(NSImage *)image
{
    if ([self titleView])
    {
        [[self titleView] setImage:image];
    }
}

- (void)drawRect:(NSRect)dirtyRect
{
    [super drawRect:dirtyRect];
}

-(void)contentViewRequestNewSize:(NSSize)newSize
{
    if ([self superview])
    {
        if ([[self superview] conformsToProtocol:@protocol(DetailContainerProtocol)])
        {
            newSize.height += NSHeight([[self titleView] frame]);
            [(id<DetailContainerProtocol>)[self superview] detailView:self requestNewSize:newSize];
        }
    }
}

-(void)sizeToFit
{
    CGFloat titleHeight = ([self titleView]) ? NSHeight([[self titleView] frame]) : 0.0f;
    NSRect frame = [[self contentView] frame];
    frame.size.height = NSHeight([self bounds]) - titleHeight;
    [[self contentView] setFrame:frame];
    if ([self titleView])
    {
        [[self titleView] setFrameOrigin:NSMakePoint(0.0f, NSMaxY([[self contentView] frame]))];
    }
}

@end

@interface ExpandableDetailView()

@end

@implementation ExpandableDetailView

-(instancetype)initWithFrame:(NSRect)frameRect contentView:(NSView *)contentView title:(NSString *)title expanded:(BOOL)expanded
{
    if (self = [super initWithFrame:frameRect contentView:contentView title:title])
    {
        [[self titleView] setImage:nil];
        [[self titleView] setTarget:self];
        _isExpanded = expanded;
        if (!_isExpanded)
        {
            CGFloat height = NSHeight([[self titleView] frame]);
            [self setFrameSize:NSMakeSize(NSWidth([self bounds]), height)];
            [[self contentView] setFrameOrigin:NSMakePoint(0.0f, 0.0f - NSHeight([[self contentView] frame]))];
            [[self titleView] setFrameOrigin:NSMakePoint(0.0f, 0.0f)];
        }
        
    }
    return self;
}

-(void)setIsExpanded:(BOOL)isExpanded
{
    if (_isExpanded == isExpanded)
    {
        return;
    }
    
    if ([self expandDelegate])
    {
        if ([[self expandDelegate] respondsToSelector:@selector(view:willExpand:)])
        {
            BOOL ret = [[self expandDelegate] view:self willExpand:isExpanded];
            if (!ret)
            {
                return;
            }
        }
    }
    
    _isExpanded = isExpanded;
    
    if (_isExpanded)
    {
        CGFloat height = NSHeight([[self titleView] frame]) + NSHeight([[self contentView] frame]);
        [self setFrameSize:NSMakeSize(NSWidth([self bounds]), height)];
        [[self contentView] setFrameOrigin:NSMakePoint(0.0f, 0.0f)];
        [[self titleView] setFrameOrigin:NSMakePoint(0.0f, NSMaxY([[self contentView] frame]))];
        [[self titleView] setImage:nil];
    }
    else
    {
        CGFloat height = NSHeight([[self titleView] frame]);
        [self setFrameSize:NSMakeSize(NSWidth([self bounds]), height)];
        [[self contentView] setFrameOrigin:NSMakePoint(0.0f, 0.0f - NSHeight([[self contentView] frame]))];
        [[self titleView] setFrameOrigin:NSMakePoint(0.0f, 0.0f)];
        [[self titleView] setImage:nil];
    }
    
    if ([self expandDelegate])
    {
        if ([[self expandDelegate] respondsToSelector:@selector(view:didExpand:)])
        {
            [[self expandDelegate] view:self willExpand:_isExpanded];
        }
    }
    
    if ([self superview])
    {
        if ([[self superview] conformsToProtocol:@protocol(DetailContainerProtocol)])
        {
            [(id<DetailContainerProtocol>)[self superview] relayout];
        }
    }
}

@end


@interface DetailContainerView () <DetailContainerProtocol>

@end

@implementation DetailContainerView

-(void)addDetailViewWithContent:(NSView *)aView
{
    DetailView *aDetail = [[DetailView alloc] initWithFrame:[self bounds]
                                                contentView:aView];
    [aDetail setAutoresizingMask:NSViewWidthSizable];
    [aDetail setTranslatesAutoresizingMaskIntoConstraints:YES];
    [self addSubview:aDetail];
    [self relayout];
}

-(void)addDetailViewWithContent:(NSView *)aView title:(NSString *)title
{
    DetailView *aDetail = [[DetailView alloc] initWithFrame:[self bounds]
                                                contentView:aView
                                                      title:title];
    [aDetail setAutoresizingMask:NSViewWidthSizable];
    [aDetail setTranslatesAutoresizingMaskIntoConstraints:YES];
    [self addSubview:aDetail];
    [self relayout];
}

-(void)addExpandableViewWithContetn:(NSView *)aView title:(NSString *)title expand:(BOOL)expand
{
    ExpandableDetailView *aDetail = [[ExpandableDetailView alloc] initWithFrame:[self bounds]
                                                                    contentView:aView
                                                                          title:title
                                                                       expanded:expand];
    [aDetail setAutoresizingMask:NSViewWidthSizable];
    [aDetail setTranslatesAutoresizingMaskIntoConstraints:YES];
    [self addSubview:aDetail];
    [self relayout];
}

-(void)relayout
{
    CGFloat yPosition = NSMaxY([self bounds]);
    for (DetailView *aView in [self subviews])
    {
        yPosition -= NSHeight([aView frame]);
        [aView setFrameOrigin:NSMakePoint(0.0f, yPosition)];
        NSLog(@"x=%f y=%f width=%f, height=%f", aView.frame.origin.x, aView.frame.origin.y, aView.frame.size.width, aView.frame.size.height);
    }
}

-(void)detailView:(DetailView *)detailView requestNewSize:(NSSize)newSize
{
    CGFloat diff = newSize.height - NSHeight([detailView frame]);
    CGFloat available = [[[self subviews] lastObject] frame].origin.y;
    
    diff = (diff > available) ? available : diff;
    [detailView setHeight:NSHeight([detailView frame]) + diff];
    [detailView sizeToFit];
    [self relayout];
}

@end
