//
//  HubHttpClient.h
//  hub
//
//  Created by Naoyuki Kataoka on 2014/06/12.
//  Copyright (c) 2014 SIROK, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HubHttpRequest.h"
#import "HubHttpResponse.h"

@interface HubHttpClient : NSObject

+ (HubHttpClient *)sharedInstance;
- (void)setBaseUrl:(NSURL *)baseUrl;
- (void)httpRequest:(HubHttpRequest *)httpRequest success:(void(^) (HubHttpResponse * httpResponse)) success fail:(void(^) (HubHttpResponse * httpResponse))fail;
- (HubHttpResponse *) httpRequest:(HubHttpRequest *)httpRequest;

@end
