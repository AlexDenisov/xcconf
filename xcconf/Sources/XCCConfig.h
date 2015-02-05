//
// Created by AlexDenisov on 04/02/15.
// Copyright (c) 2015 AlexDenisov. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XCCEnvironment;

@interface XCCConfig : NSObject

@property (copy, readonly) NSString *principalClassName;
@property (copy, readonly) NSArray *environments;

- (instancetype)initWithPrincipalClassName:(NSString *)name environments:(NSArray *)environments NS_DESIGNATED_INITIALIZER;
- (XCCEnvironment *)objectForKeyedSubscript:(NSString *)key;

@end
