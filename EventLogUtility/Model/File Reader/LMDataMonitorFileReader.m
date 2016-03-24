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
#import "LMErrorDifinition.h"

@implementation LMDataMonitorFileReader

+(NSArray *)allowedFileTypes
{
    return @[@"log", @"Log", @"LOG"];
}

-(NSString *)fileType
{
    return @"Data Monitor Log";
}

-(LMResult *)checkFileFormat:(NSString *)fileString range:(NSRange)range
{
    if (fileString == nil || fileString.length <= 0)
    {
        return [LMResult ASSFailWithError:[LMError errorWithDescription:[NSString stringWithFormat:@"%@.%@ invaid input file string", NSStringFromClass([self class]), NSStringFromSelector(_cmd)]]];
    }
    
    NSError *outError = nil;
    NSRegularExpression *regexValidLine = [[NSRegularExpression alloc] initWithPattern:@"(?<=\\A|\\r\\n|[\\n\\v\\f\\r\\x85\\p{Zl}\\p{Zp}])\\[[0-9a-fA-F]+?\\]\\[[0-9]{2}[a-zA-Z]{3}[0-9]{2}\\s+?[0-9]{2}:[0-9]{2}:[0-9]{2}\\.[0-9]{3}\\]\\s+.+?(?:\\r\\n|[\\n\\v\\f\\r\\x85\\p{Zl}\\p{Zp}])(?=\\[|\\z)" options:NSRegularExpressionDotMatchesLineSeparators error:&outError];
    if (outError != nil)
    {
        return [LMResult ASSFailWithError:[LMError errorWithDescription:[NSString stringWithFormat:@"%@.%@ invalid regex for regexValidLine(%@)", NSStringFromClass([self class]), NSStringFromSelector(_cmd), regexValidLine.pattern]]];
    }
    
    NSTextCheckingResult *result = [regexValidLine firstMatchInString:fileString options:0 range:range];
    if (result == nil || result.range.location == NSNotFound || result.range.length <= 0)
    {
        return [LMResult ASSFalse];
    }
    
    return [LMResult ASSTrue];
}

-(LMResult *)numberOfLines:(NSString *)fileString range:(NSRange)range
{
    LMError *outError = nil;
    NSRegularExpression *regexValidLine = [[NSRegularExpression alloc] initWithPattern:@"(?<=\\A|\\r\\n|[\\n\\v\\f\\r\\x85\\p{Zl}\\p{Zp}])\\[[0-9a-fA-F]+?\\]\\[[0-9]{2}[a-zA-Z]{3}[0-9]{2}\\s+?[0-9]{2}:[0-9]{2}:[0-9]{2}\\.[0-9]{3}\\]\\s+.+?(?:\\r\\n|[\\n\\v\\f\\r\\x85\\p{Zl}\\p{Zp}])(?=\\[|\\z)" options:NSRegularExpressionDotMatchesLineSeparators error:&outError];
    if (outError != nil)
    {
        return [LMResult ASSFailWithError:[LMError errorWithDescription:[NSString stringWithFormat:@"%@.%@ invalid regex for regexValidLine(%@)", NSStringFromClass([self class]), NSStringFromSelector(_cmd), regexValidLine.pattern]]];
    }
    
    NSArray<NSTextCheckingResult *> *matches = [regexValidLine matchesInString:fileString options:0 range:range];
    if (matches == nil)
    {
        matches = [NSArray array];
    }
    return [LMResult ASSTrueWithInfo:matches];
}

@end
