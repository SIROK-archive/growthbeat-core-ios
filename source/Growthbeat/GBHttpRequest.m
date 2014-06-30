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

@synthesize method;
@synthesize path;
@synthesize query;
@synthesize body;

+ (id) instanceWithMethod:(GBRequestMethod)method path:(NSString *)path {

    GBHttpRequest *httpRequest = [[self alloc] init];

    httpRequest.method = method;
    httpRequest.path = path;

    return httpRequest;

}

+ (id) instanceWithMethod:(GBRequestMethod)method path:(NSString *)path query:(NSDictionary *)query {

    GBHttpRequest *httpRequest = [self instanceWithMethod:method path:path];

    httpRequest.query = query;

    return httpRequest;

}

+ (id) instanceWithMethod:(GBRequestMethod)method path:(NSString *)path query:(NSDictionary *)query body:(NSDictionary *)body {

    GBHttpRequest *httpRequest = [self instanceWithMethod:method path:path query:query];

    httpRequest.body = body;

    return httpRequest;

}


- (NSURLRequest *) urlRequestWithBaseUrl:(NSURL *)baseUrl {

    NSString *requestPath = path ? path : @"";
    NSMutableDictionary *requestQuery = [NSMutableDictionary dictionaryWithDictionary:query];
    NSMutableDictionary *requestBody = [NSMutableDictionary dictionaryWithDictionary:body];

    if (method == GBRequestMethodGet) {
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

    [urlRequest setHTTPMethod:NSStringFromGBRequestMethod(method)];
    [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];

    if (method != GBRequestMethodGet) {
        NSString *contentTypeString = [NSString stringWithFormat:@"application/x-www-form-urlencoded; charset=%@", CFStringConvertEncodingToIANACharSetName(CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding))];
        [urlRequest setValue:contentTypeString forHTTPHeaderField:@"Content-Type"];
        [urlRequest setHTTPBody:[requestBodyString dataUsingEncoding:NSUTF8StringEncoding]];
    }

    return urlRequest;

}

@end
