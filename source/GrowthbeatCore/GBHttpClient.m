//
//  GBHttpClient.m
//  GrowthbeatCore
//
//  Created by Naoyuki Kataoka on 2014/06/12.
//  Copyright (c) 2014 SIROK, Inc. All rights reserved.
//

#import "GBHttpClient.h"
#import "GBLogger.h"

static GBHttpClient *sharedInstance = nil;

@implementation GBHttpClient

@synthesize baseUrl;

+ (GBHttpClient *) sharedInstance {
    @synchronized(self) {
        if (!sharedInstance) {
            sharedInstance = [[self alloc] init];
        }
        return sharedInstance;
    }
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.baseUrl = nil;
    }
    return self;
}

- (GBHttpResponse *) httpRequest:(GBHttpRequest *)httpRequest {
    
    if (!baseUrl) {
        [[GBLogger sharedInstance] log:@"GBHttpClient's baseUrl is not set."];
        return nil;
    }
    
    NSURLRequest *urlRequest = [httpRequest urlRequestWithBaseUrl:baseUrl];
    NSURLResponse *urlResponse = nil;
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&urlResponse error:&error];
    
    id body = nil;
    if(data) {
        body = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    }
    
    // TODO Check type of response instance.
    NSHTTPURLResponse *httpUrlResponse = (NSHTTPURLResponse*) urlResponse;
    
    return [GBHttpResponse instanceWithUrlRequest:urlRequest httpUrlResponse:httpUrlResponse error:error body:body];
            
}

@end
