//
//  Growthbeat.m
//  Growthbeat
//
//  Created by Kataoka Naoyuki on 2014/06/13.
//  Copyright (c) 2014年 SIROK, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Growthbeat.h"
#import "GBLogger.h"
#import "GBHttpClient.h"
#import "GBClient.h"
#import "GBPreference.h"
#import "GBBlocksClientObserver.h"

static Growthbeat *sharedInstance = nil;
static NSString *const kGBDefaultHttpClientBaseUrl = @"https://api.growthbeat.com/";
static NSString *const kGBDefaultPreferenceFileName = @"growthbeat-preferences";
static NSString *const kGBPreferenceClientKey = @"client";

@interface Growthbeat () {
    
    GBClient *client;
    NSMutableArray *clientObservers;
    
}

@property (nonatomic, strong) GBClient *client;
@property (nonatomic, strong) NSMutableArray *clientObservers;


@end

@implementation Growthbeat

@synthesize client;
@synthesize clientObservers;

+ (Growthbeat *) sharedInstance {
    @synchronized(self) {
        if ([[[UIDevice currentDevice] systemVersion] floatValue] < 5.0f) {
            return nil;
        }
        if (!sharedInstance) {
            sharedInstance = [[self alloc] init];
        }
        return sharedInstance;
    }
}

+ (void)initializeWithApplicationId:(NSString *)applicationId secret:(NSString *)secret {
    [[self sharedInstance] initializeWithApplicationId:applicationId secret:secret];
}

+ (void)addClientObserver:(id <GBClientObserver>)clientObserver {
    [[self sharedInstance] addClientObserver:clientObserver];
}

+ (void)removeClientObserver:(id <GBClientObserver>)clientObserver {
    [[self sharedInstance] removeClientObserver:clientObserver];
}

+ (void)setPreferenceFileName:(NSString *)fileName {
    [[self sharedInstance] setPreferenceFileName:fileName];
}

+ (void)setHttpClientBaseUrl:(NSURL *)url {
    [[self sharedInstance] setHttpClientBaseUrl:url];
}

+ (void)setLoggerSilent:(BOOL)silent {
    [[self sharedInstance] setLoggerSilent:silent];
}

- (instancetype) init {
    self = [super init];
    if (self) {
        [[GBHttpClient sharedInstance] setBaseUrl:[NSURL URLWithString:kGBDefaultHttpClientBaseUrl]];
        [[GBPreference sharedInstance] setFileName:kGBDefaultPreferenceFileName];
        self.client = nil;
        self.clientObservers = [NSMutableArray array];
    }
    return self;
}

- (void)initializeWithApplicationId:(NSString *)applicationId secret:(NSString *)secret {
    
    [[GBLogger sharedInstance] log:@"initialize (applicationId:%@)", applicationId];
    
    self.client = [self loadClient];
    
    if (self.client && [self.client.application.id isEqualToString:applicationId]) {
        [self updateClient:self.client];
        return;
    }
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        self.client = [GBClient createWithApplicationId:applicationId secret:secret];
        [[GBLogger sharedInstance] log:@"client created (id:%@)", self.client.id];
        [self saveClient:self.client];
        [self updateClient:self.client];
    });
    
}

- (void)addClientObserver:(id <GBClientObserver>)clientObserver {
    [self.clientObservers addObject:clientObserver];
}

- (void)removeClientObserver:(id <GBClientObserver>)clientObserver {
    [self.clientObservers removeObject:clientObserver];
}

- (void)setHttpClientBaseUrl:(NSURL *)url {
    [[GBHttpClient sharedInstance] setBaseUrl:url];
}

- (void)setPreferenceFileName:(NSString *)fileName {
    [[GBPreference sharedInstance] setFileName:fileName];
}

- (void)setLoggerSilent:(BOOL)silent {
    [[GBLogger sharedInstance] setSilent:silent];
}

- (void)updateClient:(GBClient *)client {
    
    for (id <GBClientObserver> clientObserver in self.clientObservers) {
        [clientObserver update:self.client];
    }
    
}

- (GBClient *)loadClient {
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:client];
    [[GBPreference sharedInstance] setObject:data forKey:kGBPreferenceClientKey];
    
    if (!data) {
        return nil;
    }

    return [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
}

- (void) saveClient:(GBClient *)newClient {
    
    if (!newClient) {
        return;
    }
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:client];
    [[GBPreference sharedInstance] setObject:data forKey:kGBPreferenceClientKey];
    
}

- (void) clearClient {
    
    self.client = nil;
    [[GBPreference sharedInstance] removeAll];
    
}

@end
