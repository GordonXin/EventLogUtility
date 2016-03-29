//
//  LMFile.m
//  EventLogUtility
//
//  Created by GordonXIn on 3/9/16.
//  Copyright © 2016 Sapphire. All rights reserved.
//

#import "LMFileStorage.h"
#import "LMErrorDifinition.h"
#import "LMFileReader.h"
#import "LMFileReaderFactory.h"
#import "LMLog.h"

@interface LMFileStorage ()

@end

@implementation LMFileStorage

#pragma mark -
#pragma mark        init methods
#pragma mark -

-(instancetype)initWithURL:(NSURL *)absoluteURL error:(NSError *__autoreleasing*)outError
{
    NSTextStorage *storage = nil;
    NSDictionary *dicAttributes = nil;
    
    @try
    {
        storage = [[NSTextStorage alloc] initWithURL:absoluteURL
                                             options:@{}
                                  documentAttributes:&dicAttributes
                                               error:outError];
    }
    @catch (NSException *exception)
    {
        if (outError)
        {
            *outError = [LMError errorWithDescription:exception.reason];
        }
        
        return nil;
    }
    
    if (storage == nil)
    {
        if (outError && *outError == nil)
        {
            *outError = [LMError errorWithDescription:[NSString stringWithFormat:@"%@ Can't create instance", LOCATOR]];
        }
        return nil;
    }
    
    if (self = [super init])
    {
        _UUID = [[NSUUID UUID] UUIDString];
        
        _originUUID = [_UUID copy];
        _originURL = [absoluteURL copy];
        
        _textStorage = storage;
        _fileAttributes = dicAttributes;
        
        _alowsWriting = NO;
        
        _prettyName = [[_originURL.lastPathComponent pathComponents] lastObject];
        
        [self initReader];
    }
    return self;
}

-(instancetype)initFromStorage:(LMFileStorage *)aStorage
{
    NSTextStorage *storage = [[NSTextStorage alloc] initWithString:@""];
    
    if (self = [super init])
    {
        _UUID = [[NSUUID UUID] UUIDString];
        
        _originURL = [aStorage originURL];
        _originUUID = [aStorage originUUID];
        
        _textStorage = storage;
        _fileAttributes = [aStorage fileAttributes];
        
        _alowsWriting = YES;
        
        [self initReader];
    }
    return self;
}

-(void)initReader
{
    _reader = [LMFileReaderFactory fileReaderForString:_textStorage.mutableString];
}

@end
