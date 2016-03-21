//
//  LMFileReaderManager.m
//  EventLogUtility
//
//  Created by GordonXIn on 3/21/16.
//  Copyright © 2016 Sapphire. All rights reserved.
//

#import "LMFileReaderManager.h"
#import "LMFileReader.h"
#import "LMFileHelper.h"
#import "LMErrorDifinition.h"

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

-(id)fileReaderForURL:(NSURL *)absoluteURL error:(NSError *__autoreleasing *)outError
{
    if (!absoluteURL || ![absoluteURL.path length])
    {
        if (!*outError)
        {
            *outError = [NSError errorWithDomain:kLMErrorDomainName
                                            code:kLMErrorCodeUnknown.integerValue
                                        userInfo:@{NSLocalizedDescriptionKey:@"invalid input URL"}];
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

-(BOOL)readFileHandle:(NSFileHandle *)fileHandle withReader:(Class)readerClass
{
    if (![readerClass isSubclassOfClass:[LMFileReader class]])
    {
        NSLog(@"%@, invalid reader class: %@", NSStringFromSelector(_cmd), readerClass);
        return NO;
    }
    
    LMFileReader *reader = [[readerClass alloc] init];
    if (reader == nil)
    {
        NSLog(@"%@, can't create instance of reader class: %@", NSStringFromSelector(_cmd), readerClass);
        return NO;
    }
}

@end
