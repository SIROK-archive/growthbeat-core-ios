//
//  GBRSAUtils.h
//  GrowthbeatCore
//
//  Created by Kataoka Naoyuki on 2014/07/25.
//  Copyright (c) 2014年 SIROK, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GBRSAUtils : NSObject

+ (NSString *)encrypt:(NSString *)data publicKey:(NSString *)publicKey;

@end
