//
//  GBLogger.m
//  GrowthbeatCore
//
//  Created by Kataoka Naoyuki on 2014/06/13.
//  Copyright (c) 2014年 SIROK, Inc. All rights reserved.
//

#import "GBLogger.h"

@implementation GBLogger

@synthesize silent;

- (instancetype)init {
    self = [super init];
    if(self){
        self.silent = NO;
    }
    return self;
}

- (void) log:(NSString *)format, ... {
    
    if (silent) {
        return;
    }
    
    va_list args;
    
    va_start(args, format);
    
    NSString *message = [[NSString alloc] initWithFormat:format arguments:args];
    NSLog(@"GrowthbeatCore - %@", message);
    
}

@end
