#import <Cedar/Cedar.h>
#import "XCCYAMLConfiguration.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(XCCYAMLConfigurationSpec)

describe(@"XCCYAMLConfiguration", ^{
    __block XCCYAMLConfiguration *subject;

    beforeEach(^{
        subject = [XCCYAMLConfiguration new];
    });
    
    describe(@"has method", ^{
        
        it(@"initWithPrincipalClassName:environments:", ^{
            subject should respond_to(@selector(initWithPrincipalClassName:environments:));
        });
    
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
