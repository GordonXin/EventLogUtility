//
//  LMFileReaderManager.h
//  EventLogUtility
//
//  Created by GordonXIn on 3/21/16.
//  Copyright © 2016 Sapphire. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LMFileReaderFactory : NSObject

+(id)fileReaderForString:(NSString *)fileString;

+(NSArray *)allowedFileTypes;

@end
