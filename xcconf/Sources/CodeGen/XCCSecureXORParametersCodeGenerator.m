//
//  XCCSecureXORParametersCodeGenerator.m
//  xcconf
//
//  Created by Aleksei Shevchenko on 06/07/15.
//  Copyright (c) 2015 Aleksei Shevchenko. All rights reserved.
//

#import "XCCSecureXORParametersCodeGenerator.h"
#import "XCCEnvironment.h"
#include <stdlib.h>
#include <stdint.h>

@interface XCCSecureXORParametersCodeGenerator ()
///Static cypher key, if not set, new key will be generated for each value
@property (strong) NSData * cypherKey;
@end

@implementation XCCSecureXORParametersCodeGenerator

- (instancetype)initWithEnvironment:(XCCEnvironment *)environment cypherKey:(NSData*)cypherKey{
    self = [super initWithEnvironment:environment];
    
    self.cypherKey = cypherKey;
    
    return self;
}

- (NSString *)codeForValue:(NSString *)value withKey:(NSString *)key {
    NSString *format = @"#pragma clang optimize off\n- (NSString *)%@ { %@ }";
    NSString *encryptedBody = [self encryptBody:value];
    NSString *method = [NSString stringWithFormat:format, key, encryptedBody];
    return method;
}


- (NSString *)encryptBody:(NSString *)value {
    const char *rawValue = value.UTF8String;
    const unsigned long valueLength = strlen(rawValue);
    NSData * cypher = (self.cypherKey && self.cypherKey.length) ? self.cypherKey: [self generateCypherKey];
    const char * cypherBytes = cypher.bytes;
    
    NSMutableString *encryptedValue = [NSMutableString new];
    for (unsigned long i = 0; i < valueLength; i++) {
        const char cypherByte = *(cypherBytes + (i % cypher.length));
        NSString *encryptedCharacter = [NSString stringWithFormat:@"s[%lu] = %luul ^ %luul; ", i, (unsigned long)rawValue[i]^cypherByte, (unsigned long)cypherByte];
        [encryptedValue appendString:encryptedCharacter];
    }
    NSString *encryptedCharacter = [NSString stringWithFormat:@"s[%lu] = 0x00; ", valueLength];
    [encryptedValue appendString:encryptedCharacter];
    
    return [NSString stringWithFormat:@"char s[%lu]; %@return @(s);", valueLength + 1, encryptedValue];
}

- (NSData*) generateCypherKey {
    arc4random_stir();
    const int cypherLength = 32;
    char iv[cypherLength];
    arc4random_buf(&iv, cypherLength);
    return [[NSData alloc] initWithBytes:&iv length:cypherLength];
}


@end
