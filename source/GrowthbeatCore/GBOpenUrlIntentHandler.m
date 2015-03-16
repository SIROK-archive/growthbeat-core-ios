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
#import "GBOpenUrlIntent.h"

@implementation GBOpenUrlIntentHandler

- (BOOL)handleIntent:(GBIntent *)intent {
    
    if (intent.type != GBIntentTypeOpenUrl)
        return NO;
    if (![intent isKindOfClass:[GBOpenUrlIntent class]])
        return NO;
    
    GBOpenUrlIntent *openUrlIntent = (GBOpenUrlIntent *)intent;
    
    @try {
        NSURL *url = [NSURL URLWithString:openUrlIntent.url];
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
