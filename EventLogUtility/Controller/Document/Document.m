//
//  Document.m
//  EventLogUtility
//
//  Created by GordonXIn on 3/9/16.
//  Copyright © 2016 Sapphire. All rights reserved.
//

#import "Document.h"
#import "DocumentController.h"
#import "LMLog.h"
#import "LMFileHelper.h"
#import "LMErrorDifinition.h"
#import "LMFileStorageManager.h"
#import "LMFileStorage.h"
#import "LMDocumentViewController.h"


@interface Document () <NSWindowDelegate>

@property (nonatomic, readwrite, strong) IBOutlet LMDocumentViewController *viewController;

@end

@implementation Document

#pragma mark -
#pragma mark        settings
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


#pragma mark -
#pragma mark        file content accessing
#pragma mark -

- (NSData *)dataOfType:(NSString *)typeName error:(NSError **)outError
{
    if (outError)
    {
        *outError = [NSError errorWithDomain:NSOSStatusErrorDomain code:unimpErr userInfo:nil];
    }
    return nil;
}

- (BOOL)readFromData:(NSData *)data ofType:(NSString *)typeName error:(NSError **)outError
{
    if (outError)
    {
        *outError = [NSError errorWithDomain:NSOSStatusErrorDomain code:unimpErr userInfo:nil];
    }
    return NO;
}

-(BOOL)readFromURL:(NSURL *)url ofType:(NSString *)typeName error:(NSError * _Nullable __autoreleasing *)outError
{
    if ([LMFileHelper fileExistsAtURL:url] == NO)
    {
        if (outError)
        {
            *outError = [LMError errorWithDescription:[NSString stringWithFormat:@"%@ file doesn't exist at %@", LOCATOR, url]];
        }
        return NO;
    }
    
    if ([[NSFileManager defaultManager] isReadableFileAtPath:url.path] == NO)
    {
        if (outError)
        {
            *outError = [LMError errorWithDescription:[NSString stringWithFormat:@"%@ file isn't readable at %@", LOCATOR, url]];
        }
        return NO;
    }
    
    LMFileStorage *aStorage = [[LMFileStorageManager sharedManager] createFileStorageWithURL:url error:outError];
    if (aStorage == nil)
    {
        if (outError && *outError == nil)
        {
            *outError = [LMError errorWithDescription:[NSString stringWithFormat:@"%@ LMFileStorageManger can't create instance for file at %@", LOCATOR, url]];
        }
        return NO;
    }
    
    _documentUUID = aStorage.UUID;
    
    return YES;
}


#pragma mark -
#pragma mark        User Interface
#pragma mark -

-(NSString *)windowNibName
{
    return @"DocumentWindow";
}

- (void)windowControllerDidLoadNib:(NSWindowController *)aController
{
    _fileStorageArray = @[@"1231"];
    
    [super windowControllerDidLoadNib:aController];
    
    [self.viewController view];
    [self.viewController loadViewForDocument:self];
    
}


#pragma mark -
#pragma mark        Window Delegate
#pragma mark -

-(void)windowWillClose:(NSNotification *)notification
{
    // window will close soon
    // release all file storage attached
    [self.viewController unloadView];
}

@end
