//
//  BaseView.h
//  EventLogUtility
//
//  Created by GordonXIn on 12/30/15.
//  Copyright © 2015 Sapphire. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface BaseView : NSView

#pragma mark color

@property (nonatomic, readwrite, copy) NSColor *backgroundColor;

@property (nonatomic, readwrite, copy) NSColor *borderColor;

@property (nonatomic, readwrite) BOOL hasLeftBorder;

@property (nonatomic, readwrite) BOOL hasRightBorder;

@property (nonatomic, readwrite) BOOL hasTopBorder;

@property (nonatomic, readwrite) BOOL hasBottomBorder;


#pragma mark mouse tracking

@property (nonatomic, readwrite) BOOL hasMouseTracking;

@property (nonatomic, readwrite) int trackingOption;


#pragma mark subview

-(NSView *)subviewWithIdentifier:(NSString *)identifier;

-(void)removeSubview:(NSView *)aView;

-(void)removeSubviewWithIdentifier:(NSString *)identifier;

-(void)removeallSubviews;

-(NSArray *)subviewIdentifiers;


#pragma mark size

-(void)setHeight:(CGFloat)height;
-(void)setWidth:(CGFloat)width;
-(void)setFrameX:(CGFloat)x;
-(void)setFrameY:(CGFloat)y;

@property (nonatomic, readonly, assign) CGFloat height;

@property (nonatomic, readonly, assign) CGFloat width;


@end

