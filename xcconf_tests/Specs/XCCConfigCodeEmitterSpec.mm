#import <Cedar/Cedar.h>
#import "XCCConfigCodeEmitter.h"
#import "XCCConfig.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(XCCConfigCodeEmitterSpec)

describe(@"XCCConfigCodeEmitter", ^{
    __block XCCConfigCodeEmitter *subject;

    beforeEach(^{
        subject = [XCCConfigCodeEmitter new];
    });
    
    describe(@"has method", ^{
        
        it(@"initWithConfig:environmentName:", ^{
            subject should respond_to(@selector(initWithConfig:environmentName:));
        });
        
        it(@"emitCodeGen", ^{
            subject should respond_to(@selector(emitCodeGen));
        });
        
    });
    
    describe(@"emitCodeGen generates code", ^{
        
        it(@"without environments", ^{
            XCCConfig *config = [[XCCConfig alloc] initWithPrincipalClassName:@"Configuration"
                                                                 environments:nil];
            subject = [[XCCConfigCodeEmitter alloc] initWithConfig:config environmentName:@"Debug"];
            
            NSString *expectedCode = @"#import <Foundation/Foundation.h>\n"
                                     @"@interface Configuration : NSObject @end\n"
                                     @"@implementation Configuration\n"
                                     @"@end\n";
            NSString *actualCode = [subject emitCodeGen];
            
            actualCode should equal(expectedCode);
        });
        
    });
    
    
});

SPEC_END
