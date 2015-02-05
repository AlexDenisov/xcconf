//
// Created by AlexDenisov on 04/02/15.
// Copyright (c) 2015 AlexDenisov. All rights reserved.
//

#import "XCCConfig.h"
#import "XCCEnvironment.h"

@implementation XCCConfig

- (XCCEnvironment *)objectForKeyedSubscript:(NSString *)key {
    for (XCCEnvironment *environment in self.environments) {
        if ([environment.name isEqualToString:key]) {
            return environment;
        }
    }
    
    return nil;
}

@end
