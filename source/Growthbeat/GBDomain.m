//
//  GBDomain.m
//  Growthbeat
//
//  Created by Naoyuki Kataoka on 2014/06/13.
//  Copyright (c) 2014 SIROK, Inc. All rights reserved.
//

#import "GBDomain.h"
#import "GBHttpClient.h"

@implementation GBDomain

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
