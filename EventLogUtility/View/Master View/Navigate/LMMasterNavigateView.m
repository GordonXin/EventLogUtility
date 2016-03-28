//
//  LMMasterNavigateView.m
//  EventLogUtility
//
//  Created by cynthia on 3/28/16.
//  Copyright © 2016 Sapphire. All rights reserved.
//

#import "LMMasterNavigateView.h"
#import "LMConstant.h"

@interface LMMasterNavigateButton ()

@property (nonatomic, readwrite, strong) NSImage *buttonImage;

@property (nonatomic, readwrite, assign) SEL      buttonAction;

@property (nonatomic, readwrite, weak)   id       buttonTarget;

@property (nonatomic, readwrite, assign) BOOL     isSelected;

@end

@implementation LMMasterNavigateButton

-(instancetype)initWithName:(NSString *)buttonName image:(NSString *)buttonImage action:(SEL)action target:(id)target
{
    if (self = [self initWithName:buttonName
                            image:buttonImage
                           action:action
                           target:target
                    imagePosition:NSImageOnly])
    {
    
    }
    return self;
}

-(instancetype)initWithName:(NSString *)buttonName
                      image:(NSString *)buttonImage
                     action:(SEL)action
                     target:(id)target
              imagePosition:(NSCellImagePosition)imagePositon
{
    if (self = [super initWithFrame:NSZeroRect])
    {
        [self setButtonType:NSMomentaryPushInButton];
        [self setBezelStyle:NSShadowlessSquareBezelStyle];
        [self setState:NSOffState];
        [self setBordered:NO];
        [self setTitle:buttonName];
        [self setImagePosition:imagePositon];
        [(NSButtonCell*)self.cell setImageScaling:NSImageScaleProportionallyUpOrDown];
        
        _isSelected = NO;
        _buttonAction = action;
        _buttonTarget = target;
        _buttonImage = [NSImage imageNamed:buttonImage];
        
        [self setImage:self.buttonImage];
    }
    return self;
}

-(void)setIsSelected:(BOOL)isSelected
{
    if (_isSelected != isSelected)
    {
        if (isSelected)
        {
            if (self.buttonImage)
            {
                NSImage *newImage = [self.buttonImage copy];
                
                [newImage lockFocus];
                
                [[[NSColor blueColor] colorWithAlphaComponent:1.0f] set];
                
                NSRectFillUsingOperation(NSMakeRect(0, 0, newImage.size.width, newImage.size.height), NSCompositeSourceAtop);
                
                [newImage unlockFocus];
                
                [self setImage:newImage];
            }
        }
        else
        {
            if (self.buttonImage)
            {
                [self setImage:self.buttonImage];
            }
        }
        
        _isSelected = isSelected;
    }
}

@end


@interface LMMasterNavigateView ()
{
    NSArray *_buttonArray;
}

@end

@implementation LMMasterNavigateView

-(void)awakeFromNib
{
    _orientation = NSTextLayoutOrientationHorizontal;
}

-(void)setButtons:(NSArray *)buttonArray
{
    _buttonArray = [NSArray arrayWithArray:buttonArray];
    
    for (LMMasterNavigateButton *aButton in _buttonArray)
    {
        [self addSubview:aButton];
        [aButton setTarget:self];
        [aButton setAction:@selector(navigateButtonClicked:)];
    }
    
    if (_buttonArray.count > 0)
    {
        LMMasterNavigateButton *aButton = [_buttonArray objectAtIndex:0];
        [aButton setIsSelected:YES];
    }
    
    [self setNeedsDisplay:YES];
}

-(NSString *)currentSelected
{
    for (LMMasterNavigateButton *aButton in _buttonArray)
    {
        if ([aButton isSelected])
        {
            return [aButton title];
        }
    }
    
    if (_buttonArray.count)
    {
        LMMasterNavigateButton *aButton = [_buttonArray objectAtIndex:0];
        [aButton setIsSelected:YES];
        return aButton.title;
    }
    return @"";
}

-(void)clearSelection
{
    for (LMMasterNavigateButton *aButton in _buttonArray)
    {
        [aButton setIsSelected:NO];
    }
}

-(IBAction)navigateButtonClicked:(id)sender
{
    if ([sender isKindOfClass:[LMMasterNavigateButton class]])
    {
        [self clearSelection];
        
        LMMasterNavigateButton *aButton = (LMMasterNavigateButton *)sender;
        if (aButton.buttonTarget && aButton.buttonAction)
        {
            [aButton.buttonTarget performSelectorOnMainThread:aButton.buttonAction
                                                   withObject:aButton
                                                waitUntilDone:NO];
        }
        
        [aButton setIsSelected:YES];
    }
}
-(void)resizeSubviewsWithOldSize:(NSSize)oldSize
{
    [super resizeSubviewsWithOldSize:oldSize];
    
    if (_buttonArray.count <= 0)
    {
        return;
    }
    
    NSRect dirtyRect = [self bounds];
    CGFloat width = NSWidth(dirtyRect);
    CGFloat height = NSHeight(dirtyRect);
    
    if (_orientation == NSTextLayoutOrientationHorizontal)
    {
        CGFloat size = ceilf(height * 15 / 35);
        CGFloat y = ceilf(NSMinY(dirtyRect) + (height - size) / 2);
        CGFloat offset = size;
        CGFloat start = ceilf((width - size * _buttonArray.count - offset * _buttonArray.count + offset) / 2);
        
        for (NSInteger i = 0; i < _buttonArray.count; ++i)
        {
            LMMasterNavigateButton *aButton = [_buttonArray objectAtIndex:i];
            [aButton setFrame:NSMakeRect(start, y, size, size)];
                        
            start += size + offset;
        }
    }
    else
    {
        CGFloat size = ceilf(width * 15 / 35);
        CGFloat x = ceilf(NSMinX(dirtyRect) + (width - size) / 2);
        CGFloat offset = size;
        CGFloat start = ceilf((height - size * _buttonArray.count - offset * _buttonArray.count + offset) / 2);
        
        for (NSInteger i = 0; i < _buttonArray.count; ++i)
        {
            LMMasterNavigateButton *aButton = [_buttonArray objectAtIndex:i];
            [aButton setFrame:NSMakeRect(x, start, size, size)];
            
            start += size + offset;
        }
        
    }
}

-(void)drawRect:(NSRect)dirtyRect
{
    [super drawRect:dirtyRect];
}

@end
