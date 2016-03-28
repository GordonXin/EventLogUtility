//
//  LMMasterNavigateView.h
//  EventLogUtility
//
//  Created by cynthia on 3/28/16.
//  Copyright © 2016 Sapphire. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "LMBaseView.h"

@interface LMMasterNavigateButton : NSButton

-(instancetype)initWithName:(NSString *)buttonName
                      image:(NSString *)buttonImage
                     action:(SEL)action
                     target:(id)target;

-(instancetype)initWithName:(NSString *)buttonName
                      image:(NSString *)buttonImage
                     action:(SEL)action
                     target:(id)target
              imagePosition:(NSCellImagePosition)imagePositon;

@end

@interface LMMasterNavigateView : LMBaseView

@property (nonatomic, readwrite, assign) NSTextLayoutOrientation orientation;

-(void)setButtons:(NSArray *)buttonArray;

-(NSString *)currentSelected;

@end
