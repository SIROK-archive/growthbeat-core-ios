//
//  GBHttpRequest.m
//  Growthbeat
//
//  Created by Naoyuki Kataoka on 2014/06/12.
//  Copyright (c) 2014 SIROK, Inc. All rights reserved.
//

#import "GBHttpRequest.h"
#import "GBUtils.h"

@implementation GBHttpRequest

@synthesize requestMethod;
@synthesize path;
@synthesize query;
@synthesize body;

+ (id) instanceWithRequestMethod:(GBRequestMethod)requestMethod path:(NSString *)path {

    GBHttpRequest *httpRequest = [[self alloc] init];

    httpRequest.requestMethod = requestMethod;
    httpRequest.path = path;

    return httpRequest;

}

+ (id) instanceWithRequestMethod:(GBRequestMethod)requestMethod path:(NSString *)path query:(NSDictionary *)query {

    GBHttpRequest *httpRequest = [self instanceWithRequestMethod:requestMethod path:path];

    httpRequest.query = query;

    return httpRequest;

}

+ (id) instanceWithRequestMethod:(GBRequestMethod)requestMethod path:(NSString *)path query:(NSDictionary *)query body:(NSDictionary *)body {

    GBHttpRequest *httpRequest = [self instanceWithRequestMethod:requestMethod path:path query:query];

    httpRequest.body = body;

    return httpRequest;

}


- (NSURLRequest *) urlRequestWithBaseUrl:(NSURL *)baseUrl {

    NSString *requestPath = path ? path : @"";
    NSMutableDictionary *requestQuery = [NSMutableDictionary dictionaryWithDictionary:query];
    NSMutableDictionary *requestBody = [NSMutableDictionary dictionaryWithDictionary:body];

    if (requestMethod == GBRequestMethodGet) {
        [requestQuery addEntriesFromDictionary:requestBody];
        [requestBody removeAllObjects];
    }

    NSString *requestQueryString = [GBHttpUtils queryStringWithDictionary:requestQuery];
    NSString *requestBodyString = [GBHttpUtils queryStringWithDictionary:requestBody];

    if ([requestQueryString length] > 0) {
        requestPath = [NSString stringWithFormat:@"%@?%@", requestPath, requestQueryString];
    }

    NSURL *url = [NSURL URLWithString:requestPath relativeToURL:baseUrl];
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:url];

    [urlRequest setHTTPMethod:NSStringFromGBRequestMethod(requestMethod)];
    [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];

    if (requestMethod != GBRequestMethodGet) {
        NSString *contentTypeString = [NSString stringWithFormat:@"application/x-www-form-urlencoded; charset=%@", CFStringConvertEncodingToIANACharSetName(CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding))];
        [urlRequest setValue:contentTypeString forHTTPHeaderField:@"Content-Type"];
        [urlRequest setHTTPBody:[requestBodyString dataUsingEncoding:NSUTF8StringEncoding]];
    }

    return urlRequest;

}

@end
