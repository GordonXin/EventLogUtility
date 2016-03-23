//
//  LMErrorDifinition.h
//  EventLogUtility
//
//  Created by GordonXIn on 3/9/16.
//  Copyright © 2016 Sapphire. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const kLMInvalidArgException;
extern NSString * const kLMInvalidArgException_ArgName;


extern NSString * const kLMFileException;

@interface LMException : NSException

+(void)raiseExceptionWithName:(NSString *)name
                     selector:(SEL)selector
                       reason:(NSString *)reason
                     userInfo:(NSDictionary *)userInfo;

@end

#pragma mark -
#pragma mark        Error class
#pragma mark -

extern NSString * const kLMErrorDomainName;
extern NSString * const kLMWarnDomainName;

extern NSString * const kLMErrorCodeUnknown;

@interface LMError : NSError

// error
+(instancetype)errorWithCode:(NSInteger)errorCode infoDescription:(NSString *)info;

+(instancetype)errorWithCode:(NSInteger)errorCode info:(NSDictionary *)info;

// warn
+(instancetype)warnWithCode:(NSInteger)warnCode infoDescription:(NSString *)info;

+(instancetype)warnWithCode:(NSInteger)warnCode info:(NSDictionary *)info;

@end

@interface LMResult : NSObject

// true
+(instancetype)success;

+(instancetype)successWithInfo:(NSDictionary *)info;

// false
+(instancetype)

@end
