//
//  AppDelegate.m
//  GrowthbeatSample
//
//  Created by Kataoka Naoyuki on 2014/06/30.
//  Copyright (c) 2014年 SIROK, Inc. All rights reserved.
//

#import "AppDelegate.h"
#import <Growthbeat/GBBlocksClientObserver.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [Growthbeat addClientObserver:[[GBBlocksClientObserver alloc] initWithCallback:^(GBClient *client) {
        NSLog(@"Current client ID:%@", client.id);
    }]];
    [Growthbeat setHttpClientBaseUrl:[NSURL URLWithString:@"http://api.localhost:8085/"]];
    [Growthbeat initializeWithApplicationId:@"dy6VlRMnN3juhW9L" credentialId:@"NuvkVhQtRDG2nrNeDzHXzZO5c6j0Xu5t"];
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application {
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
}

- (void)applicationWillTerminate:(UIApplication *)application  {
}

@end
