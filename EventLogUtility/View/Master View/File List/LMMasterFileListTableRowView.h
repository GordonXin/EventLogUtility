//
//  LMMasterFileListTableRowView.h
//  EventLogUtility
//
//  Created by cynthia on 3/29/16.
//  Copyright © 2016 Sapphire. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface LMMasterFileListTableRowView : NSTableRowView

@end

@interface LMMasterFileListTableTitleView : NSTableCellView

@end

@interface LMMasterFileListTableTextView : NSTableCellView

@property (nonatomic, readwrite, weak) IBOutlet NSButton *imageButton;

@end
