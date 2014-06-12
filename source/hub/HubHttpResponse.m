//
//  HubHttpResponse.m
//  hub
//
//  Created by Naoyuki Kataoka on 2014/06/12.
//  Copyright (c) 2014 SIROK, Inc. All rights reserved.
//

#import "HubHttpResponse.h"

@implementation HubHttpResponse

@synthesize urlRequest;
@synthesize httpUrlResponse;
@synthesize error;
@synthesize body;

+ (id) instanceWithUrlRequest:(NSURLRequest *)urlRequest httpUrlResponse:(NSHTTPURLResponse *)httpUrlResponse error:(NSError *)error body:(id)body {

    HubHttpResponse *httpResponse = [[self alloc] init];

    httpResponse.urlRequest = urlRequest;
    httpResponse.httpUrlResponse = httpUrlResponse;
    httpResponse.error = error;
    httpResponse.body = body;

    return httpResponse;

}

- (BOOL)success {
    
    return (httpUrlResponse.statusCode >= 200 && httpUrlResponse.statusCode < 300);
    
}

@end
