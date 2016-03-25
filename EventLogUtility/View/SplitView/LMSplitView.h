//
//  LMSplitView.h
//  EventLogUtility
//
//  Created by cynthia on 3/25/16.
//  Copyright © 2016 Sapphire. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface LMSplitView : NSSplitView

@property (nonatomic, readwrite, strong) NSImage *dividerImageIfCollapsed;

@property (nonatomic, readwrite, assign) NSInteger dividerThicknessIfCollapsed;

@end
