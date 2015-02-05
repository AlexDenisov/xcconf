#import <Cedar/Cedar.h>
#import "XCCConfig.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(XCCConfigSpec)

describe(@"XCCConfig", ^{
    __block XCCConfig *subject;

    beforeEach(^{
        subject = [XCCConfig new];
    });
    
    describe(@"has method", ^{
    
        it(@"principalClass", ^{
            subject should respond_to(@selector(principalClassName));
        });
        
        it(@"environments", ^{
            subject should respond_to(@selector(environments));
        });
        
        it(@"objectForKeyedSubscript", ^{
            subject[@"key"] should be_nil;
        });
    
    });
    
});

SPEC_END
