//
//  LMFileTextViewController.h
//  EventLogUtility
//
//  Created by cynthia on 3/24/16.
//  Copyright © 2016 Sapphire. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "LMBaseViewController.h"

@interface LMFileTextViewController : LMBaseViewController

@property (nonatomic, readwrite, strong) IBOutlet NSTextView *textView;

@property (nonatomic, readwrite, strong) IBOutlet NSScrollView *scrollView;

@end
