//
//  GBUrlIntentHandler.m
//  GrowthbeatCore
//
//  Created by 堀内 暢之 on 2015/03/08.
//  Copyright (c) 2015年 SIROK, Inc. All rights reserved.
//

#import "GBUrlIntentHandler.h"
#import <UIKit/UIKit.h>
#import "GrowthbeatCore.h"
#import "GBUrlIntent.h"

@implementation GBUrlIntentHandler

- (BOOL) handleIntent:(GBIntent *)intent {

    if (intent.type != GBIntentTypeUrl) {
        return NO;
    }
    if (![intent isKindOfClass:[GBUrlIntent class]]) {
        return NO;
    }

    GBUrlIntent *urlIntent = (GBUrlIntent *)intent;

    @try {
        NSURL *url = [NSURL URLWithString:urlIntent.url];
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
