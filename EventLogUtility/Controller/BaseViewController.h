//
//  BaseViewController.h
//  EventLogUtility
//
//  Created by GordonXIn on 12/30/15.
//  Copyright © 2015 Sapphire. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class Document;

@interface BaseViewController : NSViewController

#pragma mark init methods
-(instancetype)init;

-(instancetype)initWithCoder:(NSCoder *)coder;

-(instancetype)initWithNibName:(NSString *)nibNameOrNil
                        bundle:(NSBundle *)nibBundleOrNil;

#pragma mark over ride methods
-(void)viewDidLoad;

-(void)viewWillAppear;

-(void)viewDidAppear;

-(void)viewWillLayout;

-(void)viewDidLayout;

-(void)viewWillDisappear;

-(void)viewDidDisappear;

-(void)dealloc;

-(void)awakeFromNib;

-(void)prepareDealloc;

-(void)awakeFromDocument:(Document *)document;

#pragma mark subview controllers methods
-(void)addSubviewController:(BaseViewController *)aController;

-(void)addSubviewController:(BaseViewController *)aController
             withIdentifier:(NSString *)aIdentifier;

@property (nonatomic, readonly, copy) NSArray *subviewControllers;

@property (nonatomic, readonly, copy) NSArray *subViewControllerIdentifers;

-(BaseViewController *)subviewControllerWithIdentifier:(NSString *)aIdentifier;

-(BaseViewController *)subviewControllerAtIndex:(NSUInteger)index;

-(void)removeSubviewController:(BaseViewController *)aController;

-(void)removeAllSubviewControllers;

#pragma mark super view controller
@property (nonatomic, readwrite, weak) BaseViewController *superViewController;

#pragma mark data
@property (nonatomic, readwrite, weak) Document *document;

@end

@protocol NavigateDelegate <NSObject>

@required

-(void)navigateController:(BaseViewController *)aController
                didSelect:(NSString *)name;

@optional

-(BOOL)navigateController:(BaseViewController *)aController
             shouldSelect:(NSString *)name;

-(BOOL)navigateController:(BaseViewController *)aController
              shouldClose:(NSString *)name;

-(void)navigateController:(BaseViewController *)aController
                 didClose:(NSString *)name;

@end

@interface NavigateBaseViewController : BaseViewController

@property (nonatomic, readwrite, weak) id<NavigateDelegate> navigateDelegate;

-(void)addItem:(id)item;

@end
