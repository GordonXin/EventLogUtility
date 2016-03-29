//
//  LMFileStorage.h
//  EventLogUtility
//
//  Created by GordonXIn on 3/9/16.
//  Copyright © 2016 Sapphire. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>

@class LMFileReader;

@interface LMFileStorage : NSObject

@property (nonatomic, readonly, assign) BOOL                alowsWriting;

@property (nonatomic, readonly, copy)   NSString            *UUID;

@property (nonatomic, readonly, copy)   NSString            *prettyName;

@property (nonatomic, readonly, strong) NSTextStorage       *textStorage;

@property (nonatomic, readonly, copy)   NSDictionary        *fileAttributes;

@property (nonatomic, readonly, copy)   NSString            *originUUID;

@property (nonatomic, readonly, copy)   NSURL               *originURL;

@property (nonatomic, readonly, strong) LMFileReader        *reader;

// init methods
-(instancetype)initWithURL:(NSURL *)absoluteURL error:(NSError *__autoreleasing*)outError;

-(instancetype)initFromStorage:(LMFileStorage *)aStorage;

@end
