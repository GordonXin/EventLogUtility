//
//  LMFileHelper.m
//  EventLogUtility
//
//  Created by GordonXIn on 3/16/16.
//  Copyright © 2016 Sapphire. All rights reserved.
//

#import "LMFileHelper.h"

@implementation LMFileHelper

+(BOOL)fileExistsAtURL:(NSURL *)abosulteURL
{
    if (!abosulteURL)
        return NO;
    
    if (![abosulteURL.path length])
        return NO;
    
    if (!abosulteURL.isFileURL)
        return NO;
    
    BOOL isDir = YES;
    if ([[NSFileManager defaultManager] fileExistsAtPath:abosulteURL.path isDirectory:&isDir] == NO)
        return NO;
    
    if (isDir)
        return NO;
    
    return YES;
}

+(BOOL)directoryExistAtURL:(NSURL *)absoluteURL
{
    if (!absoluteURL)
        return NO;
    
    if (![absoluteURL.path length])
        return NO;
    
    if (!absoluteURL.isFileURL)
        return NO;
    
    BOOL isDir = NO;
    if ([[NSFileManager defaultManager] fileExistsAtPath:absoluteURL.path isDirectory:&isDir] == NO)
        return NO;
    
    if (!isDir)
        return NO;
    
    return YES;
}

+(unsigned long long)fileSizeWithHandle:(NSFileHandle *)fileHandle
{
    if (!fileHandle)
    {
        return 0;
    }
    
    unsigned long long currentPos = fileHandle.offsetInFile;
    
    [fileHandle seekToFileOffset:0];
    unsigned long long size = [fileHandle seekToEndOfFile];
    
    [fileHandle seekToFileOffset:currentPos];
    return size;
}

+(unsigned long long)remainingSizeWithHandle:(NSFileHandle *)fileHandle
{
    if (!fileHandle)
    {
        return 0;
    }
    
    unsigned long long currentPos = fileHandle.offsetInFile;
    unsigned long long end = [fileHandle seekToEndOfFile];
    [fileHandle seekToFileOffset:currentPos];
    return (end > currentPos) ? (end - currentPos) : 0;
}

@end
