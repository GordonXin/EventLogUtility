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

@implementation LMFileReaderFactory

+(NSArray*)supportedFileTypes
{
    return @[@"LMDataMonitorFileReader"];
}

+(id)createFileReaderWithFileURL:(NSURL *)absoluteURL error:(NSError *__autoreleasing *)outError
{
    NSArray *supported = [LMFileReaderFactory supportedFileTypes];
    
    for (NSString *aName in supported)
    {
        Class className = NSClassFromString(aName);
        if ([LMFileReaderFactory tryReadFileWithURL:absoluteURL classType:className])
        {
            return [[className alloc] init];
        }
    }
    
    return nil;
}

+(BOOL)tryReadFileWithURL:(NSURL *)absoluteURL classType:(Class)classType
{
    @try
    {
        NSError *outError = nil;
        
        NSFileHandle *fileHanle = [NSFileHandle fileHandleForReadingFromURL:absoluteURL error:&outError];
        if (!fileHanle)
        {
            return NO;
        }
        if (outError)
        {
            return NO;
        }
        
        unsigned long long fileSize = [fileHanle seekToEndOfFile];
        LMFileReader *reader = (LMFileReader *)[[classType alloc] init];
        NSUInteger readSize = [reader defaultTryOpenFileSize];
        
        if (readSize > fileSize)
        {
            readSize = (NSUInteger)fileSize;
        }
        
        NSData *fileData = [fileHanle readDataOfLength:readSize];
        if (!fileData)
        {
            return NO;
        }
        if (!fileData.length)
        {
            return NO;
        }
        
        NSStringEncoding encoding = (NSStringEncoding)[[[reader defaultOpenFileOptions] objectForKey:NSCharacterEncodingDocumentOption] unsignedIntValue];
        
        NSString *fileString = [[NSString alloc] initWithBytesNoCopy:fileData.bytes length:fileData.length encoding:encoding freeWhenDone:NO];
        
    }
    @catch (NSException *exception)
    {
        if (*outError == nil)
        {
            
        }
    }
}

@end

@implementation LMFileReader

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
