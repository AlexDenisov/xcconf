//
// Created by AlexDenisov on 06/02/15.
// Copyright (c) 2015 AlexDenisov. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XCCYAMLConfiguration;
@class XCCDiagnosticsEngine;

@interface XCCConfigurationCodeGenerator : NSObject

@property (nonatomic, strong) XCCDiagnosticsEngine *diagnosticEngine;

- (instancetype)initWithConfig:(XCCYAMLConfiguration *)config environmentName:(NSString *)environmentName;
- (NSString *)generateCode;

@end
