//
//  HubHttpRequest.h
//  hub
//
//  Created by Naoyuki Kataoka on 2014/06/12.
//  Copyright (c) 2014 SIROK, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HubRequestMethod.h"

@interface HubHttpRequest : NSObject {

    HubRequestMethod requestMethod;
    NSString *path;
    NSDictionary *query;
    NSDictionary *body;

}

@property (nonatomic, assign) HubRequestMethod requestMethod;
@property (nonatomic, strong) NSString *path;
@property (nonatomic, strong) NSDictionary *query;
@property (nonatomic, strong) NSDictionary *body;

+ (id)instanceWithRequestMethod:(HubRequestMethod)requestMethod path:(NSString *)path;
+ (id)instanceWithRequestMethod:(HubRequestMethod)requestMethod path:(NSString *)path query:(NSDictionary *)query;
+ (id)instanceWithRequestMethod:(HubRequestMethod)requestMethod path:(NSString *)path query:(NSDictionary *)query body:(NSDictionary *)body;

- (NSURLRequest *)urlRequestWithBaseUrl:(NSURL *)baseUrl;

@end
