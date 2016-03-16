//
//  LMFileStorageManager.m
//  EventLogUtility
//
//  Created by GordonXIn on 3/9/16.
//  Copyright © 2016 Sapphire. All rights reserved.
//

#import "LMErrorDifinition.h"
#import "LMFileStorageManager.h"
#import "LMFileStorage.h"

@interface LMFileStorageManager()
{
    NSMutableDictionary *_fileContentDictionary;
    NSObject *_lock;
}

@end

@implementation LMFileStorageManager

#pragma mark -
#pragma mark        init methods
#pragma mark -
-(instancetype)init
{
    if (self = [super init])
    {
        _fileContentDictionary = [NSMutableDictionary dictionary];
        _lock = [[NSObject alloc] init];
    }
    return self;
}


#pragma mark -
#pragma mark        singleton method
#pragma mark -
static LMFileStorageManager *sharedManager = nil;
+(instancetype)sharedManager
{
    if (sharedManager == nil)
    {
        sharedManager = [[LMFileStorageManager alloc] init];
    }
    return sharedManager;
}
//
//#pragma mark -
//#pragma mark        generate file content
//#pragma mark -
//+(LMFileStorage *)createOriginFileContentWithURL:(NSURL *)absoluteURL option:(NSDictionary *)options error:(NSError *__autoreleasing*)outError
//{
//     LMFileStorage *fileContent = [[LMFileContentManager sharedManager] fileContentWithURL:absoluteURL];
////    if (fileContent)
////    {
////        // already exist
////        return fileContent;
////    }
////    
////    @try
////    {
////        fileContent = [[LMFileContent alloc] initWithURL:absoluteURL options:options error:outError];
////    }
////    @catch (NSException *exception)
////    {
////        if (*outError == nil)
////        {
////            *outError = [NSError errorWithDomain:kLMErrorDomainName
////                                            code:[kLMErrorCodeUnknown integerValue]
////                                        userInfo:@{NSLocalizedDescriptionKey : exception.description}];
////        }
////    }
////    
////    if (!fileContent)
////    {
////        if (*outError == nil)
////        {
////            *outError = [NSError errorWithDomain:kLMErrorDomainName
////                                            code:[kLMErrorCodeUnknown integerValue]
////                                        userInfo:@{NSLocalizedDescriptionKey : @"Failed to create file content object with unknown reasion"}];
////        }
////    }
////    else
////    {
////        if ([[LMFileContentManager sharedManager] fileContentWithUUID:fileContent.contentUUID])
////        {
////            // uuid should be unique.
////            // it's strange there are 2 uuid with same value
////            [fileContent setContentUUID:[[NSUUID UUID] UUIDString]];
////        }
////        
////        [[LMFileContentManager sharedManager] addFileContent:fileContent];
////        
////        fileContent.isMutable = NO;
////        fileContent.originUUID = fileContent.contentUUID;
////    }
//    
//    return fileContent;
//}
//
//+(LMFileContent *)createMutableFileContentWithOrigin:(NSString *)originUUID
//{
//    LMFileContent *fileContent = [[LMFileContent alloc] init];
//    
//    if ([[LMFileContentManager sharedManager] fileContentWithUUID:fileContent.contentUUID])
//    {
//        // uuid should be unique.
//        // it's strange there are 2 uuid with same value
//        [fileContent setContentUUID:[[NSUUID UUID] UUIDString]];
//    }
//    
//    [[LMFileContentManager sharedManager] addFileContent:fileContent];
//    
//    fileContent.isMutable = NO;
//    fileContent.originUUID = [originUUID copy];
//    
//    return fileContent;
//}
//
//#pragma mark -
//#pragma mark        file content management
//#pragma mark - 
//-(LMFileContent *)fileContentWithUUID:(NSString *)uuid
//{
//    LMFileContent *ret = nil;
//    if ([uuid length])
//    {
//        @synchronized(_lock)
//        {
//            ret = [_fileContentDictionary objectForKey:uuid];
//        }
//    }
//    return ret;
//}
//
//-(LMFileContent *)fileContentWithURL:(NSURL *)absoluteURL
//{
//    LMFileContent *ret = nil;
//    
//    if (absoluteURL.isFileURL)
//    {
//        @synchronized(_lock)
//        {
//            for (LMFileContent *aFile in _fileContentDictionary.allValues)
//            {
//                if ([aFile.absoluteURL.path isEqualToString:absoluteURL.path])
//                {
//                    ret = aFile;
//                    break;
//                }
//            }
//        }
//    }
//    return ret;
//}
//
//-(void)addFileContent:(LMFileContent *)fileContent
//{
//    if (!fileContent)
//    {
//        return;
//    }
//    NSString *uuid = fileContent.contentUUID;
//    if (![uuid length])
//    {
//        return;
//    }
//    LMFileContent *exist = [self fileContentWithUUID:uuid];
//    if (exist && [fileContent isEqualTo:exist])
//    {
//        return;
//    }
//    
//    // add new or update
//    @synchronized(_lock)
//    {
//        [_fileContentDictionary setObject:fileContent forKey:uuid];
//    }
//}
//
//-(void)removeFileContent:(LMFileContent *)fileContent
//{
//    if (!fileContent)
//    {
//        return;
//    }
//    NSString *uuid = fileContent.contentUUID;
//    if (![uuid length])
//    {
//        return;
//    }
//    LMFileContent *exist = [self fileContentWithUUID:uuid];
//    if (exist && ![fileContent isEqualTo:exist])
//    {
//        // same uuid but value not same. ignore for now
//        return;
//    }
//
//    @synchronized(_lock)
//    {
//        [_fileContentDictionary removeObjectForKey:uuid];
//    }
//}
//
//-(void)removeFileContentWithUUID:(NSString *)uuid
//{
//    if (![uuid length])
//    {
//        return;
//    }
//    
//    @synchronized(_lock)
//    {
//        [_fileContentDictionary removeObjectForKey:uuid];
//    }
//}


@end
