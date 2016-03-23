//
//  LMErrorDifinition.m
//  EventLogUtility
//
//  Created by GordonXIn on 3/9/16.
//  Copyright © 2016 Sapphire. All rights reserved.
//

#import "LMErrorDifinition.h"
#import "LMLog.h"

NSString * const kLMErrorDomainName = @"EventLogUtility";
NSString * const kLMErrorCodeUnknown = @"00010";



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



