//
//  LMFileContentManager.h
//  EventLogUtility
//
//  Created by GordonXIn on 3/9/16.
//  Copyright © 2016 Sapphire. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LMFileContent;

@interface LMFileContentManager : NSObject

+(instancetype)sharedManager;

// generate file content
+(LMFileContent *)createOriginFileContentWithURL:(NSURL *)absoluteURL
                                          option:(NSDictionary *)options
                                           error:(NSError *__autoreleasing*)outError;

+(LMFileContent *)createMutableFileContentWithOrigin:(NSString *)originUUID;

//
// contents management
//
-(LMFileContent *)fileContentWithUUID:(NSString *)uuid;
-(LMFileContent *)fileContentWithURL:(NSURL *)absoluteURL;
-(void)addFileContent:(LMFileContent *)fileContent;
-(void)removeFileContent:(LMFileContent *)fileContent;
-(void)removeFileContentWithUUID:(NSString *)uuid;

@end
