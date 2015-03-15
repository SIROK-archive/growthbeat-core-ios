//
//  GBOpenBrowserIntentHandler.m
//  GrowthbeatCore
//
//  Created by 堀内 暢之 on 2015/03/08.
//  Copyright (c) 2015年 SIROK, Inc. All rights reserved.
//

#import "GBOpenBrowserIntentHandler.h"
#import <UIKit/UIKit.h>

@implementation GBOpenBrowserIntentHandler

- (BOOL)handleIntent:(GBIntent *)intent {
    
	if (![intent.action isEqualToString:@"open-browser"])
        return NO;
    
    BOOL error = NO;
    @try {
        NSURL *url = [NSURL URLWithString:[intent.data objectForKey:@"url"]];
        error = [[UIApplication sharedApplication] openURL:url];
    }
    @catch (NSException *exception) {
        NSLog(@"exception %@", exception);
        error = YES;
    }
    @finally {
        
    }
    return !error;
    
}

@end
