//
//  main.m
//  xcconf
//
//  Created by AlexDenisov on 04/02/15.
//  Copyright (c) 2015 AlexDenisov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XCCDriver.h"
#import "XCCDiagnosticsEngine.h"
#import "XCCDriverOptionsBuilder.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        XCCDiagnosticsEngine *diag = [XCCDiagnosticsEngine new];

        XCCDriverOptionsBuilder *builder = [XCCDriverOptionsBuilder new];
        builder.diagnosticsEngine = diag;
        XCCDriverOptions *options = [builder buildOptionsFromArgC:argc ArgV:argv];

        XCCDriver *driver = [[XCCDriver alloc] initWithOptions:options];
        driver.diagnosticsEngine = diag;

        [driver generateAndSaveOutputFile];
    }
    return 0;
}
