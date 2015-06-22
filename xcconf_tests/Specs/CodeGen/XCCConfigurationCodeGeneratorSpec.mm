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
        
        context(@"non-secure", ^{
            
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
        
        context(@"secure", ^{
            
            it(@"without environments", ^{
                XCCYAMLConfiguration *config = [[XCCYAMLConfiguration alloc] initWithPrincipalClassName:@"Configuration"
                                                                                           environments:nil];
                subject = [[XCCConfigurationCodeGenerator alloc] initWithConfig:config environmentName:@"Debug" secureMode:YES];
                
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
                subject = [[XCCConfigurationCodeGenerator alloc] initWithConfig:config environmentName:@"Debug" secureMode:YES];
                
                NSString *expectedCode =    @"#import <Foundation/Foundation.h>\n"
                @"@interface Configuration : NSObject @end\n"
                @"@implementation Configuration\n"
                @"- (NSString *)environment { char s[6]; s[0] = 'D'; s[1] = 'e'; s[2] = 'b'; s[3] = 'u'; s[4] = 'g'; s[5] = 0x00; return @(s); }\n"
                @"- (NSString *)debugKey { char s[11]; s[0] = 'd'; s[1] = 'e'; s[2] = 'b'; s[3] = 'u'; s[4] = 'g'; s[5] = 'V'; s[6] = 'a'; s[7] = 'l'; s[8] = 'u'; s[9] = 'e'; s[10] = 0x00; return @(s); }\n"
                @"@end\n";
                NSString *actualCode = [subject generateCode];
                
                actualCode should equal(expectedCode);
            });
            
        });


    });

});

SPEC_END
