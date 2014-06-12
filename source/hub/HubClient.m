//
//  HubClient.m
//  hub
//
//  Created by Naoyuki Kataoka on 2014/06/13.
//  Copyright (c) 2014 SIROK, Inc. All rights reserved.
//

#import "HubClient.h"
#import "HubUtils.h"
#import "HubHttpClient.h"

@implementation HubClient

@synthesize id;
@synthesize applicationId;
@synthesize modified;
@synthesize created;

+ (HubClient *)createWithApplicationId:(NSString *)applicationId secret:(NSString *)secret {
    
    NSString *path = @"/1/clients";
    NSMutableDictionary *body = [NSMutableDictionary dictionary];
    
    if (applicationId) {
        [body setObject:applicationId forKey:@"applicationId"];
    }
    if (secret) {
        [body setObject:secret forKey:@"secret"];
    }
    
    HubHttpRequest *httpRequest = [HubHttpRequest instanceWithRequestMethod:HubRequestMethodPost path:path query:nil body:body];
    
    HubHttpResponse *httpResponse = [[HubHttpClient sharedInstance] httpRequest:httpRequest];
    if(!httpResponse.success){
        // TODO hanlde errors
        return nil;
    }
    
    HubClient *client = [HubClient domainWithDictionary:httpResponse.body];
    return client;
    
}

- (id) initWithDictionary:(NSDictionary *)dictionary {

    self = [super init];
    if (self) {
        if ([dictionary objectForKey:@"id"] && [dictionary objectForKey:@"id"] != [NSNull null]) {
            self.id = [dictionary objectForKey:@"id"];
        }
        if ([dictionary objectForKey:@"applicationId"] && [dictionary objectForKey:@"applicationId"] != [NSNull null]) {
            self.applicationId = [dictionary objectForKey:@"applicationId"];
        }
        if ([dictionary objectForKey:@"modified"] && [dictionary objectForKey:@"modified"] != [NSNull null]) {
            self.modified = [HubDateUtils dateWithDateTimeString:[dictionary objectForKey:@"modified"]];
        }
        if ([dictionary objectForKey:@"created"] && [dictionary objectForKey:@"created"] != [NSNull null]) {
            self.created = [HubDateUtils dateWithDateTimeString:[dictionary objectForKey:@"created"]];
        }
    }
    return self;

}

#pragma mark --
#pragma mark NSCoding

- (id) initWithCoder:(NSCoder *)aDecoder {

    self = [super init];
    if (self) {
        if ([aDecoder containsValueForKey:@"id"]) {
            self.id = [aDecoder decodeObjectForKey:@"id"];
        }
        if ([aDecoder containsValueForKey:@"applicationId"]) {
            self.applicationId = [aDecoder decodeObjectForKey:@"applicationId"];
        }
        if ([aDecoder containsValueForKey:@"modified"]) {
            self.modified = [aDecoder decodeObjectForKey:@"modified"];
        }
        if ([aDecoder containsValueForKey:@"created"]) {
            self.created = [aDecoder decodeObjectForKey:@"created"];
        }
    }
    return self;

}

- (void) encodeWithCoder:(NSCoder *)aCoder {

    [aCoder encodeObject:id forKey:@"id"];
    [aCoder encodeObject:applicationId forKey:@"applicationId"];
    [aCoder encodeObject:modified forKey:@"modified"];
    [aCoder encodeObject:created forKey:@"created"];

}

@end
