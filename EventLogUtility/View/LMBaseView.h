//
//  LMBaseView.h
//  EventLogUtility
//
//  Created by cynthia on 3/24/16.
//  Copyright © 2016 Sapphire. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class LMBaseViewController;

@interface LMBaseView : NSView

// subview management
-(NSView *)viewWithIdentifier:(NSString *)identifier;

// view size
-(CGFloat)minWidth;
-(CGFloat)minHeight;

@property (nonatomic, readwrite, copy) NSColor *backgroundColor;

@end
