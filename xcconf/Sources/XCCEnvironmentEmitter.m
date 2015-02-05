//
// Created by AlexDenisov on 06/02/15.
// Copyright (c) 2015 AlexDenisov. All rights reserved.
//

#import "XCCEnvironmentEmitter.h"
#import "XCCEnvironment.h"

@interface XCCEnvironmentEmitter ()

@property (strong) XCCEnvironment *environment;

@end

@implementation XCCEnvironmentEmitter

- (instancetype)initWithEnvironment:(XCCEnvironment *)environment {
    self = [super init];
    
    self.environment = environment;
    
    return self;
}

- (NSString *)emitCodeGen {
    NSDictionary *parameters = self.environment.parameters;
    NSMutableArray *codeChunks = [NSMutableArray new];
    for (NSString *key in parameters.allKeys) {
        NSString *format = @"- (NSString *)%@ { return @\"%@\"; }";
        NSString *method = [NSString stringWithFormat:format, key, parameters[key]];
        [codeChunks addObject:method];
    }
    return [codeChunks componentsJoinedByString:@"\n"];
}

@end
