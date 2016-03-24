//
//  DocumentController.m
//  EventLogUtility
//
//  Created by cynthia on 3/24/16.
//  Copyright © 2016 Sapphire. All rights reserved.
//

#import "DocumentController.h"
#import "EntranceDocument.h"
#import "LMErrorDifinition.h"
#import "LMLog.h"
#import "LMFileHelper.h"
#import "LMFileReaderFactory.h"
#import "Document.h"


static NSString * const kLMOpenPanelDefaultPathKey = @"EventLogUtility.Defaults.OpenPanel.StartPath";
NSString * const kLMSavePanelDefaultPathKey = @"EventLogUtility.Defaults.SavePanel.StartPath";
static NSString * const kLMCAMLogPath = @"/vault/cCAM/Tools/Logs";

@implementation DocumentController

-(NSDocument *)openUntitledDocumentAndDisplay:(BOOL)displayDocument error:(NSError * _Nullable __autoreleasing *)outError
{
    EntranceDocument *aDocument = nil;
    NSArray *existed = [self EntranceDocuments];
    if (existed && existed.count > 0)
    {
        aDocument = [existed objectAtIndex:0];
    }
    
    if (aDocument == nil)
    {
        aDocument = [[EntranceDocument alloc] init];
        
        if (aDocument == nil)
        {
            if (outError)
            {
                *outError = [LMError errorWithDescription:[NSString stringWithFormat:@"%@ can't create instance for 'EntranceDocuments'", LOCATOR]];
            }
            return nil;
        }
    }
    
    if (displayDocument)
    {
        [aDocument makeWindowControllers];
        [aDocument showWindows];
    }
    
    [self addDocument:aDocument];
    
    return aDocument;
}

-(NSArray *)EntranceDocuments
{
    NSMutableArray *documentArray = [NSMutableArray array];
    
    for (NSDocument *aDocument in [self documents])
    {
        if ([aDocument isKindOfClass:[EntranceDocument class]])
        {
            [documentArray addObject:aDocument];
        }
    }
    return [NSArray arrayWithArray:documentArray];
}

-(void)addDocument:(NSDocument *)document
{
    NSArray *uselessDocumentArray = [self EntranceDocuments];
    
    for (NSDocument *aDocument in uselessDocumentArray)
    {
        if (aDocument)
        {
            [self removeDocument:aDocument];
        }
    }
    
    [super addDocument:document];
}

-(NSURL *)defaultOpenFilePath
{
    NSURL *url = [[NSUserDefaults standardUserDefaults] URLForKey:kLMOpenPanelDefaultPathKey];
    if (url != nil && url.isFileURL)
    {
        if ([LMFileHelper directoryExistAtURL:url])
        {
            return url;
        }
    }
    
    url = [NSURL fileURLWithPath:kLMCAMLogPath isDirectory:YES];
    if ([LMFileHelper directoryExistAtURL:url])
    {
        [[NSUserDefaults standardUserDefaults] setURL:url forKey:kLMOpenPanelDefaultPathKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        return url;
    }
    
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDesktopDirectory, NSUserDomainMask, YES);
    if (path && path.count > 0)
    {
        url = [NSURL fileURLWithPath:[path objectAtIndex:0] isDirectory:YES];
        if ([LMFileHelper directoryExistAtURL:url])
        {
            [[NSUserDefaults standardUserDefaults] setURL:url forKey:kLMOpenPanelDefaultPathKey];
            [[NSUserDefaults standardUserDefaults] synchronize];
            return url;
        }
    }
    
    return [NSURL fileURLWithPath:@"/" isDirectory:YES];
}

-(NSURL *)defaultSaveFilePath
{
    NSURL *url = [[NSUserDefaults standardUserDefaults] URLForKey:kLMSavePanelDefaultPathKey];
    if ([LMFileHelper directoryExistAtURL:url])
    {
        return url;
    }
    
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDesktopDirectory, NSUserDomainMask, YES);
    if (path && path.count > 0)
    {
        url = [NSURL fileURLWithPath:[path objectAtIndex:0] isDirectory:YES];
        if ([LMFileHelper directoryExistAtURL:url])
        {
            [[NSUserDefaults standardUserDefaults] setURL:url forKey:kLMSavePanelDefaultPathKey];
            [[NSUserDefaults standardUserDefaults] synchronize];
            return url;
        }
    }
    
    return [NSURL fileURLWithPath:@"/" isDirectory:YES];
}

-(void)beginOpenPanel:(NSOpenPanel *)openPanel
             forTypes:(NSArray<NSString *> *)inTypes
    completionHandler:(void (^)(NSInteger))completionHandler
{
    NSURL *url = [self defaultOpenFilePath]; // return value can be trusted
    
    [openPanel setCanChooseFiles:YES];
    [openPanel setCanChooseDirectories:NO];
    
    [openPanel setAllowsMultipleSelection:YES];
    [openPanel setAllowedFileTypes:[LMFileReaderFactory allowedFileTypes]];
    [openPanel setAllowsOtherFileTypes:NO];
    
    [openPanel setTitle:@"Please select file(s)"];
    [openPanel setPrompt:@"Choose"];
    [openPanel setCanCreateDirectories:YES];
    [openPanel setShowsHiddenFiles:NO];
    
    [openPanel setDirectoryURL:url];
    
    NSInteger ret = [openPanel runModal];
    if (ret == NSFileHandlingPanelOKButton)
    {
        NSURL *selected = [[openPanel URLs] objectAtIndex:0];
        NSURL *new = [selected URLByDeletingLastPathComponent];
        if (new && new.isFileURL && [new.path isEqualToString:url.path] == NO)
        {
            [[NSUserDefaults standardUserDefaults] setURL:new forKey:kLMOpenPanelDefaultPathKey];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    }
    
    if (completionHandler)
    {
        completionHandler(ret);
    }
}

@end
