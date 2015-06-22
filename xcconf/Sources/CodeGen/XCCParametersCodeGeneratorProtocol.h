//
//  XCCParametersCodeGeneratorProtocol.h
//  xcconf
//
//  Created by AlexDenisov on 22/06/15.
//  Copyright (c) 2015 AlexDenisov. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XCCEnvironment;

@protocol XCCParametersCodeGeneratorProtocol <NSObject>

- (instancetype)initWithEnvironment:(XCCEnvironment *)environment;
- (NSString *)generateCode;

@end
