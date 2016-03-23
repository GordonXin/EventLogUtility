//
//  LMDataMonitorFileReader.m
//  EventLogUtility
//
//  Created by GordonXIn on 3/9/16.
//  Copyright © 2016 Sapphire. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "LMDataMonitorFileReader.h"
#import "LMFileHelper.h"
#import "LMLog.h"
#import "RegexKitLite.h"

static const unsigned long long _fileSizeForFormatExaming = 10 * 1024; // 10K bytes

#pragma mark -
@implementation LMDataMonitorFileReader
#pragma mark -

-(NSDictionary *)openFileOptions
{
    return @{
             NSCharacterEncodingDocumentOption : [NSNumber numberWithUnsignedInt:(unsigned int)NSUTF8StringEncoding],
             NSDocumentTypeDocumentOption : NSPlainTextDocumentType,
             };
}

-(NSString *)fileType
{
    return @"Data Monitor Log";
}

-(BOOL)examFormatOnFileHandle:(NSFileHandle *)fileHandle fromURL:(NSURL *)absoluteURL
{
    // step 1. Move to file header
    [fileHandle seekToFileOffset:0];
    
    // step 2. Read a small pieice of file
    unsigned long long remainSize = [LMFileHelper remainingSizeWithHandle:fileHandle];
    unsigned long long readSize = _fileSizeForFormatExaming;
    if (readSize > remainSize)
    {
        readSize = remainSize;
    }
    NSData *fileData = [fileHandle readDataOfLength:readSize];
    if (fileData == nil)
    {
        LOG(@"Reader:%@, Can't read anything from file", NSStringFromClass([self class]));
        return NO;
    }
    if (fileData.length != readSize)
    {
        LOG(@"Reader:%@, Actually read %ld bytes but required %lld", NSStringFromClass([self class]), fileData.length, readSize);
        return NO;
    }
    
    // step 3.convert data to string
    NSStringEncoding encoding = [[[self openFileOptions] objectForKey:NSCharacterEncodingDocumentOption] unsignedIntValue];
    NSMutableString *fileString = [[NSMutableString alloc] initWithData:fileData
                                                               encoding:encoding];
    if (fileString == nil || fileString.length <= 0)
    {
        LOG(@"Reader:%@, Can't convert to string using encoding: %ld", NSStringFromClass([self class]), encoding);
        return NO;
    }
    
    NSString *regexInvalidLineBreak = @"(?:\\r\\n|[\\n\\v\\f\\r\\x85\\p{Zl}\\p{Zp}])(?!\\[)";
    NSString *replaceForInvalidLineBreak = @"    ";
    [fileString replaceOccurrencesOfRegex:regexInvalidLineBreak
                               withString:replaceForInvalidLineBreak
                                  options:RKLMultiline
                                    range:NSMakeRange(0, fileString.length)
                                    error:nil];
    
    NSString *regexValidLine = @"^\\[.+\\]\\[[0-9]{2}[a-zA-Z]{3}[0-9]{2}\\s+[0-9]{2}:[0-9]{2}:[0-9]{2}\\.[0-9]{3}\\]\\s+.+?(?:\\r\\n|[\\n\\v\\f\\r\\x85\\p{Zl}\\p{Zp}])";
    BOOL isMatch = [fileString isMatchedByRegex:regexValidLine];
    if (isMatch)
    {
        return YES;
    }
        
    return NO;
}

@end
