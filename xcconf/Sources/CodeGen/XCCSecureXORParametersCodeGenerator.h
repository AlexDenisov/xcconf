//
//  XCCSecureXORParametersCodeGenerator.h
//  xcconf
//
//  Created by Aleksei Shevchenko on 06/07/15.
//  Copyright (c) 2015 Aleksei Shevchenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XCCSecureParametersCodeGenerator.h"

@interface XCCSecureXORParametersCodeGenerator : XCCSecureParametersCodeGenerator

/**
* cypherKey is optional, if not set, random key will be generated for each value
**/
- (instancetype)initWithEnvironment:(XCCEnvironment *)environment cypherKey:(NSData*)cypherKey;

@end
