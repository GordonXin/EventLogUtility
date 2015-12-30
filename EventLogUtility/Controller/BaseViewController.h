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
-(void)addSubviewController:(NSViewController *)aController;

-(void)addSubviewController:(NSViewController *)aController
             withIdentifier:(NSString *)aIdentifier;

@property (nonatomic, readonly, copy) NSArray *subviewControllers;

@property (nonatomic, readonly, copy) NSArray *subViewControllerIdentifers;

-(id)subviewControllerWithIdentifier:(NSString *)aIdentifier;

-(id)subviewControllerAtIndex:(NSUInteger)index;

-(void)removeSubviewController:(NSViewController *)aController;

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


@end
