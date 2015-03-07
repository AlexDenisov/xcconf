//
//  XCCDiagnosticsEngine.h
//  xcconf
//
//  Created by AlexDenisov on 07/03/15.
//  Copyright (c) 2015 AlexDenisov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XCCDiagnosticsEngine : NSObject

- (void)criticalError:(NSString *)message;

@end
