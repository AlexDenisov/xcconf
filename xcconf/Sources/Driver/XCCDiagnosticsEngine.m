//
//  XCCDiagnosticsEngine.m
//  xcconf
//
//  Created by AlexDenisov on 07/03/15.
//  Copyright (c) 2015 AlexDenisov. All rights reserved.
//

#import "XCCDiagnosticsEngine.h"

@implementation XCCDiagnosticsEngine

- (void)criticalError:(NSString *)message {
    printf("xcconf: %s\n", message.UTF8String);
    exit(1);
}

@end
