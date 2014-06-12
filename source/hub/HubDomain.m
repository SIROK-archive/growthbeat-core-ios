//
//  HubDomain.m
//  hub
//
//  Created by Naoyuki Kataoka on 2014/06/13.
//  Copyright (c) 2014 SIROK, Inc. All rights reserved.
//

#import "HubDomain.h"

@implementation HubDomain

+ (id) domainWithDictionary:(NSDictionary *)dictionary {

    if (!dictionary) {
        return nil;
    }

    return [[self alloc] initWithDictionary:dictionary];

}

- (id) initWithDictionary:(NSDictionary *)dictionary {
    return [self init];
}

@end
