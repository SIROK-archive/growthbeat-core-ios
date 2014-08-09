//
//  GBBlocksClientObserver.m
//  GrowthbeatCore
//
//  Created by Kataoka Naoyuki on 2014/06/30.
//  Copyright (c) 2014年 SIROK, Inc. All rights reserved.
//

#import "GBBlocksClientObserver.h"

@interface GBBlocksClientObserver () {
    
    void (^callback)(GBClient *);
    
}

@property (nonatomic, copy) void (^callback)(GBClient *client);

@end

@implementation GBBlocksClientObserver

@synthesize callback;

- (instancetype)initWithCallback:(void (^)(GBClient *))newCallback {
    self = [super init];
    if(self){
        self.callback = newCallback;
    }
    return self;
}

- (void)update:(GBClient *)client {
    
    if(callback)
        callback(client);
    
}

@end
