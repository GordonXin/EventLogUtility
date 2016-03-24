//
//  EntranceDocument.m
//  EventLogUtility
//
//  Created by cynthia on 3/24/16.
//  Copyright © 2016 Sapphire. All rights reserved.
//

#import "EntranceDocument.h"
#import "DocumentController.h"

@implementation EntranceDocument

- (NSString *)windowNibName 
{
    return @"EntranceDocument";
}

- (void)windowControllerDidLoadNib:(NSWindowController *)aController
{
    [super windowControllerDidLoadNib:aController];
    
    [self setDisplayName:@"Event Log Utlity"];
}

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

+ (BOOL)autosavesInPlace
{
    return NO;
}

-(IBAction)userClickedOpenFileButton:(id)sender
{
    [[DocumentController sharedDocumentController] openDocument:nil];
}

@end
