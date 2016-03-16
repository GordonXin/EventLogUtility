//
//  Document.m
//  EventLogUtility
//
//  Created by GordonXIn on 3/9/16.
//  Copyright © 2016 Sapphire. All rights reserved.
//

#import "Document.h"
#import "LMDocumentWindowController.h"

@interface Document ()

@end

@implementation Document

#pragma mark -
#pragma mark        init methods
#pragma mark -
- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _documentUUID = [[NSUUID UUID] UUIDString];
    }
    return self;
}

#pragma mark -
#pragma mark        loading views
#pragma mark -
-(void)makeWindowControllers
{
    LMDocumentWindowController *aController = [[LMDocumentWindowController alloc] init];
    if (aController)
    {
        [aController loadForDocument:self.documentUUID];
        [self addWindowController:aController];
    }
}

#pragma mark -
#pragma mark        editing
#pragma mark -
+ (BOOL)autosavesInPlace
{
    return NO;
}

-(BOOL)isEntireFileLoaded
{
    // return No here to prevent readFromData: get called
    return NO;
}

- (NSData *)dataOfType:(NSString *)typeName error:(NSError **)outError
{
    // Insert code here to write your document to data of the specified type. If outError != NULL, ensure that you create and set an appropriate error when returning nil.
    // You can also choose to override -fileWrapperOfType:error:, -writeToURL:ofType:error:, or -writeToURL:ofType:forSaveOperation:originalContentsURL:error: instead.
    [NSException raise:@"UnimplementedMethod" format:@"%@ is unimplemented", NSStringFromSelector(_cmd)];
    return nil;
}

- (BOOL)readFromData:(NSData *)data ofType:(NSString *)typeName error:(NSError **)outError {
    // Insert code here to read your document from the given data of the specified type. If outError != NULL, ensure that you create and set an appropriate error when returning NO.
    // You can also choose to override -readFromFileWrapper:ofType:error: or -readFromURL:ofType:error: instead.
    // If you override either of these, you should also override -isEntireFileLoaded to return NO if the contents are lazily loaded.
    [NSException raise:@"UnimplementedMethod" format:@"%@ is unimplemented", NSStringFromSelector(_cmd)];
    return YES;
}

@end
