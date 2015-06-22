#import <Cedar/Cedar.h>
#import "XCCDriverOptionsBuilder_Internal.h"
#import "XCCDiagnosticsEngine.h"
#import "XCCDriverOptions.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(XCCDriverOptionsBuilderSpec)

describe(@"XCCDriverOptionsBuilder", ^{
    __block XCCDriverOptionsBuilder *subject;

    beforeEach(^{
        subject = [XCCDriverOptionsBuilder new];
    });
    
    context(@"envirnoment", ^{
        
        describe(@"diagnostics", ^{
            __block id<CedarDouble> diagMock = nil;
            
            beforeEach(^{
                diagMock = nice_fake_for(XCCDiagnosticsEngine.class);
                subject.diagnosticsEngine = diagMock;
            });
            
            it(@"inputFile", ^{
                [subject inputFile];
                diagMock should have_received(@selector(criticalError:)).with(@"INPUT_FILE_PATH not found");
            });
            
            it(@"outputFile", ^{
                [subject outputFile];
                diagMock should have_received(@selector(criticalError:)).with(@"SCRIPT_OUTPUT_FILE_0 not found");
            });
            
            it(@"configurationName", ^{
                [subject configurationName];
                diagMock should have_received(@selector(criticalError:)).with(@"CONFIGURATION not found");
            });

        });
        
        describe(@"loads env variables", ^{

            it(@"inputFile", ^{
                setenv("INPUT_FILE_PATH", "some_file.yaml", 1);
                [subject inputFile] should equal(@"some_file.yaml");
            });

            it(@"outputFile", ^{
                setenv("SCRIPT_OUTPUT_FILE_0", "some_file.m", 1);
                [subject outputFile] should equal(@"some_file.m");
            });

            it(@"configurationName", ^{
                setenv("CONFIGURATION", "Production", 1);
                [subject configurationName] should equal(@"Production");
            });

        });
        
    });
    
    context(@"command line arguments", ^{
        __block XCCDriverOptions *options = nil;

        describe(@"isSecure", ^{
            
            it(@"true", ^{
                const char *argv[] = { "progname", "secure" };
                options = [subject buildOptionsFromArgC:2 ArgV:argv];
                options.isSecure should be_truthy;
            });
            
            it(@"false", ^{
                const char *argv[] = { "progname", "nonsecure" };
                options = [subject buildOptionsFromArgC:2 ArgV:argv];
                options.isSecure should be_falsy;
            });
            
        });
        
        it(@"inputPath", ^{
            const char *dummyArgv[] = { "progname" };
            setenv("INPUT_FILE_PATH", "some_file.yaml", 1);
            options = [subject buildOptionsFromArgC:1 ArgV:dummyArgv];
            
            options.inputPath should equal(@"some_file.yaml");
        });
        
        it(@"outputPath", ^{
            const char *dummyArgv[] = { "progname" };
            setenv("SCRIPT_OUTPUT_FILE_0", "some_file.m", 1);
            options = [subject buildOptionsFromArgC:1 ArgV:dummyArgv];
            
            options.outputPath should equal(@"some_file.m");
        });
        
        it(@"configurationName", ^{
            const char *dummyArgv[] = { "progname" };
            setenv("CONFIGURATION", "Production", 1);
            options = [subject buildOptionsFromArgC:1 ArgV:dummyArgv];
            
            options.configurationName should equal(@"Production");
        });
        
    });

});

SPEC_END
