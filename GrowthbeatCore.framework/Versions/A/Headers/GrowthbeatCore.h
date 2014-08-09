//
//  GrowthbeatCore.h
//  GrowthbeatCore
//
//  Created by Kataoka Naoyuki on 2014/06/13.
//  Copyright (c) 2014年 SIROK, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GBClientObserver.h"
#import "GBLogger.h"
#import "GBHttpClient.h"

@interface GrowthbeatCore : NSObject

+ (GrowthbeatCore *) sharedInstance;
+ (void)initializeWithApplicationId:(NSString *)applicationId credentialId:(NSString *)credentialId;
+ (void)addClientObserver:(id <GBClientObserver>)clientObserver;
+ (void)removeClientObserver:(id <GBClientObserver>)clientObserver;
+ (void)setPreferenceFileName:(NSString *)fileName;
+ (void)setHttpClientBaseUrl:(NSURL *)url;
+ (void)setLoggerSilent:(BOOL)silent;

- (GBHttpClient *)httpClient;
- (GBLogger *)logger;

@end
