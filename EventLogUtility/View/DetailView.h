//
//  DetailView.h
//  EventLogUtility
//
//  Created by GordonXIn on 1/4/16.
//  Copyright © 2016 Sapphire. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "BaseView.h"

@protocol DetailContainerProtocol;

@interface DetailTitleView : BaseView

@property (nonatomic, readwrite, copy) NSString *title;

@property (nonatomic, readwrite, copy) NSImage *image;

@property (nonatomic, readwrite, weak) id target;

@property (nonatomic, readwrite, assign) SEL action;

-(instancetype)initWithFrame:(NSRect)frameRect;

-(instancetype)initWithFrame:(NSRect)frameRect
                       title:(NSString *)title;

-(instancetype)initWithFrame:(NSRect)frameRect
                       title:(NSString *)title
                       image:(NSImage *)image;

+(CGFloat)height;

@end

@interface DetailView : BaseView

-(instancetype)initWithFrame:(NSRect)frameRect contentView:(NSView *)contentView;

-(instancetype)initWithFrame:(NSRect)frameRect contentView:(NSView *)contentView title:(NSString *)title;

-(void)setImage:(NSImage *)image;

-(void)contentViewRequestNewSize:(NSSize)newSize;

@end

@class ExpandableDetailView;

@protocol ExpandableDelegate <NSObject>

-(BOOL)view:(ExpandableDetailView *) aView willExpand:(BOOL)isExpand;

-(void)view:(ExpandableDetailView *) aView didExpand:(BOOL)isExpand;

@end

@interface ExpandableDetailView : DetailView

@property (nonatomic, readwrite, assign) BOOL isExpanded;

@property (nonatomic, readwrite, weak) id<ExpandableDelegate> expandDelegate;

@end

@protocol DetailContainerProtocol <NSObject>

-(void)relayout;

-(void)detailView:(DetailView *)detailView requestNewSize:(NSSize)newSize;

@end

@interface DetailContainerView : BaseView

-(void)addDetailViewWithContent:(NSView *)aView;

-(void)addDetailViewWithContent:(NSView *)aView title:(NSString *)title;

-(void)addExpandableViewWithContetn:(NSView *)aView title:(NSString *)title expand:(BOOL)expand;

@end
