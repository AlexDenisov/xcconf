//
// Created by AlexDenisov on 06/02/15.
// Copyright (c) 2015 AlexDenisov. All rights reserved.
//

#import "XCCConfigCodeEmitter.h"
#import "XCCConfig.h"

@interface XCCConfigCodeEmitter ()

@property (strong) XCCConfig *config;
@property (copy) NSString *environmentName;

@end

@implementation XCCConfigCodeEmitter

- (instancetype)initWithConfig:(XCCConfig *)config environmentName:(NSString *)environmentName {
    self = [super init];
    
    self.config = config;
    self.environmentName = environmentName;
    
    return self;
}

- (NSString *)emitCodeGen {
    NSMutableString *code = [NSMutableString new];
    
    [code appendString:self.import];
    [code appendString:self.interface];
    [code appendString:self.implementation];
    [code appendString:self.end];
    
    return [code copy];
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
