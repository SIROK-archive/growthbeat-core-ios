//
//  GrowthbeatCore.m
//  GrowthbeatCore
//
//  Created by Kataoka Naoyuki on 2014/06/13.
//  Copyright (c) 2014年 SIROK, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GrowthbeatCore.h"
#import "GBHttpClient.h"
#import "GBClient.h"
#import "GBPreference.h"
#import "GBBlocksClientObserver.h"

static GrowthbeatCore *sharedInstance = nil;
static NSString *const kGBHttpClientDefaultBaseUrl = @"https://api.GrowthbeatCore.com/";
static NSString *const kGBPreferenceDefaultFileName = @"GrowthbeatCore-preferences";
static NSString *const kGBPreferenceClientKey = @"client";

@interface GrowthbeatCore () {
    
    GBClient *client;
    NSMutableArray *clientObservers;
    GBLogger *logger;
    
}

@property (nonatomic, strong) GBClient *client;
@property (nonatomic, strong) NSMutableArray *clientObservers;
@property (nonatomic, strong) GBLogger *logger;

@end

@implementation GrowthbeatCore

@synthesize client;
@synthesize clientObservers;
@synthesize logger;

+ (GrowthbeatCore *) sharedInstance {
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

+ (void)initializeWithApplicationId:(NSString *)applicationId credentialId:(NSString *)credentialId {
    [[self sharedInstance] initializeWithApplicationId:applicationId credentialId:credentialId];
}

+ (void)addClientObserver:(id <GBClientObserver>)clientObserver {
    [[self sharedInstance] addClientObserver:clientObserver];
}

+ (void)removeClientObserver:(id <GBClientObserver>)clientObserver {
    [[self sharedInstance] removeClientObserver:clientObserver];
}

+ (void)setHttpClientBaseUrl:(NSURL *)url {
    [[GBHttpClient sharedInstance] setBaseUrl:url];
}

+ (void)setPreferenceFileName:(NSString *)fileName {
    [[GBPreference sharedInstance] setFileName:fileName];
}

+ (void)setLoggerSilent:(BOOL)silent {
    [[[self sharedInstance] logger] setSilent:silent];
}

- (instancetype) init {
    self = [super init];
    if (self) {
        self.logger = [[GBLogger alloc] init];
        if(![[GBHttpClient sharedInstance] baseUrl]) {
            [[GBHttpClient sharedInstance] setBaseUrl:[NSURL URLWithString:kGBHttpClientDefaultBaseUrl]];
        }
        if(![[GBPreference sharedInstance] fileName]) {
            [[GBPreference sharedInstance] setFileName:kGBPreferenceDefaultFileName];
        }
        self.client = nil;
        self.clientObservers = [NSMutableArray array];
    }
    return self;
}

- (void)initializeWithApplicationId:(NSString *)applicationId credentialId:(NSString *)credentialId {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        
        [logger log:@"Initializing... (applicationId:%@)", applicationId];
        
        self.client = [self loadClient];
        if (client && [client.application.id isEqualToString:applicationId]) {
            [logger log:@"Client already exists. (id:%@)", client.id];
            [self updateClient:client];
            return;
        }
        
        [[GBPreference sharedInstance] removeAll];
        
        [logger log:@"Creating client... (applicationId:%@)", applicationId];
        self.client = [GBClient createWithApplicationId:applicationId credentialId:credentialId];
        if(!client) {
            [logger log:@"Failed to create client."];
            return;
        }
        
        [self saveClient:client];
        [logger log:@"Client created. (id:%@)", client.id];
        [self updateClient:client];
        
    });
    
}

- (void)addClientObserver:(id <GBClientObserver>)clientObserver {
    [clientObservers addObject:clientObserver];
}

- (void)removeClientObserver:(id <GBClientObserver>)clientObserver {
    [clientObservers removeObject:clientObserver];
}

- (void)updateClient:(GBClient *)newClient {
    
    for (id <GBClientObserver> clientObserver in clientObservers) {
        [clientObserver update:newClient];
    }

}

- (GBClient *)loadClient {
    
    NSData *data = [[GBPreference sharedInstance] objectForKey:kGBPreferenceClientKey];
    
    if (!data) {
        return nil;
    }
    
    return  [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
}

- (void) saveClient:(GBClient *)newClient {
    
    if (!newClient) {
        return;
    }
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:client];
    [[GBPreference sharedInstance] setObject:data forKey:kGBPreferenceClientKey];
    
}

@end
