//
//  AppDelegate.m
//  EventLogUtility
//
//  Created by GordonXIn on 3/9/16.
//  Copyright © 2016 Sapphire. All rights reserved.
//

#import "AppDelegate.h"
#import "DocumentController.h"
#import "LMFileStorageManager.h"

@interface AppDelegate ()

@property (nonatomic, readwrite, weak) IBOutlet NSWindow *mainWindow;

@end

@implementation AppDelegate

-(instancetype)init
{
    if (self = [super init])
    {
        // register custom Document Controller
        [DocumentController sharedDocumentController];
        
        // init file storage manager
        [LMFileStorageManager sharedManager];
    }
    return self;
}

-(BOOL)applicationShouldOpenUntitledFile:(NSApplication *)sender
{
    // untitled document will be used as a convinient entrance
    return YES;
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    [_mainWindow.windowController close];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification
{
    // Insert code here to tear down your application
}

@end
