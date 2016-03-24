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


// subviewController management
-(void)addSubviewController:(LMBaseViewController *)aController;
-(NSArray *)subviewControllers;
-(LMBaseViewController *)firstViewController;

@end
