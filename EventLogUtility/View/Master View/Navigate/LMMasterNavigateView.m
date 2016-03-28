//
//  LMMasterNavigateView.m
//  EventLogUtility
//
//  Created by cynthia on 3/28/16.
//  Copyright © 2016 Sapphire. All rights reserved.
//

#import "LMMasterNavigateView.h"
#import "LMConstant.h"

@interface LMMasterNavigateButton : NSButton

@property (nonatomic, readwrite, strong) NSImage *buttonImage;

@property (nonatomic, readwrite, assign) SEL      buttonAction;

@property (nonatomic, readwrite, weak) id         buttonTarget;

@property (nonatomic, readwrite, assign) BOOL     isSelected;

@end

@implementation LMMasterNavigateButton

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

@property (nonatomic, readwrite, weak) IBOutlet LMMasterNavigateButton *listButton;

@property (nonatomic, readwrite, weak) IBOutlet LMMasterNavigateButton *searchButton;

@property (nonatomic, readwrite, weak) IBOutlet LMMasterNavigateButton *resultButton;

@end

@implementation LMMasterNavigateView

-(void)awakeFromNib
{
    NSMutableArray *array = [NSMutableArray array];
    
    [self.listButton setIdentifier:kLMMasterNavigateListActionKey];
    [self.listButton setButtonImage:[NSImage imageNamed:@"MasterNavigateFile"]];
    [array addObject:self.listButton];
    
    [self.searchButton setIdentifier:kLMMasterNavigateSearchActionKey];
    [self.searchButton setButtonImage:[NSImage imageNamed:@"MasterNavigateSearch"]];
    [array addObject:self.searchButton];
    
    [self.resultButton setIdentifier:kLMMasterNavigateResultActionKey];
    [self.resultButton setButtonImage:[NSImage imageNamed:@"MasterNavigateResult"]];
    [array addObject:self.resultButton];
}

-(LMMasterNavigateButton *)buttonWithIdentifier:(NSString *)identifier
{
    for (LMMasterNavigateButton *aButton in _buttonArray)
    {
        if ([[aButton identifier] isEqualToString:identifier])
        {
            return aButton;
        }
    }
    
    return nil;
}

-(void)setAction:(SEL)action target:(id)target forKey:(NSString *)key
{
    LMMasterNavigateButton *aButton = [self buttonWithIdentifier:key];
    if (aButton)
    {
        [aButton setButtonAction:action];
        [aButton setButtonTarget:target];
    }
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

@end
