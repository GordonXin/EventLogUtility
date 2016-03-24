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
#import "LMLog.h"

@implementation LMFileReader

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

-(LMResult *)checkFileFormat:(NSString *)fileString range:(NSRange)range
{
    return [LMResult ASSFailWithError:[LMError errorWithDescription:[NSString stringWithFormat:@"Base class(%@) doesn't implement method(%@)",
                                                                     NSStringFromClass([self class]),
                                                                     NSStringFromSelector(_cmd)]]];
}

-(LMResult *)numberOfLines:(NSString *)fileString range:(NSRange)range
{
    LMError *outError = nil;
    NSRegularExpression *regexLineBreak = [NSRegularExpression regularExpressionWithPattern:@"^.+?$" options:0 error:&outError];
    if (regexLineBreak == nil || outError != nil)
    {
        if (outError == nil)
        {
            outError = [LMError errorWithDescription:[NSString stringWithFormat:@"%@ Can't init regex 'regexLineBreak'", LOCATOR]];
        }
        return [LMResult ASSFailWithError:outError];
    }
    
    NSArray<NSTextCheckingResult *> *matches = [regexLineBreak matchesInString:fileString options:0 range:range];
    if (matches == nil)
    {
        matches = [NSArray array];
    }
    return [LMResult ASSTrueWithInfo:matches];
}

@end
