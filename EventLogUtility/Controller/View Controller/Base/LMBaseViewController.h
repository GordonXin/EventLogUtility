//
//  LMBaseViewController.h
//  EventLogUtility
//
//  Created by GordonXIn on 3/9/16.
//  Copyright © 2016 Sapphire. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface LMBaseViewController : NSViewController

#pragma mark -
#pragma mark        manage subview controllers
#pragma mark -

-(void)addSubviewController:(LMBaseViewController *)aController;
-(void)removeSubviewController:(LMBaseViewController *)aContoller;
-(void)removeSubviewControllerWithIdentifier:(NSString *)identifer;
-(LMBaseViewController *)subviewControllerWithIdentifier:(NSString *)identifier;

@property (nonatomic, readonly, assign) NSUInteger   subviewControllerCount;
@property (nonatomic, readonly, copy)   NSArray     *subviewControllers;
@property (nonatomic, readonly, copy)   NSArray     *subviewControllerIdentifiers;

#pragma mark -
#pragma mark        view behaviour
#pragma mark -

// init
-(void)loadViewForDocument:(NSDocument *)document; // all veiw controller should be on a NSDocument window

// dealloc
-(void)unloadView;

#pragma mark -
#pragma mark        model accessing
#pragma mark -

@property (nonatomic, readonly, weak)   NSDocument    *document;

// convinient method for data accessing
-(id)documentForType:(Class)documentType;

@end
