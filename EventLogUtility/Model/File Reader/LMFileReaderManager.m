//
//  LMFileReaderManager.m
//  EventLogUtility
//
//  Created by GordonXIn on 3/21/16.
//  Copyright © 2016 Sapphire. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "LMFileReaderManager.h"
#import "LMFileReader.h"
#import "LMFileHelper.h"
#import "LMErrorDifinition.h"
#import "LMLog.h"

@interface LMFileReaderManager ()
{
    NSArray *_readersArray;
}

@end

@implementation LMFileReaderManager

static LMFileReaderManager *_sharedManager = nil;
+(instancetype)sharedManager
{
    if (_sharedManager == nil)
    {
        _sharedManager = [[LMFileReaderManager alloc] init];
    }
    return _sharedManager;
}

-(instancetype)init
{
    if (self = [super init])
    {
        [self initSupportedReaders];
    }
    return self;
}

-(void)initSupportedReaders
{
    _readersArray = @[@"LMDataMonitorFileReader"];
}

-(id)fileReaderForURL:(NSURL *)absoluteURL
{
    LOG(@"Try to find reader for %@", absoluteURL.path);
    
    if (!absoluteURL || ![absoluteURL.path length])
    {
        [LMException raiseExceptionWithName:kLMInvalidArgException
                                   selector:_cmd
                                     reason:[NSString stringWithFormat:@"%@ found invalid input URL",
                                             NSStringFromSelector(_cmd)]
                                   userInfo:@{kLMInvalidArgException_ArgName : @"absoluteURL"}];
        return nil;
    }
    
    if ([LMFileHelper fileExistsAtURL:absoluteURL] == NO)
    {
        [LMException raiseExceptionWithName:kLMFileException
                                   selector:_cmd
                                     reason:[NSString stringWithFormat:@"File doesn't exist at path: %@", absoluteURL.path]
                                   userInfo:@{}];
        return nil;
    }
    
    NSError *outError = nil;
    NSFileHandle *fileHandle = [NSFileHandle fileHandleForReadingFromURL:absoluteURL error:&outError];
    if (fileHandle == nil || outError != nil)
    {
        if (outError != nil)
        {
            [LMException raiseExceptionWithName:kLMFileException
                                       selector:_cmd
                                         reason:[NSString stringWithFormat:@"reading file at %@ failed because %@",
                                                 absoluteURL.path,
                                                 [outError.userInfo objectForKey:NSLocalizedDescriptionKey]]
                                       userInfo:@{}];
            return nil;
        }
        else
        {
            [LMException raiseExceptionWithName:kLMFileException
                                       selector:_cmd
                                         reason:[NSString stringWithFormat:@"reading file at %@ failed because unknown reason",
                                                 absoluteURL.path]
                                       userInfo:@{}];
            return nil;
        }
    }
    
    for (NSString *className in _readersArray)
    {
        LOG(@"Try to find file using %@", className);
        
        LMFileReader *reader = [self createReaderWithName:className];
        if (reader == nil)
        {
            continue;
        }
        
        if ([reader examFormatOnFileHandle:fileHandle fromURL:absoluteURL] == YES)
        {
            return reader;
        }
    }
    
    LOG(@"Can't find correct reader for file at %@, create default reader instead", absoluteURL.path);
    
    // create reader for unknown file type
    return [[LMFileReader alloc] init];
}

-(LMFileReader *)createReaderWithName:(NSString *)className
{
    Class classType = NSClassFromString(className);
    
    if (![classType isSubclassOfClass:[LMFileReader class]])
    {
        LOG(@"Invalid reader class: %@", className);
        return nil;
    }
    
    LMFileReader *reader = [[classType alloc] init];
    if (reader ==nil)
    {
        LOG(@"Can't create instance of reader class: %@", className);
        return nil;
    }
    
    return reader;
}


@end
