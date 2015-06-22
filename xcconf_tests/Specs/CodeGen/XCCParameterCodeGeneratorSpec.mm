#import <Cedar/Cedar.h>
#import "XCCParametersCodeGenerator.h"
#import "XCCEnvironment.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

static XCCEnvironment *environmentWithParameters(NSDictionary *parameters) {
    NSString *name = @"some_name";
    XCCEnvironment *environment = [[XCCEnvironment alloc] initWithName:name
                                                            parameters:parameters];
    return environment;
}

SPEC_BEGIN(XCCParameterCodeGeneratorSpec)

describe(@"XCCParametersCodeGenerator", ^{
    __block XCCParametersCodeGenerator *subject;

    beforeEach(^{
        subject = [XCCParametersCodeGenerator new];
    });
    
    describe(@"has method", ^{
        
        it(@"initWithEnvironment:", ^{
            subject should respond_to(@selector(initWithEnvironment:));
        });
        
        it(@"generateCode", ^{
            subject should respond_to(@selector(generateCode));
        });
        
    });
    
    describe(@"emits code", ^{
        
        it(@"with one parmeter", ^{
            auto parameters = @{ @"key" : @"value" };
            auto env = environmentWithParameters(parameters);
            subject = [[XCCParametersCodeGenerator alloc] initWithEnvironment:env];
            
            NSString *expectedCode = @"- \(NSString *)environment { return @\"some_name\"; }\n"
                                     @"- \(NSString *)key { return @\"value\"; }";
            NSString *actualCode = [subject generateCode];
            
            actualCode should equal(expectedCode);
        });
        
        it(@"with multiple parameters", ^{
            auto parameters = @{ @"key0" : @"value0", @"key1" : @"value1" };
            auto env = environmentWithParameters(parameters);
            subject = [[XCCParametersCodeGenerator alloc] initWithEnvironment:env];
            
            NSString *expectedCode = @"- (NSString *)environment { return @\"some_name\"; }\n"
                                     @"- (NSString *)key1 { return @\"value1\"; }\n"
                                     @"- (NSString *)key0 { return @\"value0\"; }";
            NSString *actualCode = [subject generateCode];
            
            actualCode should equal(expectedCode);
        });
        
    });
    
});

SPEC_END
