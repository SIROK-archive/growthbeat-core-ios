//
//  AppDelegate.m
//  GrowthbeatCoreSample
//
//  Created by Kataoka Naoyuki on 2014/08/10.
//  Copyright (c) 2014年 SIROK, Inc. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL) application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[GrowthbeatCore sharedInstance] initializeWithApplicationId:@"OyTg8vZd4KTNQDJ5" credentialId:@"3EKydeJ0imxJ5WqS22FJfdVamFLgu7XA"];
    return YES;
}

@end
