//
//  DocumentController.h
//  EventLogUtility
//
//  Created by cynthia on 3/24/16.
//  Copyright © 2016 Sapphire. All rights reserved.
//

#import <Cocoa/Cocoa.h>

extern NSString * const kLMSavePanelDefaultPathKey;

@class Document;

@interface DocumentController : NSDocumentController

-(Document *)documentWithUUID:(NSString *)UUID;

@end
