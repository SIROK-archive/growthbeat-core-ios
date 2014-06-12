//
//  HubHTTPOperation.h
//  hub
//
//  Created by Naoyuki Kataoka on 2014/06/12.
//  Copyright (c) 2014 SIROK, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HubHttpResponse.h"

@interface HubHTTPOperation : NSOperation <NSURLConnectionDataDelegate, NSURLConnectionDelegate>

+ (instancetype)instanceWithRequest:(NSURLRequest *)request success:(void(^) (HubHttpResponse *)) success fail:(void(^) (HubHttpResponse * httpResponse))fail;

@end
