//
// Created by AlexDenisov on 06/02/15.
// Copyright (c) 2015 AlexDenisov. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XCCEnvironment;

@interface XCCEnvironmentEmitter : NSObject

- (instancetype)initWithEnvironment:(XCCEnvironment *)environment;
- (NSString *)emitCodeGen;

@end
