//
//  XCCSecureParametersCodeGenerator.m
//  xcconf
//
//  Created by AlexDenisov on 22/06/15.
//  Copyright (c) 2015 AlexDenisov. All rights reserved.
//

#import "XCCSecureParametersCodeGenerator.h"
#import "XCCEnvironment.h"

@interface XCCSecureParametersCodeGenerator ()

@property (strong) XCCEnvironment *environment;

@end

@implementation XCCSecureParametersCodeGenerator

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
    NSString *format = @"- (NSString *)%@ { %@ }";
    NSString *encryptedBody = [self encryptBody:value];
    NSString *method = [NSString stringWithFormat:format, key, encryptedBody];
    return method;
}

- (NSString *)encryptBody:(NSString *)value {
    const char *rawValue = value.UTF8String;
    const unsigned long valueLength = strlen(rawValue);
    
    NSMutableString *encryptedValue = [NSMutableString new];
    for (unsigned long i = 0; i < valueLength; i++) {
        NSString *encryptedCharacter = [NSString stringWithFormat:@"s[%lu] = '%c'; ", i, rawValue[i]];
        [encryptedValue appendString:encryptedCharacter];
    }
    NSString *encryptedCharacter = [NSString stringWithFormat:@"s[%lu] = 0x00; ", valueLength];
    [encryptedValue appendString:encryptedCharacter];
    
    return [NSString stringWithFormat:@"char s[%lu]; %@return @(s);", valueLength + 1, encryptedValue];
}

@end
