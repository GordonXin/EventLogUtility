//
//  LMFileReader.h
//  EventLogUtility
//
//  Created by GordonXIn on 3/9/16.
//  Copyright © 2016 Sapphire. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface LMFileReader : NSObject

// interfaces needs to overide
-(NSDictionary *)openFileOptions;

-(NSString *)fileType;

-(BOOL)examFormatOnFileHandle:(NSFileHandle *)fileHandle fromURL:(NSURL *)absoluteURL;

@end

