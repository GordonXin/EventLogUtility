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

-(NSDictionary *)defaultOpenFileOptions
{
    return @{
             NSCharacterEncodingDocumentOption : [NSNumber numberWithUnsignedInt:(unsigned int)NSUTF8StringEncoding],
             NSDocumentTypeDocumentOption : NSPlainTextDocumentType,
             };
}

#pragma mark - 
#pragma mark        create file storage
#pragma mark -
-(LMFileStorage *)createFileStorageWithURL:(NSURL *)absoluteURL error:(NSError *__autoreleasing *)outError
{
    LMFileStorage *fileStorage = [self fileStorageWithURL:absoluteURL];
    if (fileStorage)
    {
        // already exist
        return fileStorage;
    }
    
    fileStorage = [[LMFileStorage alloc] initWithURL:absoluteURL
                                             options:[self defaultOpenFileOptions]
                                               error:outError];
    
    if (!fileStorage)
    {
        if (*outError)
        {
            *outError = [NSError errorWithDomain:kLMErrorDomainName
                                            code:kLMErrorCodeUnknown.integerValue
                                        userInfo:@{NSLocalizedDescriptionKey : [NSString stringWithFormat:@"Can't load file at %@ for unknown reason", absoluteURL]}];
        }
        return nil;
    }
    
    // add to dictionary
    [self addFileStorage:fileStorage];
    
    return fileStorage;
}

-(LMFileStorage *)createFileStorageFrom:(LMFileStorage *)fileStorage
{
    if (fileStorage == nil)
    {
        return nil;
    }
    
    LMFileStorage *ret = [[LMFileStorage alloc] initFromParent:fileStorage];
    
    // add to dictionary
    [self addFileStorage:ret];
    
    return ret;
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
    if (!absoluteURL || ![absoluteURL.path length])
    {
        return nil;
    }
    
    @synchronized(_lock)
    {
        for (LMFileStorage *fileStorage in _fileContentDictionary.allValues)
        {
            if (   fileStorage
                && fileStorage.parentURL
                && [fileStorage.parentURL.path isEqualToString:absoluteURL.path])
            {
                return fileStorage;
            }
        }
    }
    return nil;
}

-(NSArray *)fileStoragesReferToUUID:(NSString *)UUID
{
    if (!UUID || !UUID.length)
    {
        return [NSArray array];
    }
    
    NSMutableArray *retArray = [NSMutableArray array];
    
    @synchronized(_lock)
    {
        for (LMFileStorage *fileStorage in _fileContentDictionary)
        {
            if (   fileStorage
                && fileStorage.parentUUID
                && [fileStorage.parentUUID isEqualToString:UUID])
            {
                [retArray addObject:fileStorage];
            }
        }
    }
    
    return [NSArray arrayWithArray:retArray];
}

-(NSArray *)fileStoragesReferToURL:(NSURL *)absoluteURL
{
    if (!absoluteURL || !absoluteURL.path || !absoluteURL.path.length)
    {
        return [NSArray array];
    }
    
    NSMutableArray *retArray = [NSMutableArray array];
    
    @synchronized(_lock)
    {
        for (LMFileStorage *fileStorage in _fileContentDictionary)
        {
            if (    fileStorage
                && fileStorage.parentURL
                && [fileStorage.parentURL.path isEqualToString:absoluteURL.parameterString])
            {
                [retArray addObject:fileStorage];
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
    
    if (fileStoreage.isMutable == NO)
    {
        NSArray *referenceArray = [self fileStoragesReferToUUID:fileStoreage.UUID];
        for (LMFileStorage *aStorage in referenceArray)
        {
            [self _removeFileStorage:aStorage];
        }
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
