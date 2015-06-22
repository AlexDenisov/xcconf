//
//  XCCDriver.h
//  xcconf
//
//  Created by AlexDenisov on 05/02/15.
//  Copyright (c) 2015 AlexDenisov. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XCCDiagnosticsEngine;
@class XCCDriverOptions;

@interface XCCDriver : NSObject

@property (nonatomic, strong) XCCDiagnosticsEngine *diagnosticsEngine;

- (instancetype)initWithOptions:(XCCDriverOptions *)options;

- (void)generateAndSaveOutputFile;

@end
