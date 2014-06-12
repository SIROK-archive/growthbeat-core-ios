//
//  HubHttpClient.m
//  hub
//
//  Created by Kataoka Naoyuki on 2014/06/12.
//  Copyright (c) 2014 SIROK, Inc. All rights reserved.
//

#import "HubHttpClient.h"
#import "HubHTTPOperation.h"

static HubHttpClient *sharedInstance = nil;

@interface HubHttpClient () {

    NSURL *baseUrl;

}

@property (nonatomic, strong) NSURL *baseUrl;

@end

@implementation HubHttpClient

@synthesize baseUrl;

+ (HubHttpClient *) sharedInstance {

    @synchronized(self) {
        if (!sharedInstance) {
            sharedInstance = [[self alloc] init];
        }
        return sharedInstance;
    }

}


- (void) httpRequest:(HubHttpRequest *)httpRequest success:(void (^)(HubHttpResponse *httpResponse))success fail:(void (^)(HubHttpResponse *httpResponse))fail {

    [[NSOperationQueue mainQueue] addOperation:[HubHTTPOperation instanceWithRequest:[httpRequest urlRequestWithBaseUrl:baseUrl] success:success fail:fail]];

}

@end
