//
//  LMFileReader.h
//  EventLogUtility
//
//  Created by GordonXIn on 3/9/16.
//  Copyright © 2016 Sapphire. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LMErrorDifinition.h"


@interface LMFileReader : NSObject

-(NSString *)fileType;

-(LMResult *)checkFileFormat:(NSString *)fileString range:(NSRange)range;

-(LMResult *)numberOfLines:(NSString *)fileString range:(NSRange)range;

@end

