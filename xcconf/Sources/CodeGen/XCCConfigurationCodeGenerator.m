//
// Created by AlexDenisov on 06/02/15.
// Copyright (c) 2015 AlexDenisov. All rights reserved.
//

#import "XCCConfigurationCodeGenerator.h"
#import "XCCParametersCodeGeneratorProtocol.h"
#import "XCCParametersCodeGenerator.h"
#import "XCCSecureParametersCodeGenerator.h"
#import "XCCSecureXORParametersCodeGenerator.h"
#import "XCCYAMLConfiguration.h"
#import "XCCDiagnosticsEngine.h"

@interface XCCConfigurationCodeGenerator ()

@property (strong) XCCYAMLConfiguration *config;
@property (copy) NSString *environmentName;
@property BOOL secure;
@property BOOL paranoid;

@end

@implementation XCCConfigurationCodeGenerator

- (instancetype)initWithConfig:(XCCYAMLConfiguration *)config environmentName:(NSString *)environmentName {
    return [self initWithConfig:config environmentName:environmentName secureMode:NO];
}

- (instancetype)initWithConfig:(XCCYAMLConfiguration *)config environmentName:(NSString *)environmentName secureMode:(BOOL)isSecureMode {
    return [self initWithConfig:config environmentName:environmentName secureMode:isSecureMode paranoidMode:NO];
}

- (instancetype)initWithConfig:(XCCYAMLConfiguration *)config environmentName:(NSString *)environmentName secureMode:(BOOL)isSecureMode paranoidMode:(BOOL)isParanoidMode {
    self = [super init];
    
    self.config = config;
    self.environmentName = environmentName;
    self.secure = isSecureMode;
    self.paranoid = isParanoidMode;
    
    return self;
}


- (NSString *)generateCode {
    NSMutableString *code = [NSMutableString new];
    
    [code appendString:self.import];
    [code appendString:self.interface];
    [code appendString:self.implementation];
    [code appendString:self.parameters];
    [code appendString:self.end];

    return [code copy];
}

- (NSString *)parameters {
    XCCEnvironment *environment = self.config[self.environmentName];
    if (!environment) {
        NSString *error = [NSString stringWithFormat:@"'%@' not found at config file",
                           self.environmentName];
        [self.diagnosticEngine criticalError:error];
    }
    id<XCCParametersCodeGeneratorProtocol> codeGen = [self codeGenWithEnvironment:environment];
    NSString *code = [codeGen generateCode];
    if (code.length) {
        code = [code stringByAppendingString:@"\n"];
    }
    
    return code;
}

- (id<XCCParametersCodeGeneratorProtocol>)codeGenWithEnvironment:(XCCEnvironment *)environment {
    if (self.secure) {
        return [[XCCSecureParametersCodeGenerator alloc] initWithEnvironment:environment];
    } else if (self.paranoid) {
        return [[XCCSecureXORParametersCodeGenerator alloc] initWithEnvironment:environment];
    } else {
        return [[XCCParametersCodeGenerator alloc] initWithEnvironment:environment];    
    }
}

- (NSString *)import {
    return @"#import <Foundation/Foundation.h>\n";
}

- (NSString *)interface {
    return [NSString stringWithFormat:@"@interface %@ : NSObject @end\n", self.config.principalClassName];
}

- (NSString *)implementation {
    return [NSString stringWithFormat:@"@implementation %@\n", self.config.principalClassName];
}

- (NSString *)end {
    return @"@end\n";
}

@end
