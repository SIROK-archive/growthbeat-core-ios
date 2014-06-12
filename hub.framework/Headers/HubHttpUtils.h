//
//  HubHttpUtils.h
//  hub
//
//  Created by Kataoka Naoyuki on 2014/06/12.
//  Copyright (c) 2014 SIROK, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HubHttpUtils : NSObject

+ (NSString *)queryStringWithDictionary:(NSDictionary *)params;

@end
