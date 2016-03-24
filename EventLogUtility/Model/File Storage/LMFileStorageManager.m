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
#import "LMFileHelper.h"

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

#pragma mark - 
#pragma mark        create file storage
#pragma mark -

-(LMFileStorage *)createFileStorageWithURL:(NSURL *)absoluteURL error:(NSError *__autoreleasing *)outError
{
    if (absoluteURL == nil || absoluteURL.isFileURL == NO)
    {
        // invalid URL
        if (outError)
        {
            *outError = [LMError errorWithDescription:[NSString stringWithFormat:@"Invalid input URL:%@", absoluteURL.path]];
        }
        return nil;
    }
    
    if ([LMFileHelper fileExistsAtURL:absoluteURL] == NO)
    {
        if (outError)
        {
            *outError = [LMError errorWithDescription:[NSString stringWithFormat:@"File doesn't exist at URL:%@", absoluteURL.path]];
        }
        return nil;
    }
    
    LMFileStorage *fileStorage = [self fileStorageWithURL:absoluteURL];
    if (fileStorage != nil)
    {
        // already exist
        if (outError)
        {
            *outError = [LMError errorWithDescription:[NSString stringWithFormat:@"file at:%@ already opened", absoluteURL.path]];
        }
        return nil;
    }
    
    fileStorage = [[LMFileStorage alloc] initWithURL:absoluteURL
                                               error:outError];
    
    if (fileStorage == nil)
    {
        if (outError)
        {
            *outError = [LMError errorWithDescription:[NSString stringWithFormat:@"Can't load file at %@ for unknown reason", absoluteURL.path]];
        }
        return nil;
    }
    
    // add to dictionary
    [self addFileStorage:fileStorage];
    
    return fileStorage;
}

-(LMFileStorage *)createFileStorageFrom:(LMFileStorage *)aStorage
{
    if (aStorage == nil)
    {
        return nil;
    }
    
    LMFileStorage *fileStorage = [[LMFileStorage alloc] initFromStorage:aStorage];
    
    // add to dictionary
    [self addFileStorage:fileStorage];
    
    return fileStorage;
}


#pragma mark -
#pragma mark        file storage management
#pragma mark - 

-(LMFileStorage *)fileStorageWithUUID:(NSString *)uuid
{
    LMFileStorage *fileStorage = nil;
    
    if ([uuid length])
    {
        @synchronized(_lock)
        {
            fileStorage = [_fileContentDictionary objectForKey:uuid];
        }
    }
    return fileStorage;
}

-(LMFileStorage *)fileStorageWithURL:(NSURL *)absoluteURL
{
    if (absoluteURL && absoluteURL.isFileURL)
    {
        @synchronized(_lock)
        {
            for (LMFileStorage *fileStorage in _fileContentDictionary.allValues)
            {
                if (   fileStorage
                    && fileStorage.originURL
                    && [fileStorage.originURL.path isEqualToString:absoluteURL.path])
                {
                    return fileStorage;
                }
            }
        }
    }
    
    return nil;
}

-(NSArray *)fileStoragesReferToUUID:(NSString *)UUID
{
    NSMutableArray *retArray = [NSMutableArray array];
    
    if (UUID && UUID.length)
    {
        @synchronized(_lock)
        {
            for (LMFileStorage *fileStorage in _fileContentDictionary)
            {
                if (   fileStorage
                    && fileStorage.originUUID
                    && [fileStorage.originUUID isEqualToString:UUID])
                {
                    [retArray addObject:fileStorage];
                }
            }
        }
    }
    
    return [NSArray arrayWithArray:retArray];
}

-(NSArray *)fileStoragesReferToURL:(NSURL *)absoluteURL
{
    NSMutableArray *retArray = [NSMutableArray array];
    
    if (absoluteURL && absoluteURL.isFileURL)
    {
        @synchronized(_lock)
        {
            for (LMFileStorage *fileStorage in _fileContentDictionary)
            {
                if (    fileStorage
                    && fileStorage.originURL
                    && [fileStorage.originURL.path isEqualToString:absoluteURL.parameterString])
                {
                    [retArray addObject:fileStorage];
                }
            }
        }
    }
    
    return [NSArray arrayWithArray:retArray];
}

-(void)addFileStorage:(LMFileStorage *)fileStorage
{
    if (!fileStorage || ![fileStorage UUID] || ![[fileStorage UUID] length])
    {
        return;
    }
    LMFileStorage *exist = [self fileStorageWithUUID:fileStorage.UUID];
    if (exist)
    {
        // already exist
        return;
    }
    
    @synchronized(_lock)
    {
        [_fileContentDictionary setObject:fileStorage forKey:[fileStorage UUID]];
    }
}

-(void)_removeFileStorage:(LMFileStorage *)fileStorage
{
    if (!fileStorage || !fileStorage.UUID || !fileStorage.UUID.length)
    {
        return;
    }
    
    @synchronized(_lock)
    {
        [_fileContentDictionary removeObjectForKey:fileStorage.UUID];
    }
}

-(void)removeFileStorage:(LMFileStorage *)fileStoreage
{
    if (!fileStoreage || !fileStoreage.UUID || !fileStoreage.UUID.length)
    {
        return;
    }
    
    NSArray *referenceArray = [self fileStoragesReferToUUID:fileStoreage.UUID];
    for (LMFileStorage *aStorage in referenceArray)
    {
        [self _removeFileStorage:aStorage];
    }
    
    [self _removeFileStorage:fileStoreage];
}

-(void)removeFileStorageWithUUID:(NSString *)UUID
{
    LMFileStorage *fileStorage = [self fileStorageWithUUID:UUID];
    [self removeFileStorage:fileStorage];
}

-(void)removeAllFileStorageWithURL:(NSURL *)absoluteURL
{
    LMFileStorage *fileStorage = [self fileStorageWithURL:absoluteURL];
    [self removeFileStorage:fileStorage];
}

@end
