//
//  GBHttpClient.h
//  Growthbeat
//
//  Created by Naoyuki Kataoka on 2014/06/12.
//  Copyright (c) 2014 SIROK, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GBHttpRequest.h"
#import "GBHttpResponse.h"

@interface GBHttpClient : NSObject {
    
    NSURL *baseUrl;
    
}

@property (nonatomic, strong) NSURL *baseUrl;

+ (GBHttpClient *)sharedInstance;
- (GBHttpResponse *) httpRequest:(GBHttpRequest *)httpRequest;

@end
