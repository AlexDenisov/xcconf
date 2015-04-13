#import <Cedar/Cedar.h>
#import "XCCConfigurationCodeGenerator.h"
#import "XCCYAMLConfiguration.h"
#import "XCCEnvironment.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(XCCConfigurationCodeGeneratorSpec)

describe(@"XCCConfigurationCodeGenerator", ^{
    __block XCCConfigurationCodeGenerator *subject;

    beforeEach(^{
        subject = [XCCConfigurationCodeGenerator new];
    });

    describe(@"has method", ^{

        it(@"initWithConfig:environmentName:", ^{
            subject should respond_to(@selector(initWithConfig:environmentName:));
        });

        it(@"generateCode", ^{
            subject should respond_to(@selector(generateCode));
        });

    });

    describe(@"generateCode generates code", ^{

        it(@"without environments", ^{
            XCCYAMLConfiguration *config = [[XCCYAMLConfiguration alloc] initWithPrincipalClassName:@"Configuration"
                                                                                       environments:nil];
            subject = [[XCCConfigurationCodeGenerator alloc] initWithConfig:config environmentName:@"Debug"];

            NSString *expectedCode =    @"#import <Foundation/Foundation.h>\n"
                                        @"@interface Configuration : NSObject @end\n"
                                        @"@implementation Configuration\n"
                                        @"@end\n";
            NSString *actualCode = [subject generateCode];

            actualCode should equal(expectedCode);
        });

        it(@"with environment", ^{
            NSDictionary *debugParameters = @{ @"debugKey" : @"debugValue" };
            XCCEnvironment *debug = [[XCCEnvironment alloc] initWithName:@"Debug"
                                                              parameters:debugParameters];

            NSDictionary *releaseParameters = @{ @"releaseKey" : @"releaseValue" };
            XCCEnvironment *release = [[XCCEnvironment alloc] initWithName:@"Release"
                                                                parameters:releaseParameters];

            NSArray *environments = @[ debug, release ];

            XCCYAMLConfiguration *config = [[XCCYAMLConfiguration alloc] initWithPrincipalClassName:@"Configuration"
                                                                                       environments:environments];
            subject = [[XCCConfigurationCodeGenerator alloc] initWithConfig:config environmentName:@"Debug"];

            NSString *expectedCode =    @"#import <Foundation/Foundation.h>\n"
                                        @"@interface Configuration : NSObject @end\n"
                                        @"@implementation Configuration\n"
                                        @"- (NSString *)environment { return @\"Debug\"; }\n"
                                        @"- (NSString *)debugKey { return @\"debugValue\"; }\n"
                                        @"@end\n";
            NSString *actualCode = [subject generateCode];

            actualCode should equal(expectedCode);
        });

    });

});

SPEC_END
