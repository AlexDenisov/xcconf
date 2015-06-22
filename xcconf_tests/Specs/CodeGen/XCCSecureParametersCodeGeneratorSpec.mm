#import <Cedar/Cedar.h>
#import "XCCSecureParametersCodeGenerator.h"
#import "XCCEnvironment.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

static XCCEnvironment *environmentWithParameters(NSDictionary *parameters) {
    NSString *name = @"some_name";
    XCCEnvironment *environment = [[XCCEnvironment alloc] initWithName:name
                                                            parameters:parameters];
    return environment;
}

SPEC_BEGIN(XCCSecureParametersCodeGeneratorSpec)

describe(@"XCCSecureParametersCodeGenerator", ^{
    __block XCCSecureParametersCodeGenerator *subject;
    
    describe(@"emits code", ^{
        
        it(@"with one parmeter", ^{
            auto parameters = @{ @"key" : @"value" };
            auto env = environmentWithParameters(parameters);
            subject = [[XCCSecureParametersCodeGenerator alloc] initWithEnvironment:env];
            
            NSString *expectedCode = 
            @"- \(NSString *)environment { char s[10]; s[0] = 's'; s[1] = 'o'; s[2] = 'm'; s[3] = 'e'; s[4] = '_'; s[5] = 'n'; s[6] = 'a'; s[7] = 'm'; s[8] = 'e'; s[9] = 0x00; return @(s); }\n"
            @"- \(NSString *)key { char s[6]; s[0] = 'v'; s[1] = 'a'; s[2] = 'l'; s[3] = 'u'; s[4] = 'e'; s[5] = 0x00; return @(s); }";
            NSString *actualCode = [subject generateCode];
            
            actualCode should equal(expectedCode);
        });
        
        it(@"with multiple parameters", ^{
            auto parameters = @{ @"key0" : @"value0", @"key1" : @"value1" };
            auto env = environmentWithParameters(parameters);
            subject = [[XCCSecureParametersCodeGenerator alloc] initWithEnvironment:env];
            
            NSString *expectedCode = 
            @"- (NSString *)environment { char s[10]; s[0] = 's'; s[1] = 'o'; s[2] = 'm'; s[3] = 'e'; s[4] = '_'; s[5] = 'n'; s[6] = 'a'; s[7] = 'm'; s[8] = 'e'; s[9] = 0x00; return @(s); }\n"
            @"- (NSString *)key1 { char s[7]; s[0] = 'v'; s[1] = 'a'; s[2] = 'l'; s[3] = 'u'; s[4] = 'e'; s[5] = '1'; s[6] = 0x00; return @(s); }\n"
            @"- (NSString *)key0 { char s[7]; s[0] = 'v'; s[1] = 'a'; s[2] = 'l'; s[3] = 'u'; s[4] = 'e'; s[5] = '0'; s[6] = 0x00; return @(s); }";
            NSString *actualCode = [subject generateCode];
            
            actualCode should equal(expectedCode);
        });
        
    });
});

SPEC_END
