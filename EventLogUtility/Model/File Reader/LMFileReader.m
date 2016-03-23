//
//  LMFileReader.m
//  EventLogUtility
//
//  Created by GordonXIn on 3/9/16.
//  Copyright © 2016 Sapphire. All rights reserved.
//

#import "LMFileReader.h"
#import <Cocoa/Cocoa.h>
#import "LMErrorDifinition.h"
#import "LMFileHelper.h"

#pragma mark -
@implementation LMFileReader
#pragma mark -

-(instancetype)init
{
    if (self  = [super init])
    {
        
    }
    return self;
}

-(NSDictionary *)openFileOptions
{
    return @{};
}

-(NSString *)fileType
{
    return @"unknonw type";
}

-(BOOL)examFormatOnFileHandle:(NSFileHandle *)fileHandle fromURL:(NSURL *)absoluteURL
{
    [LMException raiseExceptionWithName:kLMFileException
                               selector:_cmd
                                 reason:[NSString stringWithFormat:@"Should not use LMFileReader base implement to check file format"]
                               userInfo:@{}];
    
    return NO;
}

@end
