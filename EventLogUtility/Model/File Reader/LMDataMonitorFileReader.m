//
//  LMDataMonitorFileReader.m
//  EventLogUtility
//
//  Created by GordonXIn on 3/9/16.
//  Copyright © 2016 Sapphire. All rights reserved.
//

#import "LMDataMonitorFileReader.h"
#import <Cocoa/Cocoa.h>

#pragma mark -
@implementation LMDataMonitorFileReader
#pragma mark -

#pragma mark        constant
#pragma mark -
-(NSArray *)fileExtensions
{
    return @[@"Log", @"log", @"LOG"];
}

@end
