//
//  HubHTTPOperation.m
//  hub
//
//  Created by Naoyuki Kataoka on 2014/06/12.
//  Copyright (c) 2014 SIROK, Inc. All rights reserved.
//

#import "HubHTTPOperation.h"

@interface HubHTTPOperation () {

    NSURLRequest *request;

    NSMutableData *receiveData;

    NSHTTPURLResponse *receiveResponse;

    void (^success)(HubHttpResponse *);

    void (^fail)(HubHttpResponse *);

}

@property (nonatomic, strong) NSURLRequest *request;
@property (nonatomic, strong) NSMutableData *receiveData;
@property (nonatomic, strong) NSHTTPURLResponse *receiveResponse;
@property (nonatomic, copy) void (^success)(HubHttpResponse *);
@property (nonatomic, copy) void (^fail)(HubHttpResponse *);

@end

@implementation HubHTTPOperation

@synthesize request;
@synthesize receiveData;
@synthesize receiveResponse;
@synthesize success;
@synthesize fail;

+ (instancetype) instanceWithRequest:(NSURLRequest *)request success:(void (^)(HubHttpResponse *))success fail:(void (^)(HubHttpResponse *httpResponse))fail {

    HubHTTPOperation *operation = [[self alloc] init];

    operation.request = request;
    operation.success = success;
    operation.fail = fail;

    return operation;

}

- (instancetype) init {

    self = [super init];
    if (self) {
        self.receiveData = [NSMutableData data];
    }
    return self;

}


- (void) main {

    [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];

}

#pragma mark -
#pragma mark NSURLConnectionDataDelegate

- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {

    self.receiveResponse = (NSHTTPURLResponse *)response;
    [receiveData setLength:0];

}

- (void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {

    [receiveData appendData:data];

}

- (void) connectionDidFinishLoading:(NSURLConnection *)connection {

    NSData *data = self.receiveData;
    NSHTTPURLResponse *response = self.receiveResponse;

    id body = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];

    if (response.statusCode >= 200 && response.statusCode < 300) {
        if (success) {
            success([HubHttpResponse instanceWithUrlRequest:request httpUrlResponse:response error:nil body:body]);
        }
    } else {
        if (fail) {
            fail([HubHttpResponse instanceWithUrlRequest:request httpUrlResponse:response error:nil body:body]);
        }
    }

}

- (void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {

    if (fail) {
        fail([HubHttpResponse instanceWithUrlRequest:self.request httpUrlResponse:self.receiveResponse error:error body:nil]);
    }

}

@end
