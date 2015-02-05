//
// Created by AlexDenisov on 04/02/15.
// Copyright (c) 2015 AlexDenisov. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XCCYAMLConfiguration;

@interface XCCConfigurationParser : NSObject

- (XCCYAMLConfiguration *)parseYAML:(NSString *)yaml;

@end
