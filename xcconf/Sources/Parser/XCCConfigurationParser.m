//
// Created by AlexDenisov on 04/02/15.
// Copyright (c) 2015 AlexDenisov. All rights reserved.
//

#import "XCCConfigurationParser.h"
#import "XCCYAMLConfiguration.h"
#import "XCCEnvironment.h"
#import "XCCDiagnosticsEngine.h"

#import <YAML/YAMLSerialization.h>

@implementation XCCConfigurationParser

- (XCCYAMLConfiguration *)parseYAML:(NSString *)yaml {
    NSError *error;
    NSDictionary *rawConfig = [YAMLSerialization objectWithYAMLString:yaml
                                                              options:kYAMLReadOptionStringScalars
                                                                error:&error];

    if (error) {
        NSString *message = [NSString stringWithFormat:@"Cannot read YAML file: %@", error];
        [self.diagnosticsEngine criticalError:message];
    }

    NSString *className = rawConfig[@"principalClass"];
    if (!className) {
        [self.diagnosticsEngine criticalError:@"principalClass not found"];
    }

    if (!className.length) {
        [self.diagnosticsEngine criticalError:@"principalClass can not be empty"];
    }

    NSArray *environments = [self environmentsFromDictionary:rawConfig];
    
    XCCYAMLConfiguration *config = [[XCCYAMLConfiguration alloc] initWithPrincipalClassName:className
                                                         environments:environments];
    
    return config;
}

- (NSArray *)environmentsFromDictionary:(NSDictionary *)dictionary {
    NSMutableArray *environments = [NSMutableArray new];
    for (NSString *key in [dictionary allKeys]) {
        if ([key isEqualToString:@"principalClass"]) {
            continue;
        }
        
        XCCEnvironment *environment = [[XCCEnvironment alloc] initWithName:key
                                                                parameters:dictionary[key]];
        
        [environments addObject:environment];
    }
    
    return environments;
}

@end
