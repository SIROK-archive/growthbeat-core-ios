//
//  Hub.h
//  hub
//
//  Created by Kataoka Naoyuki on 2014/06/13.
//  Copyright (c) 2014年 SIROK, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Hub : NSObject

+ (void)initializeWithApplicationId:(NSString *)applicationId secret:(NSString *)secret;

@end
