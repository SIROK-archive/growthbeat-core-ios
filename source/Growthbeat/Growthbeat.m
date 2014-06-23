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

static Growthbeat *sharedInstance = nil;
static NSString *const kGPBaseUrl = @"http://api.localhost:8085/";
static NSString *const kGBPreferenceClientKey = @"client";

@interface Growthbeat () {
    
    GBClient *client;
    GBLogger *logger;
    
}

@property (nonatomic, strong) GBClient *client;
@property (nonatomic, strong) GBLogger *logger;

@end

@implementation Growthbeat

@synthesize client;
@synthesize logger;

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

+ (void)setHttpBaseUrl:(NSURL *)url {
    [[self sharedInstance] setHttpBaseUrl:url];
}

+ (void)setLoggerSilent:(BOOL)silent {
    [[self sharedInstance] setLoggerSilent:silent];
}

- (id) init {
    self = [super init];
    if (self) {
        self.logger = [[GBLogger alloc] init];
        [[GBHttpClient sharedInstance] setBaseUrl:[NSURL URLWithString:kGPBaseUrl]];
        self.client = [self loadClient];
    }
    return self;
}

- (void)initializeWithApplicationId:(NSString *)applicationId secret:(NSString *)secret {

    
    [self.logger log:@"initialize (applicationId:%@)", applicationId];
    
    if (self.client)
        return ;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        self.client = [GBClient createWithApplicationId:applicationId secret:secret];
        [self.logger log:@"client created (id:%@)", self.client.id];
        
        [self saveClient:self.client];
        
    });
    
}

- (void)setHttpBaseUrl:(NSURL *)url {
    [[GBHttpClient sharedInstance] setBaseUrl:url];
}

- (void)setLoggerSilent:(BOOL)silent {
    self.logger.silent = silent;
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
