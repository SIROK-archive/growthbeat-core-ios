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
#import "HubClient.h"

static Hub *sharedInstance = nil;
static NSString *const kGPBaseUrl = @"https://api.localhost:8085/";

@interface Hub () {
    
    HubClient *client;
    
}

@property (nonatomic, strong) HubClient *client;

@end

@implementation Hub

@synthesize client;

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
    [[self sharedInstance] initializeWithApplicationId:applicationId secret:secret];
}

- (id) init {
    self = [super init];
    if (self) {
        [[HubHttpClient sharedInstance] setBaseUrl:[NSURL URLWithString:kGPBaseUrl]];
    }
    return self;
}

- (void)initializeWithApplicationId:(NSString *)applicationId secret:(NSString *)secret {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        self.client = [HubClient createWithApplicationId:applicationId secret:secret];
    });
    
}

@end
