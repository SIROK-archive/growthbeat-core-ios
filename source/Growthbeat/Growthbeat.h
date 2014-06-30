//
//  Growthbeat.h
//  Growthbeat
//
//  Created by Kataoka Naoyuki on 2014/06/13.
//  Copyright (c) 2014年 SIROK, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GBClientObserver.h"

@interface Growthbeat : NSObject

+ (void)initializeWithApplicationId:(NSString *)applicationId secret:(NSString *)secret;
+ (void)addClientObserver:(id <GBClientObserver>)clientObserver;
+ (void)removeClientObserver:(id <GBClientObserver>)clientObserver;
+ (void)setPreferenceFileName:(NSString *)fileName;
+ (void)setHttpBaseUrl:(NSURL *)url;
+ (void)setLoggerSilent:(BOOL)silent;

@end
