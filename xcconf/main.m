//
//  main.m
//  xcconf
//
//  Created by AlexDenisov on 04/02/15.
//  Copyright (c) 2015 AlexDenisov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XCCDriver.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSString *input = @( getenv("INPUT_FILE_PATH") ?: "" );
        NSString *output =  @( getenv("SCRIPT_OUTPUT_FILE_0") ?: "" );
        NSString *configuration = @( getenv("CONFIGURATION") ?: "" );

        if (!input.length) {
            NSLog(@"INPUT_FILE_PATH not found");
            exit(1);
        }
        if (!output.length) {
            NSLog(@"SCRIPT_OUTPUT_FILE_0 not found");
            exit(1);
        }
        if (!configuration.length) {
            NSLog(@"CONFIGURATION not found");
            exit(1);
        }

        XCCDriver *driver = [[XCCDriver alloc] initWithInputPath:input
                                                      outputPath:output
                                               configurationName:configuration];
        [driver generateAndSaveOutputFile];
    }
    return 0;
}
