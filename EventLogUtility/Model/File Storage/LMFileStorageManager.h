//
//  LMFileStorageManager.h
//  EventLogUtility
//
//  Created by GordonXIn on 3/9/16.
//  Copyright © 2016 Sapphire. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LMFileStorage;

@interface LMFileStorageManager : NSObject

+(instancetype)sharedManager;

-(NSDictionary *)defaultOpenFileOptions;

// create file storage
-(LMFileStorage *)createFileStorageWithURL:(NSURL *)absoluteURL error:(NSError *__autoreleasing *)outError;
-(LMFileStorage *)createFileStorageFrom:(LMFileStorage *)fileStorage;

// contents management
-(LMFileStorage *)fileStorageWithUUID:(NSString *)uuid;
-(LMFileStorage *)fileStorageWithURL:(NSURL *)absoluteURL;

-(void)removeFileStorage:(LMFileStorage *)fileStoreage;
-(void)removeFileStorageWithUUID:(NSString *)UUID;
-(void)removeAllFileStorageWithURL:(NSURL *)absoluteURL;

@end
