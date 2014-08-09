//
//  GrowthbeatCore.m
//  GrowthbeatCore
//
//  Created by Kataoka Naoyuki on 2014/06/13.
//  Copyright (c) 2014年 SIROK, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GrowthbeatCore.h"

static GrowthbeatCore *sharedInstance = nil;
static NSString *const kGBHttpClientDefaultBaseUrl = @"https://api.GrowthbeatCore.com/";
static NSString *const kGBPreferenceDefaultFileName = @"GrowthbeatCore-preferences";
static NSString *const kGBPreferenceClientKey = @"client";

@interface GrowthbeatCore () {
    
    GBClient *client;
    GBLogger *logger;
    GBHttpClient *httpClient;
    GBPreference *preference;
    
}

@property (nonatomic, strong) GBClient *client;
@property (nonatomic, strong) GBLogger *logger;
@property (nonatomic, strong) GBHttpClient *httpClient;
@property (nonatomic, strong) GBPreference *preference;

@end

@implementation GrowthbeatCore

@synthesize client;
@synthesize logger;
@synthesize httpClient;
@synthesize preference;

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

+ (void)setHttpClientBaseUrl:(NSURL *)url {
    [[[self sharedInstance] httpClient] setBaseUrl:url];
}

+ (void)setPreferenceFileName:(NSString *)fileName {
    [[[self sharedInstance] preference] setFileName:fileName];
}

+ (void)setLoggerSilent:(BOOL)silent {
    [[[self sharedInstance] logger] setSilent:silent];
}

- (instancetype) init {
    self = [super init];
    if (self) {
        self.logger = [[GBLogger alloc] initWithTag:@"Growthbeat"];
        self.httpClient = [[GBHttpClient alloc] initWithBaseUrl:[NSURL URLWithString:kGBHttpClientDefaultBaseUrl]];
        self.preference = [[GBPreference alloc] initWithFileName:kGBPreferenceDefaultFileName];
        self.client = nil;
    }
    return self;
}

- (void)initializeWithApplicationId:(NSString *)applicationId credentialId:(NSString *)credentialId {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        
        [logger info:@"Initializing... (applicationId:%@)", applicationId];
        
        self.client = [self loadClient];
        if (client && [client.application.id isEqualToString:applicationId]) {
            [logger info:@"Client already exists. (id:%@)", client.id];
            return;
        }
        
        [preference removeAll];
        
        [logger info:@"Creating client... (applicationId:%@)", applicationId];
        self.client = [GBClient createWithApplicationId:applicationId credentialId:credentialId];
        if(!client) {
            [logger info:@"Failed to create client."];
            return;
        }
        
        [self saveClient:client];
        [logger info:@"Client created. (id:%@)", client.id];
        
    });
    
}

- (GBClient *)waitClient {
    
    while (true) {
        if(client != nil)
            return client;
        usleep(100 * 1000);
    }
    
}

- (GBClient *)loadClient {
    
    NSData *data = [preference objectForKey:kGBPreferenceClientKey];
    
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
    [preference setObject:data forKey:kGBPreferenceClientKey];
    
}

@end
