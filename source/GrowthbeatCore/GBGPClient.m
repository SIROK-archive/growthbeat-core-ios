//
//  GBGPClient.m
//  GrowthbeatCore
//
//  Created by uchidas on 2015/05/22.
//  Copyright (c) 2015年 SIROK, Inc. All rights reserved.
//

#import "GBGPClient.h"
#import "GBPreference.h"
#import "GBHttpClient.h"
#import "GrowthbeatCore.h"

static NSString *const kGBGPPreferenceFileName = @"growthpush-preferences";
static NSString *const kGBGPPreferenceClientKey = @"client";
static NSString *const kGBGPHttpClientDefaultBaseUrl = @"https://api.growthpush.com/";
static NSTimeInterval const kGBGPHttpClientDefaultTimeout = 60;

static GBPreference *preference = nil;
static GBHttpClient *httpClient = nil;

@implementation GBGPClient

@synthesize id;
@synthesize applicationId;
@synthesize code;
@synthesize growthbeatClientId;
@synthesize growthbeatApplicationId;
@synthesize token;
@synthesize os;
@synthesize environment;
@synthesize created;

+ (GBPreference *) preference {
    @synchronized(self) {
        if (!preference) {
            preference = [[GBPreference alloc] initWithFileName:kGBGPPreferenceFileName];
        }
        return preference;
    }
}

+ (GBHttpClient *) httpClient {
    @synchronized(self) {
        if (!httpClient) {
            httpClient = [[GBHttpClient alloc] initWithBaseUrl:[NSURL URLWithString:kGBGPHttpClientDefaultBaseUrl] timeout:kGBGPHttpClientDefaultTimeout];
        }
        return httpClient;
    }
}

+ (GBGPClient *) load {
    GBGPClient *gpClient = [[GBGPClient preference] objectForKey:kGBGPPreferenceClientKey];
    if (gpClient && (!gpClient.growthbeatClientId || !gpClient.growthbeatApplicationId)) {
        gpClient = [GBGPClient findWithGPClientId:gpClient.id code:gpClient.code];
    }
    return gpClient;
}

+ (void) removePreference {
    [[GBGPClient preference] removeAll];
}

+ (GBGPClient *) findWithGPClientId:(long long)clientId code:(NSString *)_code {
    NSString *path = [NSString stringWithFormat:@"/1/clients/%lld", clientId];
    NSMutableDictionary *query = [NSMutableDictionary dictionary];
    
    if (_code)
        [query setObject:_code forKey:@"code"];
    
    GBHttpRequest *httpRequest = [GBHttpRequest instanceWithMethod:GBRequestMethodGet path:path query:query body:nil];
    GBHttpResponse *httpResponse = [[GBGPClient httpClient] httpRequest:httpRequest];
    if (!httpResponse.success) {
        [[[GrowthbeatCore sharedInstance] logger] error:@"Failed to find client. %@", httpResponse.error ? httpResponse.error : [httpResponse.body objectForKey:@"message"]];
        return nil;
    }
    
    return [GBGPClient domainWithDictionary:httpResponse.body];

}

#pragma mark --
#pragma mark NSCoding

- (id) initWithCoder:(NSCoder *)aDecoder {
    
    self = [super init];
    if (self) {
        if ([aDecoder containsValueForKey:@"id"]) {
            self.id = [[aDecoder decodeObjectForKey:@"id"] longLongValue];
        }
        if ([aDecoder containsValueForKey:@"applicationId"]) {
            self.applicationId = [aDecoder decodeIntegerForKey:@"applicationId"];
        }
        if ([aDecoder containsValueForKey:@"code"]) {
            self.code = [aDecoder decodeObjectForKey:@"code"];
        }
        if ([aDecoder containsValueForKey:@"growthbeatApplicationId"]) {
            self.code = [aDecoder decodeObjectForKey:@"growthbeatApplicationId"];
        }
        if ([aDecoder containsValueForKey:@"growthbeatClientId"]) {
            self.code = [aDecoder decodeObjectForKey:@"growthbeatClientId"];
        }
        if ([aDecoder containsValueForKey:@"token"]) {
            self.token = [aDecoder decodeObjectForKey:@"token"];
        }
        if ([aDecoder containsValueForKey:@"os"]) {
            self.os = [aDecoder decodeObjectForKey:@"os"];
        }
        if ([aDecoder containsValueForKey:@"environment"]) {
            self.environment = [aDecoder decodeObjectForKey:@"environment"];
        }
        if ([aDecoder containsValueForKey:@"created"]) {
            self.created = [aDecoder decodeObjectForKey:@"created"];
        }
    }
    return self;
    
}

- (void) encodeWithCoder:(NSCoder *)aCoder {
    
    [aCoder encodeObject:@(id) forKey:@"id"];
    [aCoder encodeInteger:applicationId forKey:@"applicationId"];
    [aCoder encodeObject:code forKey:@"code"];
    [aCoder encodeObject:growthbeatClientId forKey:@"growthbeatApplicationId"];
    [aCoder encodeObject:growthbeatClientId forKey:@"growthbeatClientId"];
    [aCoder encodeObject:token forKey:@"token"];
    [aCoder encodeObject:os forKey:@"os"];
    [aCoder encodeObject:environment forKey:@"environment"];
    [aCoder encodeObject:created forKey:@"created"];
    
}

@end
