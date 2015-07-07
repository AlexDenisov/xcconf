//
//  XCCDriverOptionsBuilder.m
//  xcconf
//
//  Created by AlexDenisov on 22/06/15.
//  Copyright (c) 2015 AlexDenisov. All rights reserved.
//

#import "XCCDriverOptionsBuilder_Internal.h"
#import "XCCDiagnosticsEngine.h"
#import "XCCDriverOptions.h"

@implementation XCCDriverOptionsBuilder

- (NSString *)getEnvVariable:(NSString *)key {
    NSString *variable = @(getenv(key.UTF8String) ?: "");
    if (!variable.length) {
        NSString *errMsg = [NSString stringWithFormat:@"%@ not found", key];
        [self.diagnosticsEngine criticalError:errMsg];
    }
    return variable;
}

- (NSString *)inputFile {
    return [self getEnvVariable:@"INPUT_FILE_PATH"];
}

- (NSString *)outputFile {
    return [self getEnvVariable:@"SCRIPT_OUTPUT_FILE_0"];
}

- (NSString *)configurationName {
    return [self getEnvVariable:@"CONFIGURATION"];
}

- (BOOL)isSecure {
    return NO;
}

- (XCCDriverOptions *)buildOptionsFromArgC:(const int)argc ArgV:(const char **)argv {
    BOOL secure = NO;
    BOOL paranoid = NO;
    if (argc == 2) {
        secure = strcmp(argv[1], "secure") == 0;
        paranoid = strcmp(argv[1], "paranoid") == 0;
    }
    XCCDriverOptions *options = [XCCDriverOptions new];
    options.isSecure = secure;
    options.isParanoid = paranoid;
    options.inputPath = [self inputFile];
    options.outputPath = [self outputFile];
    options.configurationName = [self configurationName];

    return options;
}

@end
