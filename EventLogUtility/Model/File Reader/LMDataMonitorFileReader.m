//
//  LMDataMonitorFileReader.m
//  EventLogUtility
//
//  Created by GordonXIn on 3/9/16.
//  Copyright © 2016 Sapphire. All rights reserved.
//

#import "LMDataMonitorFileReader.h"
#import <Cocoa/Cocoa.h>

@implementation LMDataMonitorFileReader

-(NSDictionary *)defaultOpenFileOptions
{
    return @{
             NSCharacterEncodingDocumentOption : [NSNumber numberWithUnsignedInt:(unsigned int)NSUTF8StringEncoding],
             NSDocumentTypeDocumentOption : NSPlainTextDocumentType,
             };
}

-(NSUInteger)defaultTryOpenFileSize
{
    return 1 * 1024 * 1024;
}

@end
