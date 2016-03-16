//
//  LMDocumentWindowController.h
//  EventLogUtility
//
//  Created by GordonXIn on 3/9/16.
//  Copyright © 2016 Sapphire. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface LMDocumentWindowController : NSWindowController

@property (nonatomic, readwrite, copy) NSString *documentUUID;

-(void)loadForDocument:(NSString *)uuid;

@end
