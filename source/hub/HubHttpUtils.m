//
//  HubHttpUtils.m
//  hub
//
//  Created by Kataoka Naoyuki on 2014/06/12.
//  Copyright (c) 2014 SIROK, Inc. All rights reserved.
//

#import "HubHttpUtils.h"

@implementation HubHttpUtils

+ (NSString *) queryStringWithDictionary:(NSDictionary *)params {

    NSMutableArray *combinedParams = [NSMutableArray array];

    for (NSString *key in [params keyEnumerator]) {
        NSString *encodedKey = [key stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        id values = [params objectForKey:key];
        if (![values isKindOfClass:[NSArray class]]) {
            values = [NSArray arrayWithObject:values];
        }
        for (id value in values) {
            NSString *encodedValue = [[NSString stringWithFormat:@"%@", value] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [combinedParams addObject:[NSString stringWithFormat:@"%@=%@", encodedKey, encodedValue]];
        }
    }

    return [combinedParams componentsJoinedByString:@"&"];

}

@end
