//
//  GBLogger.h
//  Growthbeat
//
//  Created by Kataoka Naoyuki on 2014/06/13.
//  Copyright (c) 2014年 SIROK, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GBLogger : NSObject {
    
    BOOL silent;
    
}

@property (nonatomic, assign) BOOL silent;

+ (GBLogger *)sharedInstance;
- (void) log:(NSString *)format, ...;

@end
