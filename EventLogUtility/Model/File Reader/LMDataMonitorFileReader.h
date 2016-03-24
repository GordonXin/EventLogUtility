//
//  LMDataMonitorFileReader.h
//  EventLogUtility
//
//  Created by GordonXIn on 3/9/16.
//  Copyright © 2016 Sapphire. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LMFileReader.h"

@interface LMDataMonitorFileReader : LMFileReader

+(NSArray *)allowedFileTypes;

@end
