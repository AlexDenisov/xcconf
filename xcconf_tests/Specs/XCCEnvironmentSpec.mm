#import <Cedar/Cedar.h>
#import "XCCEnvironment.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(XCCEnvironmentSpec)

describe(@"XCCEnvironment", ^{
    __block XCCEnvironment *subject;

    beforeEach(^{
        subject = [XCCEnvironment new];
    });
    
    describe(@"has method", ^{
        
        it(@"initWithName:parameters:", ^{
            subject should respond_to(@selector(initWithName:parameters:));
        });
        
        it(@"name", ^{
            subject should respond_to(@selector(name));
        });
        
        it(@"parameters", ^{
            subject should respond_to(@selector(parameters));
        });
        
    });
    
});

SPEC_END
