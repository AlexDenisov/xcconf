#import <Cedar/Cedar.h>
#import "XCCEnvironmentEmitter.h"
#import "XCCEnvironment.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

XCCEnvironment *environmentWithParameters(NSDictionary *parameters) {
    XCCEnvironment *environment = [XCCEnvironment new];
    environment.name = @"doesn't matter";
    environment.parameters = parameters;
    return environment;
}

SPEC_BEGIN(XCCEnvironmentEmitterSpec)

describe(@"XCCEnvironmentEmitter", ^{
    __block XCCEnvironmentEmitter *subject;

    beforeEach(^{
        subject = [XCCEnvironmentEmitter new];
    });
    
    describe(@"has method", ^{
        
        it(@"initWithEnvironment:", ^{
            subject should respond_to(@selector(initWithEnvironment:));
        });
        
        it(@"emitCodeGen", ^{
            subject should respond_to(@selector(emitCodeGen));
        });
        
    });
    
    describe(@"emits code", ^{
        
        it(@"with one parmeter", ^{
            auto parameters = @{ @"key" : @"value" };
            auto env = environmentWithParameters(parameters);
            subject = [[XCCEnvironmentEmitter alloc] initWithEnvironment:env];
            
            NSString *expectedCode = @"- \(NSString *)key { return @\"value\"; }";
            NSString *actualCode = [subject emitCodeGen];
            
            actualCode should equal(expectedCode);
        });
        
        it(@"with multiple parameters", ^{
            auto parameters = @{ @"key0" : @"value0", @"key1" : @"value1" };
            auto env = environmentWithParameters(parameters);
            subject = [[XCCEnvironmentEmitter alloc] initWithEnvironment:env];
            
            NSString *expectedCode = @"- (NSString *)key1 { return @\"value1\"; }\n"
                                     @"- (NSString *)key0 { return @\"value0\"; }";
            NSString *actualCode = [subject emitCodeGen];
            
            actualCode should equal(expectedCode);
        });
        
    });
    
});

SPEC_END
