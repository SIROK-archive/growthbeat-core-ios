//
//  HubRequestMethod.m
//  hub
//
//  Created by Kataoka Naoyuki on 2014/06/12.
//  Copyright (c) 2014 SIROK, Inc. All rights reserved.
//

#import "HubRequestMethod.h"

NSString *NSStringFromHubRequestMethod(HubRequestMethod requestMethod) {

    switch (requestMethod) {
        case HubRequestMethodGet:
            return @"GET";
        case HubRequestMethodPost:
            return @"POST";
        case HubRequestMethodPut:
            return @"PUT";
        case HubRequestMethodDelete:
            return @"DELETE";
        default:
            return nil;
    }

}

HubRequestMethod HubRequestMethodFromNSString(NSString *requestMethodString) {

    if ([requestMethodString isEqualToString:@"GET"]) {
        return HubRequestMethodGet;
    }
    if ([requestMethodString isEqualToString:@"POST"]) {
        return HubRequestMethodPost;
    }
    if ([requestMethodString isEqualToString:@"PUT"]) {
        return HubRequestMethodPut;
    }
    if ([requestMethodString isEqualToString:@"DELETE"]) {
        return HubRequestMethodDelete;
    }

    return HubRequestMethodUnknown;

}
