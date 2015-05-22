//
//  GBGPClient.m
//  GrowthbeatCore
//
//  Created by uchidas on 2015/05/22.
//  Copyright (c) 2015年 SIROK, Inc. All rights reserved.
//

#import "GBGPClient.h"
#import "GBPreference.h"

static NSString *const kGBGPPreferenceFileName = @"growthpush-preferences";
static NSString *const kGBGPPreferenceClientKey = @"client";

@implementation GBGPClient

@synthesize id;
@synthesize applicationId;
@synthesize code;
@synthesize growthbeatClientId;
@synthesize token;
@synthesize os;
@synthesize environment;
@synthesize created;

+ (GBGPClient *) load {
    GBPreference *preference = [[GBPreference alloc] initWithFileName:kGBGPPreferenceFileName];
    return [preference objectForKey:kGBGPPreferenceClientKey];
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
    [aCoder encodeObject:growthbeatClientId forKey:@"growthbeatClientId"];
    [aCoder encodeObject:token forKey:@"token"];
    [aCoder encodeObject:os forKey:@"os"];
    [aCoder encodeObject:environment forKey:@"environment"];
    [aCoder encodeObject:created forKey:@"created"];
    
}

@end
