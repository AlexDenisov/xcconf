//
//  XCCDriverOptionsBuilder.h
//  xcconf
//
//  Created by AlexDenisov on 22/06/15.
//  Copyright (c) 2015 AlexDenisov. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XCCDriverOptions;
@class XCCDiagnosticsEngine;

@interface XCCDriverOptionsBuilder : NSObject

@property XCCDiagnosticsEngine *diagnosticsEngine;

- (XCCDriverOptions *)buildOptionsFromArgC:(const int)argc ArgV:(const char **)argv;

@end
