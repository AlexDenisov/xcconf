//
// Created by AlexDenisov on 06/02/15.
// Copyright (c) 2015 AlexDenisov. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XCCConfig;

@interface XCCConfigCodeEmitter : NSObject

- (instancetype)initWithConfig:(XCCConfig *)config environmentName:(NSString *)environmentName;
- (NSString *)emitCodeGen;

@end
