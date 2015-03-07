//
//  main.m
//  xcconf
//
//  Created by AlexDenisov on 04/02/15.
//  Copyright (c) 2015 AlexDenisov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XCCDriver.h"
#import "XCCDiagnosticsEngine.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSString *input = @( getenv("INPUT_FILE_PATH") ?: "" );
        NSString *output =  @( getenv("SCRIPT_OUTPUT_FILE_0") ?: "" );
        NSString *configuration = @( getenv("CONFIGURATION") ?: "" );

        XCCDiagnosticsEngine *diag = [XCCDiagnosticsEngine new];

        if (!input.length) {
            [diag criticalError:@"INPUT_FILE_PATH not found"];
        }
        if (!output.length) {
            [diag criticalError:@"SCRIPT_OUTPUT_FILE_0 not found"];
        }
        if (!configuration.length) {
            [diag criticalError:@"CONFIGURATION not found"];
        }

        XCCDriver *driver = [[XCCDriver alloc] initWithInputPath:input
                                                      outputPath:output
                                               configurationName:configuration];
        driver.diagnosticsEngine = diag;
        [driver generateAndSaveOutputFile];
    }
    return 0;
}
