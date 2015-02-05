//
//  main.m
//  Sample
//
//  Created by AlexDenisov on 05/02/15.
//  Copyright (c) 2015 AlexDenisov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Config.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Config *config = [Config new];
        NSLog(@"%@ %@", config.serverAddress, config.analyticsKey);
    }
    return 0;
}
