//
//  GBClientObserver.h
//  Growthbeat
//
//  Created by Kataoka Naoyuki on 2014/06/30.
//  Copyright (c) 2014年 SIROK, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GBClient.h"

@protocol GBClientObserver <NSObject>

- (void)update:(GBClient *)client;

@end
