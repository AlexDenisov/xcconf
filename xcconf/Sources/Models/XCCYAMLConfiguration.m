//
// Created by AlexDenisov on 04/02/15.
// Copyright (c) 2015 AlexDenisov. All rights reserved.
//

#import "XCCYAMLConfiguration.h"
#import "XCCEnvironment.h"

@interface XCCYAMLConfiguration ()

@property (copy) NSString *principalClassName;
@property (copy) NSArray *environments;

@end

@implementation XCCYAMLConfiguration

- (instancetype)initWithPrincipalClassName:(NSString *)name environments:(NSArray *)environments {
    self = [super init];
    
    self.principalClassName = name;
    self.environments = environments;
    
    return self;
}

- (XCCEnvironment *)objectForKeyedSubscript:(NSString *)key {
    for (XCCEnvironment *environment in self.environments) {
        if ([environment.name isEqualToString:key]) {
            return environment;
        }
    }
    
    return nil;
}

@end
