//
//  LMFileReaderManager.m
//  EventLogUtility
//
//  Created by GordonXIn on 3/21/16.
//  Copyright © 2016 Sapphire. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "LMFileReaderFactory.h"
#import "LMFileReader.h"
#import "LMFileHelper.h"
#import "LMErrorDifinition.h"
#import "LMLog.h"


@implementation LMFileReaderFactory

+(NSArray *)allowedFileReaders
{
    return @[@"LMDataMonitorFileReader"];
}

+(NSArray *)allowedFileTypes
{
    NSArray * const _readersArray = @[@"LMDataMonitorFileReader"];
    NSMutableArray *supported = [NSMutableArray array];
    
    for (NSString *className in _readersArray)
    {
        Class classType = NSClassFromString(className);
        
        NSArray *allowed = [classType allowedFileTypes];
        
        for (NSString *aType in allowed)
        {
            if ([supported containsObject:aType] == NO)
            {
                [supported addObject:aType];
            }
        }
    }
    return [NSArray arrayWithArray:supported];
}

+(id)fileReaderForString:(NSString *)fileString
{
    NSArray * const _readersArray = @[@"LMDataMonitorFileReader"];
    
    if (fileString != nil && fileString.length > 0)
    {
        for (NSString *className in _readersArray)
        {
            @autoreleasepool
            {
                Class classType = NSClassFromString(className);
                
                if (![classType isSubclassOfClass:[LMFileReader class]])
                {
                    continue;
                }
                
                LMFileReader *reader = [[classType alloc] init];
                if (reader ==nil)
                {
                    continue;
                }
                
                LMResult *result = [reader checkFileFormat:fileString range:NSMakeRange(0, fileString.length)];
                if ([LMResult isTrue:result])
                {
                    return reader;
                }
            }
        }
    }
    
    // create reader for unknown file type
    return [[LMFileReader alloc] init];
}

@end
