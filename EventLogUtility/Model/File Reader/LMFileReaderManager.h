//
//  LMFileReaderManager.h
//  EventLogUtility
//
//  Created by GordonXIn on 3/21/16.
//  Copyright © 2016 Sapphire. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LMFileReaderManager : NSObject

+(instancetype)sharedManager;

-(id)fileReaderForURL:(NSURL *)absoluteURL error:(NSError *__autoreleasing*)outError;

@end
