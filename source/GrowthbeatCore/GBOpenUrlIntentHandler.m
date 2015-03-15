//
//  GBOpenUrlIntentHandler.m
//  GrowthbeatCore
//
//  Created by 堀内 暢之 on 2015/03/08.
//  Copyright (c) 2015年 SIROK, Inc. All rights reserved.
//

#import "GBOpenUrlIntentHandler.h"
#import <UIKit/UIKit.h>
#import "GrowthbeatCore.h"

@implementation GBOpenUrlIntentHandler

- (BOOL)handleIntent:(GBIntent *)intent {
    
	if (![intent.action isEqualToString:@"open_url"])
        return NO;
    
    @try {
        NSURL *url = [NSURL URLWithString:[intent.data objectForKey:@"url"]];
        return ![[UIApplication sharedApplication] openURL:url];
    }
    @catch (NSException *exception) {
        [[[GrowthbeatCore sharedInstance] logger] warn:@"Handling intent error: %@", exception];
    }
    @finally {
    }
    
    return NO;
    
}

@end
