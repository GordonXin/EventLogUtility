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

extern NSString * const kLMErrorCodeUnknown;

@interface LMError : NSError

+(instancetype)errorWithDescription:(NSString *)description;

+(instancetype)errorWithCode:(NSInteger)errorCode description:(NSString *)description;

+(instancetype)errorWithCode:(NSInteger)errorCode description:(NSString *)description info:(NSDictionary *)info;

@end


#pragma mark -
#pragma mark        result class
#pragma mark -

extern const NSInteger kLMResultFail;
extern const NSInteger kLMResultFalse;
extern const NSInteger kLMResultTrue;

@interface LMResult : NSObject

// true
+(instancetype)ASSTrue;

+(instancetype)ASSTrueWithInfo:(id)info;

// false
+(instancetype)ASSFalse;

+(instancetype)ASSFalseWithInfo:(id)info;

// fail
+(instancetype)ASSFailWithError:(LMError *)error;

// judge
+(BOOL)isTrue:(LMResult *)result;
+(BOOL)isFalse:(LMResult *)result;
+(BOOL)isFail:(LMResult *)result;

@property (nonatomic, readonly, assign)     NSInteger       result;
@property (nonatomic, readonly, copy)       id              info;
@property (nonatomic, readonly, copy)       LMError         *error;

@end
