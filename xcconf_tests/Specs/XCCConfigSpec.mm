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
        
        it(@"configurations", ^{
            subject should respond_to(@selector(configurations));
        });
    
    });
    
});

SPEC_END
