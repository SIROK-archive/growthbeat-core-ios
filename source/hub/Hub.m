//
//  Hub.m
//  hub
//
//  Created by Kataoka Naoyuki on 2014/06/13.
//  Copyright (c) 2014年 SIROK, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Hub.h"
#import "HubHttpClient.h"

static Hub *sharedInstance = nil;
static NSString *const kGPBaseUrl = @"https://api.localhost:8085/";

@implementation Hub

+ (Hub *) sharedInstance {
    @synchronized(self) {
        if ([[[UIDevice currentDevice] systemVersion] floatValue] < 5.0f) {
            return nil;
        }
        if (!sharedInstance) {
            sharedInstance = [[self alloc] init];
        }
        return sharedInstance;
    }
}

+ (void)initializeWithApplicationId:(NSString *)applicationId secret:(NSString *)secret {
    
}

- (id) init {
    self = [super init];
    if (self) {
        [[HubHttpClient sharedInstance] setBaseUrl:[NSURL URLWithString:kGPBaseUrl]];
    }
    return self;
}

@end
