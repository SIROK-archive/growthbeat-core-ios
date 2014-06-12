//
//  HubHttpClient.m
//  hub
//
//  Created by Naoyuki Kataoka on 2014/06/12.
//  Copyright (c) 2014 SIROK, Inc. All rights reserved.
//

#import "HubHttpClient.h"

static HubHttpClient *sharedInstance = nil;

@interface HubHttpClient () {

    NSURL *baseUrl;
    NSOperationQueue *operationQueue;
    
}

@property (nonatomic, strong) NSURL *baseUrl;
@property (nonatomic, strong) NSOperationQueue *operationQueue;

@end

@implementation HubHttpClient

@synthesize baseUrl;
@synthesize operationQueue;

+ (HubHttpClient *) sharedInstance {

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
        self.operationQueue = [[NSOperationQueue alloc] init];
    }
    return self;
    
}

- (void) httpRequest:(HubHttpRequest *)httpRequest success:(void (^)(HubHttpResponse *httpResponse))success fail:(void (^)(HubHttpResponse *httpResponse))fail {
    
    NSURLRequest *urlRequest = [httpRequest urlRequestWithBaseUrl:baseUrl];
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:operationQueue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        id body = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        // TODO Check type of response instance.
        NSHTTPURLResponse *httpUrlResponse = (NSHTTPURLResponse*) response;
        
        if (httpUrlResponse.statusCode >= 200 && httpUrlResponse.statusCode < 300) {
            if (success) {
                success([HubHttpResponse instanceWithUrlRequest:urlRequest httpUrlResponse:httpUrlResponse error:error body:body]);
            }
        } else {
            if (fail) {
                fail([HubHttpResponse instanceWithUrlRequest:urlRequest httpUrlResponse:httpUrlResponse error:error body:body]);
            }
        }
        
    }];
    
}

- (HubHttpResponse *) httpRequest:(HubHttpRequest *)httpRequest {
    
    NSURLRequest *urlRequest = [httpRequest urlRequestWithBaseUrl:baseUrl];
    NSURLResponse *urlResponse = nil;
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&urlResponse error:&error];
    
    id body = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    
    // TODO Check type of response instance.
    NSHTTPURLResponse *httpUrlResponse = (NSHTTPURLResponse*) urlResponse;
    
    return [HubHttpResponse instanceWithUrlRequest:urlRequest httpUrlResponse:httpUrlResponse error:error body:body];
            
}

@end
