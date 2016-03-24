//
//  LMErrorDifinition.m
//  EventLogUtility
//
//  Created by GordonXIn on 3/9/16.
//  Copyright © 2016 Sapphire. All rights reserved.
//

#import "LMErrorDifinition.h"
#import "LMLog.h"


NSString * const kLMInvalidArgException = @"kLMInvalidArgException";
NSString * const kLMInvalidArgException_ArgName = @"kLMInvalidArgException_ArgName";


NSString * const kLMFileException = @"kLMFileException";

@implementation LMException

+(void)raiseExceptionWithName:(NSString *)name
                     selector:(SEL)selector
                       reason:(nullable NSString *)reason
                     userInfo:(nullable NSDictionary *)userInfo
{
    [[LMLog sharedLog] log:NSStringFromSelector(selector) msgFormat:@"Exception %@ found! Error: %@", name, reason];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:userInfo];
    if ([dic objectForKey:@"kLMSelector"] == nil)
    {
        [dic setObject:NSStringFromSelector(selector) forKey:@"kLMSelector"];
    }
    
    LMException *exception = [[LMException alloc] initWithName:name
                                                        reason:reason
                                                      userInfo:userInfo];
    [exception raise];
}

@end

#pragma mark -
#pragma mark        Error class
#pragma mark -

NSString * const kLMErrorDomainName = @"EventLogUtility";
NSString * const kLMErrorCodeUnknown = @"00010";

static NSInteger kLMErrorCodeUndefined = 9999;

@implementation LMError

+(instancetype)errorWithDescription:(NSString *)description
{
    return [LMError errorWithCode:kLMErrorCodeUndefined description:description];
}

+(instancetype)errorWithCode:(NSInteger)errorCode description:(NSString *)description
{
    return [LMError errorWithCode:errorCode description:description info:nil];
}

+(instancetype)errorWithCode:(NSInteger)errorCode description:(NSString *)description info:(NSDictionary *)info
{
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithDictionary:info ? info : @{}];
    [userInfo setObject:description forKey:NSLocalizedDescriptionKey];
    
    return [LMError errorWithDomain:kLMErrorDomainName code:errorCode userInfo:userInfo];
}

-(instancetype)copy
{
    return [LMError errorWithDomain:self.domain code:self.code userInfo:self.userInfo];
}

@end


#pragma mark -
#pragma mark        result class
#pragma mark -

const NSInteger kLMResultFail = -1;
const NSInteger kLMResultFalse = 0;
const NSInteger kLMResultTrue = 1;

@interface LMResult()
{
}

-(void)setInfo:(id)info;
-(void)setResult:(NSInteger)result;

@end

@implementation LMResult

@synthesize info = _info;
@dynamic error;

// true
+(instancetype)ASSTrue
{
    LMResult *result = [[LMResult alloc] init];
    [result setResult:kLMResultTrue];
    return result;
}

+(instancetype)ASSTrueWithInfo:(id)info
{
    LMResult *result = [[LMResult alloc] init];
    [result setResult:kLMResultTrue];
    [result setInfo:info];
    return result;
}

// false
+(instancetype)ASSFalse
{
    LMResult *result = [[LMResult alloc] init];
    [result setResult:kLMResultFalse];
    return result;
}

+(instancetype)ASSFalseWithInfo:(id)info
{
    LMResult *result = [[LMResult alloc] init];
    [result setResult:kLMResultFalse];
    [result setInfo:info];
    return result;
}

// fail
+(instancetype)ASSFailWithError:(LMError *)error
{
    LMResult *result = [[LMResult alloc] init];
    [result setResult:kLMResultFail];
    [result setInfo:error];
    return result;
}

+(BOOL)isFail:(LMResult *)result
{
    return result.result == kLMResultFail;
}

+(BOOL)isFalse:(LMResult *)result
{
    return result.result == kLMResultFalse;
}

+(BOOL)isTrue:(LMResult *)result
{
    return result.result == kLMResultTrue;
}

-(void)setInfo:(id)info
{
    if (info == nil)
        return;
    
    if ([info isKindOfClass:[NSArray class]])
    {
        _info = [NSArray arrayWithArray:(NSArray *)info];
    }
    else if ([info isKindOfClass:[NSDictionary class]])
    {
        _info = [NSDictionary dictionaryWithDictionary:(NSDictionary *)info];
    }
    else if ([info isKindOfClass:[NSString class]])
    {
        _info = [NSString stringWithString:(NSString *)info];
    }
    else
    {
        _info = [info copy];
    }
}

-(void)setResult:(NSInteger)result
{
    if (result < 0)
    {
        _result = kLMResultFail;
    }
    else if (result > 0)
    {
        _result = kLMResultTrue;
    }
    else if (result == 0)
    {
        _result = kLMResultFalse;
    }
}

-(id)info
{
    if (_info == nil)
        return nil;
    
    if ([_info isKindOfClass:[NSArray class]])
    {
        return [NSArray arrayWithArray:(NSArray *)_info];
    }
    else if ([_info isKindOfClass:[NSDictionary class]])
    {
        return [NSDictionary dictionaryWithDictionary:(NSDictionary *)_info];
    }
    else if ([_info isKindOfClass:[NSString class]])
    {
        return [NSString stringWithString:(NSString *)_info];
    }
    else
    {
        return [_info copy];
    }
}

-(LMError *)error
{
    if (_info == nil)
        return nil;
    
    if (![_info isKindOfClass:[LMError class]])
        return nil;
    
    return (LMError *)_info;
}

@end



