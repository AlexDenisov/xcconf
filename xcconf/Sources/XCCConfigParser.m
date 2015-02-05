//
// Created by AlexDenisov on 04/02/15.
// Copyright (c) 2015 AlexDenisov. All rights reserved.
//

#import "XCCConfigParser.h"
#import "XCCConfig.h"
#import "XCCEnvironment.h"

#import <YAML/YAMLSerialization.h>

@implementation XCCConfigParser

- (XCCConfig *)parseYAML:(NSString *)yaml {
    NSError *error;
    NSDictionary *rawConfig = [YAMLSerialization objectWithYAMLString:yaml
                                                              options:kYAMLReadOptionStringScalars
                                                                error:&error];
    
    XCCConfig *config = [XCCConfig new];
    config.principalClassName = rawConfig[@"principalClass"];
    config.environments = [self environmentsFromDictionary:rawConfig];
    
    return config;
}

- (NSArray *)environmentsFromDictionary:(NSDictionary *)dictionary {
    NSMutableArray *environments = [NSMutableArray new];
    for (NSString *key in [dictionary allKeys]) {
        if ([key isEqualToString:@"principalClass"]) {
            continue;
        }
        
        XCCEnvironment *environment = [XCCEnvironment new];
        environment.name = key;
        environment.parameters = dictionary[key];
        
        [environments addObject:environment];
    }
    
    return environments;
}

@end
