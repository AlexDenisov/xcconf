//
//  XCCDriverOptions.h
//  xcconf
//
//  Created by AlexDenisov on 22/06/15.
//  Copyright (c) 2015 AlexDenisov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XCCDriverOptions : NSObject

@property (copy) NSString *inputPath;
@property (copy) NSString *outputPath;
@property (copy) NSString *configurationName;
@property BOOL isSecure;
@property BOOL isParanoid;

@end
