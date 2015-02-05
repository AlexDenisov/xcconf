//
// Created by AlexDenisov on 05/02/15.
// Copyright (c) 2015 AlexDenisov. All rights reserved.
//

#import "XCCEnvironment.h"

@interface XCCEnvironment ()

@property (copy) NSString *name;
@property (copy) NSDictionary *parameters;

@end

@implementation XCCEnvironment

- (instancetype)initWithName:(NSString *)name parameters:(NSDictionary *)parameters {
    self = [super init];
    
    self.name = name;
    self.parameters = parameters;
    
    return self;
}

@end
