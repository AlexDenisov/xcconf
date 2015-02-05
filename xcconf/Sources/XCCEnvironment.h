//
// Created by AlexDenisov on 05/02/15.
// Copyright (c) 2015 AlexDenisov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XCCEnvironment : NSObject

@property (copy, readonly) NSString *name;
@property (copy, readonly) NSDictionary *parameters;

- (instancetype)initWithName:(NSString *)name parameters:(NSDictionary *)parameters;

@end
