//
//  ColorUtility
//  EventLogUtility
//
//  Created by GordonXIn on 3/9/16.
//  Copyright © 2016 Sapphire. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "LMColorUtlity.h"

@implementation LMColorUtlity

+(NSColor *)commonBackgroundColor
{
    return [NSColor colorWithCalibratedRed:0.910 green:0.906 blue:0.914 alpha:1.000];
}

+(NSColor *)commonBorderColor
{
    return [NSColor colorWithCalibratedRed:0.7 green:0.7 blue:0.7 alpha:1.0];
}

@end

