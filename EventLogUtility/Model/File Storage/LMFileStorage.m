//
//  LMFile.m
//  EventLogUtility
//
//  Created by GordonXIn on 3/9/16.
//  Copyright © 2016 Sapphire. All rights reserved.
//

#import "LMFileStorage.h"
#import "LMErrorDifinition.h"

@interface LMFileStorage ()

@end

@implementation LMFileStorage

@dynamic isMutable;
@dynamic fileType;

#pragma mark -
#pragma mark        init methods
#pragma mark -

-(instancetype)initWithURL:(NSURL *)absoluteURL options:(NSDictionary *)options error:(NSError *__autoreleasing*)outError
{
    NSTextStorage *storage = nil;
    
    @try
    {
        storage = [[NSTextStorage alloc] initWithURL:absoluteURL
                                             options:options
                                  documentAttributes:nil
                                               error:outError];
    }
    @catch (NSException *exception)
    {
        if (*outError == nil)
        {
            *outError = [NSError errorWithDomain:kLMErrorDomainName code:kLMErrorCodeUnknown.integerValue userInfo:@{NSLocalizedDescriptionKey : exception.reason}];
        }
        
        return nil;
    }
    
    if (self = [super init])
    {
        _UUID = [[NSUUID UUID] UUIDString];
        _parentUUID = [_UUID copy];
        _parentURL = [absoluteURL copy];
        
        _textStorage = storage;
    }
    return self;
}

-(instancetype)initFromParent:(LMFileStorage *)parentStorage
{
    NSTextStorage *storage = [[NSTextStorage alloc] initWithString:@""];
    
    if (self = [super init])
    {
        _UUID = [[NSUUID UUID] UUIDString];
        _parentUUID = [parentStorage parentUUID];
        _parentURL = [parentStorage parentURL];
        
        _textStorage = storage;
    }
    return self;
}


#pragma mark -
#pragma mark        property
#pragma mark -

-(BOOL)isMutable
{
    if ([_UUID isEqualToString:_parentUUID])
        return NO;
    
    return YES;
}

-(NSString *)fileType
{
    return @"Unknown";
}

@end
