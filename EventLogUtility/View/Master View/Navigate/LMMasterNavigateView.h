//
//  LMMasterNavigateView.h
//  EventLogUtility
//
//  Created by cynthia on 3/28/16.
//  Copyright © 2016 Sapphire. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "LMBaseView.h"

@interface LMMasterNavigateView : LMBaseView

-(void)setAction:(SEL)action target:(id)target forKey:(NSString *)key;

@end
