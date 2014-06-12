//
//  HubRequestMethod.h
//  hub
//
//  Created by Naoyuki Kataoka on 2014/06/12.
//  Copyright (c) 2014 SIROK, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM (NSInteger, HubRequestMethod) {
    HubRequestMethodUnknown = 0,
    HubRequestMethodGet,
    HubRequestMethodPost,
    HubRequestMethodPut,
    HubRequestMethodDelete
};

NSString *NSStringFromHubRequestMethod(HubRequestMethod requestMethod);
HubRequestMethod HubRequestMethodFromNSString(NSString *requestMethodString);
