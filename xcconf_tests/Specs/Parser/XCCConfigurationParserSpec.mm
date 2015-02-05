#import <Cedar/Cedar.h>
#import "XCCConfigurationParser.h"
#import "XCCYAMLConfiguration.h"
#import "XCCEnvironment.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(XCCConfigurationParserSpec)

describe(@"XCCConfigurationParser", ^{
    __block XCCConfigurationParser *subject;

    beforeEach(^{
        subject = [XCCConfigurationParser new];
    });
    
    describe(@"has method", ^{
    
        it(@"parseYAML:", ^{
            subject should respond_to(@selector(parseYAML:));
        });
    
    });
    
    describe(@"parseYAML:", ^{
        __block XCCYAMLConfiguration *config;
        
        context(@"valid YAML", ^{
            
            beforeEach(^{
                NSString *yamlPath = [[NSBundle mainBundle] pathForResource:@"Valid"
                                                                     ofType:@"yaml"];
                NSString *yaml = [NSString stringWithContentsOfFile:yamlPath
                                                           encoding:NSUTF8StringEncoding
                                                              error:nil];
                config = [subject parseYAML:yaml];
            });
            
            describe(@"returns XCCYAMLConfiguration", ^{
                
                it(@"with principalClassName", ^{
                    config.principalClassName should equal(@"XCCPrincipalClass");
                });
                
                it(@"with environments", ^{
                    config.environments should_not be_nil;
                });
                
                describe(@"with XCCEnvironment", ^{
                    __block XCCEnvironment *env;
                    
                    beforeEach(^{
                        env = config[@"DebugCopy"];
                    });
                    
                    it(@"name", ^{
                        env.name should equal(@"DebugCopy");
                    });
                    
                    describe(@"parameters", ^{
                        
                        it(@"with serverAddress", ^{
                            env.parameters[@"serverAddress"] should equal(@"https://fooo-bar.buzz");
                        });
                        
                        it(@"with APIKey", ^{
                            env.parameters[@"APIKey"] should equal(@"qwe123!!qwe");
                        });
                        
                    });
                    
                });
                
            });
            
        });
        
    });
    
});

SPEC_END
