//
//  LMFileHelper.h
//  EventLogUtility
//
//  Created by GordonXIn on 3/16/16.
//  Copyright © 2016 Sapphire. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LMFileHelper : NSObject

+(BOOL)fileExistsAtURL:(NSURL *)abosulteURL;

+(unsigned long long)fileSizeWithHandle:(NSFileHandle *)fileHandle;

+(unsigned long long)remainingSizeWithHandle:(NSFileHandle *)fileHandle;

@end
