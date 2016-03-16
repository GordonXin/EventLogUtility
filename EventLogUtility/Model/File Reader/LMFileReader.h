//
//  LMFileReader.h
//  EventLogUtility
//
//  Created by GordonXIn on 3/9/16.
//  Copyright © 2016 Sapphire. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface LMFileReader : NSObject

@end

@interface LMFileReader (classMethods)

+(NSArray *)supportedFileExtensions;

+(id)createReaderForFileWithURL:(NSURL *)absoluteURL error:(NSError *__autoreleasing*)outError;

@end

@interface LMFileReader (fileTypeSpecific)

+(NSArray *)supportedReaderNames;

-(NSArray *)fileExtensions;

-(NSDictionary *)defaultOpenFileOptions;

-(NSUInteger)defaultTryOpenFileSize;

-(NSString *)fileType;

-(BOOL)isFormatMathOnData:(NSData *)data;

@end
