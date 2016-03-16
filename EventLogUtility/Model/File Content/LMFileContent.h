//
//  LMFileContent.h
//  EventLogUtility
//
//  Created by GordonXIn on 3/9/16.
//  Copyright © 2016 Sapphire. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>

@interface LMFileContent : NSObject

@property (nonatomic, readwrite, assign) BOOL            isMutable;

@property (nonatomic, readwrite, copy)   NSString       *contentUUID;

@property (nonatomic, readwrite, copy)   NSString       *originUUID;

@property (nonatomic, readwrite, copy)   NSURL          *absoluteURL;

@property (nonatomic, readwrite, copy)   NSString       *fileType;

@property (nonatomic, readwrite, strong) NSTextStorage  *textStorage;

// init methods
-(instancetype)init;
-(instancetype)initWithURL:(NSURL *)absoluteURL options:(NSDictionary *)options error:(NSError *__autoreleasing*)outError;

@end
