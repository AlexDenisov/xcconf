//
// Created by AlexDenisov on 06/02/15.
// Copyright (c) 2015 AlexDenisov. All rights reserved.
//

#import "XCCConfigurationCodeGenerator.h"
#import "XCCParametersCodeGenerator.h"
#import "XCCYAMLConfiguration.h"

@interface XCCConfigurationCodeGenerator ()

@property (strong) XCCYAMLConfiguration *config;
@property (copy) NSString *environmentName;

@end

@implementation XCCConfigurationCodeGenerator

- (instancetype)initWithConfig:(XCCYAMLConfiguration *)config environmentName:(NSString *)environmentName {
    self = [super init];
    
    self.config = config;
    self.environmentName = environmentName;
    
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
    XCCParametersCodeGenerator *codeGen = [[XCCParametersCodeGenerator alloc] initWithEnvironment:environment];
    NSString *code = [codeGen generateCode];
    if (code.length) {
        code = [code stringByAppendingString:@"\n"];
    }
    
    return code;
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
