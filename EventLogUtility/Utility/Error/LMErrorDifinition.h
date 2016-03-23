//
//  LMErrorDifinition.h
//  EventLogUtility
//
//  Created by GordonXIn on 3/9/16.
//  Copyright © 2016 Sapphire. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const kLMErrorDomainName;

extern NSString * const kLMErrorCodeUnknown;


extern NSString * const kLMInvalidArgException;
extern NSString * const kLMInvalidArgException_ArgName;


extern NSString * const kLMFileException;

@interface LMException : NSException

+(void)raiseExceptionWithName:(NSString *)name
                     selector:(SEL)selector
                       reason:(NSString *)reason
                     userInfo:(NSDictionary *)userInfo;

@end
