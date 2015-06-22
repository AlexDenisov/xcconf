//
//  XCCDriver.m
//  xcconf
//
//  Created by AlexDenisov on 05/02/15.
//  Copyright (c) 2015 AlexDenisov. All rights reserved.
//

#import "XCCDriver.h"
#import "XCCYAMLConfiguration.h"
#import "XCCConfigurationParser.h"
#import "XCCConfigurationCodeGenerator.h"
#import "XCCDriverOptions.h"

@interface XCCDriver ()

@property XCCDriverOptions *options;

@end

@implementation XCCDriver

- (instancetype)initWithOptions:(XCCDriverOptions *)options {
    self = [super init];
    
    self.options = options;
    
    return self;
}

- (void)generateAndSaveOutputFile {
    NSString *yaml = [NSString stringWithContentsOfFile:self.options.inputPath
                                               encoding:NSUTF8StringEncoding
                                                  error:nil];
    
    XCCConfigurationParser *parser = [XCCConfigurationParser new];
    XCCYAMLConfiguration *configuration = [parser parseYAML:yaml];
    
    XCCConfigurationCodeGenerator *codeGen = [[XCCConfigurationCodeGenerator alloc] initWithConfig:configuration
                                                                                   environmentName:self.options.configurationName 
                                                                                        secureMode:self.options.isSecure];
    codeGen.diagnosticEngine = self.diagnosticsEngine;
    NSString *code = [codeGen generateCode];
    [code writeToFile:self.options.outputPath
           atomically:YES
             encoding:NSUTF8StringEncoding
                error:nil];
}

@end
