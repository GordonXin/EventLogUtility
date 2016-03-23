//
//  LMLog.m
//  EventLogUtility
//
//  Created by GordonXIn on 3/22/16.
//  Copyright © 2016 Sapphire. All rights reserved.
//

#import "LMLog.h"

@interface LMLog ()
{
    NSDateFormatter *_dateFormatter;
}

@end

@implementation LMLog

static LMLog *_sharedLogInstance = nil;
+(LMLog *)sharedLog
{
    if (_sharedLogInstance == nil)
    {
        _sharedLogInstance = [[LMLog alloc] init];
    }
    return _sharedLogInstance;
}

-(instancetype)init
{
    if (self = [super init])
    {
        _dateFormatter = [[NSDateFormatter alloc] init];
        [_dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];
    }
    return self;
}

- (void)log:(NSString*)funcName msgFormat:(NSString*)msg, ...
{
    @try
    {
        va_list args;
        va_start(args, msg);
        NSString *reason = [[NSString alloc] initWithFormat:msg arguments:args];
        va_end(args);
        
        
        NSLog(@"[%@][%@] %@", [_dateFormatter stringFromDate:[NSDate date]], funcName, reason);
        
    }
    @catch (NSException* exception)
    {
    }
}

@end

