//
// Created by AlexDenisov on 04/02/15.
// Copyright (c) 2015 AlexDenisov. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XCCConfig;

@interface XCCConfigParser : NSObject

- (XCCConfig *)parseYAML:(NSString *)yaml;

@end
