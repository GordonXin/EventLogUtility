//
//  LMBaseViewController.h
//  EventLogUtility
//
//  Created by GordonXIn on 3/9/16.
//  Copyright © 2016 Sapphire. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class Document;

@interface LMBaseViewController : NSViewController

//
// handle subview controllers
//
-(void)addSubviewController:(LMBaseViewController *)aController;
-(void)addSubviewController:(LMBaseViewController *)aController withIdentifier:(NSString *)identifier;
-(void)removeSubviewController:(LMBaseViewController *)aContoller;
-(void)removeSubviewControllerWithIdentifier:(NSString *)identifer;
-(void)removeSubviewControllerAtIndex:(NSUInteger)index;
-(LMBaseViewController *)subviewControllerWithIdentifier:(NSString *)identifier;
-(LMBaseViewController *)subviewControllerAtIndex:(NSUInteger)index;

@property (nonatomic, readonly, assign) NSUInteger   subviewControllerCount;
@property (nonatomic, readonly, copy)   NSArray     *subviewControllers;
@property (nonatomic, readonly, copy)   NSArray     *subviewControllerIdentifiers;
@property (nonatomic, readwrite, weak)  LMBaseViewController *superviewController;
@property (nonatomic, readwrite, copy)  NSString    *documentUuid;

// loading for on document
-(void)loadViewForDocument:(NSString *)documentUUID;

//
// model accessment
//
@property (nonatomic, readonly, weak)   Document    *document;

@end
