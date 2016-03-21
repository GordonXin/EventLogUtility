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

#pragma mark        File Type Specific
#pragma mark -

-(NSArray *)fileExtensions
{
    return @[];
}

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

-(NSString *)fileType
{
    return @"Unknown type";
}

-(BOOL)isFormatMathOnData:(NSData *)data
{
    return NO;
}

#pragma mark -
#pragma mark        class method
#pragma mark -

static NSArray *_supportedFileExtensions = nil;
+(NSArray *)supportedFileExtensions
{
    if (_supportedFileExtensions == nil)
    {
        NSArray *readers = [[self class] supportedReaderNames];
        NSMutableDictionary *extensions = [NSMutableDictionary dictionary];

        for (NSString *str in readers)
        {
            @autoreleasepool
            {
                Class className = NSClassFromString(str);
                if (!className)
                {
                    continue;
                }
                
                if (![className isSubclassOfClass:[LMFileReader class]])
                {
                    continue;
                }
                
                LMFileReader *instance = [[className alloc] init];
                if (!instance)
                {
                    continue;
                }
                
                NSArray *subAry = [instance fileExtensions];
                for (NSString *ext in subAry)
                {
                    if ([extensions objectForKey:ext] != nil)
                    {
                        [extensions setObject:ext forKey:ext];
                    }
                }
            }
        }
        
        _supportedFileExtensions = [extensions allValues];
    }
    return _supportedFileExtensions;
}

+(id)createReaderForFileWithURL:(NSURL *)absoluteURL error:(NSError *__autoreleasing *)outError
{
    if (!absoluteURL || ![absoluteURL.path length])
    {
        if (!*outError)
        {
            *outError = [NSError errorWithDomain:kLMErrorDomainName
                                            code:kLMErrorCodeUnknown.integerValue
                                        userInfo:@{NSLocalizedDescriptionKey:@"createReaderForFileWithURL: invalid absolute URL"}];
            return nil;
        }
    }
    
    if ([LMFileHelper fileExistsAtURL:absoluteURL] == NO)
    {
        if (!*outError)
        {
            *outError = [NSError errorWithDomain:kLMErrorDomainName
                                            code:kLMErrorCodeUnknown.integerValue
                                        userInfo:@{NSLocalizedDescriptionKey:[NSString stringWithFormat:@"File doesn't exist at path: %@", absoluteURL.path]}];
            return nil;
        }
    }
    
    NSString *cleanFileExtension = [[absoluteURL.lastPathComponent componentsSeparatedByString:@"."] objectAtIndex:1];
    
    if (!cleanFileExtension || ![cleanFileExtension length])
    {
        if (!*outError)
        {
            *outError = [NSError errorWithDomain:kLMErrorDomainName
                                            code:kLMErrorCodeUnknown.integerValue
                                        userInfo:@{NSLocalizedDescriptionKey:[NSString stringWithFormat:@"%@ get empty file extension", NSStringFromSelector(_cmd)]}];
            return nil;
        }
    }
    
    NSArray *extensions = [[self class] supportedFileExtensions];
    if (![extensions containsObject:cleanFileExtension])
    {
        if (!*outError)
        {
            *outError = [NSError errorWithDomain:kLMErrorDomainName
                                            code:kLMErrorCodeUnknown.integerValue
                                        userInfo:@{NSLocalizedDescriptionKey:[NSString stringWithFormat:@"%@ get illegal file extension %@ (legal:%@)", NSStringFromSelector(_cmd), cleanFileExtension, extensions]}];
            return nil;
        }
    }
    
    NSFileHandle *fileHandle = [NSFileHandle fileHandleForReadingFromURL:absoluteURL error:outError];
    if (!fileHandle)
    {
        if (!*outError)
        {
            *outError = [NSError errorWithDomain:kLMErrorDomainName
                                            code:kLMErrorCodeUnknown.integerValue
                                        userInfo:@{NSLocalizedDescriptionKey:[NSString stringWithFormat:@"File doesn't exist at path: %@", absoluteURL.path]}];
            return nil;
        }
    }
    if (*outError)
    {
        // an error already there
        return nil;
    }
    
    NSArray *readerNames = [[self class] supportedReaderNames];
    for (NSString *readerName in readerNames)
    {
        @autoreleasepool
        {
            Class className = NSClassFromString(readerName);
            if (!className)
            {
                continue;
            }
            
            LMFileReader *reader = [[className alloc] init];
            if (!reader)
            {
                continue;
            }
            
            // move to begin of file
            [fileHandle seekToFileOffset:0];
            
            unsigned long long sizeToRead = [reader defaultTryOpenFileSize];
            if (sizeToRead <= 0)
            {
                continue;
            }
            
            unsigned long long sizeOfFile = [LMFileHelper fileSizeWithHandle:fileHandle];
            if (sizeToRead > sizeOfFile)
            {
                sizeToRead = sizeOfFile;
            }
            
            // read a small piece of file
            NSData *fileData = [fileHandle readDataOfLength:sizeToRead];
            if (!fileData)
            {
                continue;
            }
            if (fileData.length != sizeToRead)
            {
                continue;
            }
            
            if ([reader isFormatMathOnData:fileData])
            {
                return reader;
            }
        }
        
    }
    
    return nil;
}


@end
