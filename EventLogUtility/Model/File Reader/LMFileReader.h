//
//  LMFileReader.h
//  EventLogUtility
//
//  Created by GordonXIn on 3/9/16.
//  Copyright © 2016 Sapphire. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface LMFileReader : NSObject

-(NSDictionary *)openFileOptions;

-(NSUInteger)tryOpenSize;

-(NSString *)fileType;

@end




@interface LMFileReader (classMethods)


@end

@interface LMFileReader (fileTypeSpecific)


-(NSDictionary *)defaultOpenFileOptions;

-(NSUInteger)defaultTryOpenFileSize;


-(BOOL)isFormatMathOnData:(NSData *)data;

@end
