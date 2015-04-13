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

    if (self.environment.name) {
        NSString *environment = [self codeForValue:self.environment.name withKey:@"environment"];
        [codeChunks addObject:environment];
    }

    for (NSString *key in parameters.allKeys) {
        NSString *chunk = [self codeForValue:parameters[key] withKey:key];
        [codeChunks addObject:chunk];
    }
    return [codeChunks componentsJoinedByString:@"\n"];
}

- (NSString *)codeForValue:(NSString *)value withKey:(NSString *)key {
    NSString *format = @"- (NSString *)%@ { return @\"%@\"; }";
    NSString *method = [NSString stringWithFormat:format, key, value];
    return method;
}

@end
