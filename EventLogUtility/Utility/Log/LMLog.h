//
//  LMLog.h
//  EventLogUtility
//
//  Created by GordonXIn on 3/22/16.
//  Copyright © 2016 Sapphire. All rights reserved.
//

#import <Foundation/Foundation.h>


#define LOG(inFormat...) \
[[LMLog sharedLog] log:NSStringFromSelector(_cmd) msgFormat:inFormat]

#define LOCATOR \
[NSString stringWithFormat:@"%@.%@", NSStringFromClass([self class]), NSStringFromSelector(_cmd)]


@interface LMLog : NSObject

+(LMLog *)sharedLog;

- (void)log:(NSString*)funcName msgFormat:(NSString*)msg, ...NS_FORMAT_FUNCTION(2,3);

@end