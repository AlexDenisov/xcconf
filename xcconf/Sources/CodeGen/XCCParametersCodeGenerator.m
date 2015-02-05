//
// Created by AlexDenisov on 06/02/15.
// Copyright (c) 2015 AlexDenisov. All rights reserved.
//

#import "XCCParametersCodeGenerator.h"
#import "XCCEnvironment.h"

@interface XCCParametersCodeGenerator ()

@property (strong) XCCEnvironment *environment;

@end

@implementation XCCParametersCodeGenerator

- (instancetype)initWithEnvironment:(XCCEnvironment *)environment {
    self = [super init];
    
    self.environment = environment;
    
    return self;
}

- (NSString *)generateCode {
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
