//
//  LMFile.m
//  EventLogUtility
//
//  Created by GordonXIn on 3/9/16.
//  Copyright © 2016 Sapphire. All rights reserved.
//

#import "LMFileStorage.h"

@interface LMFileStorage ()

@end

@implementation LMFileStorage

#pragma mark -
#pragma mark        init methods
#pragma mark -
-(instancetype)init
{
    NSTextStorage *storage = [[NSTextStorage alloc] initWithString:@""];
    
    if (self = [super init])
    {
        [self commonInit:storage];
    }
    return self;
}

-(instancetype)initWithURL:(NSURL *)absoluteURL options:(NSDictionary *)options error:(NSError *__autoreleasing*)outError
{
    NSTextStorage *storage = nil;
    
    @try
    {
        storage = [[NSTextStorage alloc] initWithURL:absoluteURL
                                             options:options
                                  documentAttributes:nil
                                               error:outError];
    }
    @catch (NSException *exception)
    {
        return nil;
    }
    
    if (self = [super init])
    {
        [self commonInit:storage];
        
        _absoluteURL = [absoluteURL copy];
    }
    return self;
}

-(void)commonInit:(NSTextStorage *)textStorage
{
    _isMutable = YES;
    
    _contentUUID = [[NSUUID UUID] UUIDString];
    _originUUID = @"";
    _fileType = @"";
    _textStorage = textStorage;
    _absoluteURL = [NSURL URLWithString:@""];
}

@end
