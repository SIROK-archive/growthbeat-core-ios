//
//  GBBlocksClientObserver.h
//  Growthbeat
//
//  Created by Kataoka Naoyuki on 2014/06/30.
//  Copyright (c) 2014年 SIROK, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GBClientObserver.h"

@interface GBBlocksClientObserver : NSObject <GBClientObserver>

- (instancetype)initWithCallback:(void (^)(GBClient *client))callback;

@end
