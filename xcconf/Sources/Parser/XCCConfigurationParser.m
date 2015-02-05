//
// Created by AlexDenisov on 04/02/15.
// Copyright (c) 2015 AlexDenisov. All rights reserved.
//

#import "XCCConfigurationParser.h"
#import "XCCYAMLConfiguration.h"
#import "XCCEnvironment.h"

#import <YAML/YAMLSerialization.h>

@implementation XCCConfigurationParser

- (XCCYAMLConfiguration *)parseYAML:(NSString *)yaml {
    NSError *error;
    NSDictionary *rawConfig = [YAMLSerialization objectWithYAMLString:yaml
                                                              options:kYAMLReadOptionStringScalars
                                                                error:&error];

    if (error) {
        NSLog(@"Cannot read YAML file: %@", error);
        exit(1);
    }

    NSString *className = rawConfig[@"principalClass"];
    if (!className) {
        NSLog(@"principalClass not found");
        exit(1);
    }

    if (!className.length) {
        NSLog(@"principalClass can not be empty");
        exit(1);
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
