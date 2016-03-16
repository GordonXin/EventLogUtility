//
//  LMFileReader.h
//  EventLogUtility
//
//  Created by GordonXIn on 3/9/16.
//  Copyright © 2016 Sapphire. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LMFileReaderFactory : NSObject

+(id)createFileReaderWithFileURL:(NSURL *)absoluteURL error:(NSError *__autoreleasing*)outError;

@end

@interface LMFileReader : NSObject

-(NSDictionary *)defaultOpenFileOptions;

-(NSUInteger)defaultTryOpenFileSize;

@end
