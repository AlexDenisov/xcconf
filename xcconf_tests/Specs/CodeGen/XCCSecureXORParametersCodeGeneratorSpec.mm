#import <Cedar/Cedar.h>
#import "XCCSecureXORParametersCodeGenerator.h"
#import "XCCEnvironment.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

static XCCEnvironment *environmentWithParameters(NSDictionary *parameters) {
    NSString *name = @"some_name";
    XCCEnvironment *environment = [[XCCEnvironment alloc] initWithName:name
                                                            parameters:parameters];
    return environment;
}

SPEC_BEGIN(XCCSecureXORParametersCodeGeneratorSpec)

describe(@"XCCSecureXORParametersCodeGenerator", ^{
    __block XCCSecureXORParametersCodeGenerator *subject;
    
    describe(@"emits code", ^{
        
        it(@"with one parmeter", ^{
            auto parameters = @{ @"key" : @"value" };
            auto env = environmentWithParameters(parameters);
            NSData * cypher = [@"secret_key" dataUsingEncoding:NSUTF8StringEncoding];
            subject = [[XCCSecureXORParametersCodeGenerator alloc] initWithEnvironment:env cypherKey:cypher];
            
            NSString *expectedCode = 
            @"#pragma clang optimize off\n- \(NSString *)environment { char s[10]; s[0] = 0ul ^ 115ul; s[1] = 10ul ^ 101ul; s[2] = 14ul ^ 99ul; s[3] = 23ul ^ 114ul; s[4] = 58ul ^ 101ul; s[5] = 26ul ^ 116ul; s[6] = 62ul ^ 95ul; s[7] = 6ul ^ 107ul; s[8] = 0ul ^ 101ul; s[9] = 0x00; return @(s); }\n"
            @"#pragma clang optimize off\n- \(NSString *)key { char s[6]; s[0] = 5ul ^ 115ul; s[1] = 4ul ^ 101ul; s[2] = 15ul ^ 99ul; s[3] = 7ul ^ 114ul; s[4] = 0ul ^ 101ul; s[5] = 0x00; return @(s); }";
            NSString *actualCode = [subject generateCode];
            
            actualCode should equal(expectedCode);
        });
        
        it(@"with multiple parameters", ^{
            auto parameters = @{ @"key0" : @"value0", @"key1" : @"value1" };
            auto env = environmentWithParameters(parameters);
            NSData * cypher = [@"another_secret_key" dataUsingEncoding:NSUTF8StringEncoding];
            subject = [[XCCSecureXORParametersCodeGenerator alloc] initWithEnvironment:env cypherKey:cypher];
            
            NSString *expectedCode = 
            @"#pragma clang optimize off\n- (NSString *)environment { char s[10]; s[0] = 18ul ^ 97ul; s[1] = 1ul ^ 110ul; s[2] = 2ul ^ 111ul; s[3] = 17ul ^ 116ul; s[4] = 55ul ^ 104ul; s[5] = 11ul ^ 101ul; s[6] = 19ul ^ 114ul; s[7] = 50ul ^ 95ul; s[8] = 22ul ^ 115ul; s[9] = 0x00; return @(s); }\n"
            "#pragma clang optimize off\n- (NSString *)key1 { char s[7]; s[0] = 23ul ^ 97ul; s[1] = 15ul ^ 110ul; s[2] = 3ul ^ 111ul; s[3] = 1ul ^ 116ul; s[4] = 13ul ^ 104ul; s[5] = 84ul ^ 101ul; s[6] = 0x00; return @(s); }\n"
            "#pragma clang optimize off\n- (NSString *)key0 { char s[7]; s[0] = 23ul ^ 97ul; s[1] = 15ul ^ 110ul; s[2] = 3ul ^ 111ul; s[3] = 1ul ^ 116ul; s[4] = 13ul ^ 104ul; s[5] = 85ul ^ 101ul; s[6] = 0x00; return @(s); }";
            NSString *actualCode = [subject generateCode];
            
            actualCode should equal(expectedCode);
        });
        
    });
});

SPEC_END
