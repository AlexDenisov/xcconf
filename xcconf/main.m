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
        NSString *input = @( getenv("INPUT_FILE_PATH") );
        NSString *output =  @( getenv("SCRIPT_OUTPUT_FILE_0") );
        NSString *configuration = @( getenv("CONFIGURATION") );
        
        XCCDriver *driver = [[XCCDriver alloc] initWithInputPath:input
                                                      outputPath:output
                                               configurationName:configuration];
        [driver generateAndSaveOutputFile];
    }
    return 0;
}
