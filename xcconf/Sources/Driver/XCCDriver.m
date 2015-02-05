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

@interface XCCDriver ()

@property (copy) NSString *inputPath;
@property (copy) NSString *outputPath;
@property (copy) NSString *configurationName;

@end

@implementation XCCDriver

- (instancetype)initWithInputPath:(NSString *)inputPath
                       outputPath:(NSString *)outputPath
                configurationName:(NSString *)configurationName {
    self = [super init];

    self.inputPath = inputPath;
    self.outputPath = outputPath;
    self.configurationName = configurationName;
    
    return self;
}

- (void)generateAndSaveOutputFile {
    NSString *yaml = [NSString stringWithContentsOfFile:self.inputPath
                                               encoding:NSUTF8StringEncoding
                                                  error:nil];
    
    XCCConfigurationParser *parser = [XCCConfigurationParser new];
    XCCYAMLConfiguration *configuration = [parser parseYAML:yaml];
    
    XCCConfigurationCodeGenerator *codeGen = [[XCCConfigurationCodeGenerator alloc] initWithConfig:configuration
                                                                                   environmentName:self.configurationName];
    NSString *code = [codeGen generateCode];
    [code writeToFile:self.outputPath
           atomically:YES
             encoding:NSUTF8StringEncoding
                error:nil];
}

@end
