//
//  GBHttpClient.m
//  Growthbeat
//
//  Created by Naoyuki Kataoka on 2014/06/12.
//  Copyright (c) 2014 SIROK, Inc. All rights reserved.
//

#import "GBHttpClient.h"

static GBHttpClient *sharedInstance = nil;

@interface GBHttpClient () {

    NSURL *baseUrl;
    NSOperationQueue *operationQueue;
    
}

@property (nonatomic, strong) NSURL *baseUrl;
@property (nonatomic, strong) NSOperationQueue *operationQueue;

@end

@implementation GBHttpClient

@synthesize baseUrl;
@synthesize operationQueue;

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
        self.operationQueue = [[NSOperationQueue alloc] init];
    }
    return self;
    
}

- (void) httpRequest:(GBHttpRequest *)httpRequest success:(void (^)(GBHttpResponse *httpResponse))success fail:(void (^)(GBHttpResponse *httpResponse))fail {
    
    NSURLRequest *urlRequest = [httpRequest urlRequestWithBaseUrl:baseUrl];
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:operationQueue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        id body = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        // TODO Check type of response instance.
        NSHTTPURLResponse *httpUrlResponse = (NSHTTPURLResponse*) response;
        
        if (httpUrlResponse.statusCode >= 200 && httpUrlResponse.statusCode < 300) {
            if (success) {
                success([GBHttpResponse instanceWithUrlRequest:urlRequest httpUrlResponse:httpUrlResponse error:error body:body]);
            }
        } else {
            if (fail) {
                fail([GBHttpResponse instanceWithUrlRequest:urlRequest httpUrlResponse:httpUrlResponse error:error body:body]);
            }
        }
        
    }];
    
}

- (GBHttpResponse *) httpRequest:(GBHttpRequest *)httpRequest {
    
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
