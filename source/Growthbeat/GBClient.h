//
//  GBClient.h
//  Growthbeat
//
//  Created by Naoyuki Kataoka on 2014/06/13.
//  Copyright (c) 2014 SIROK, Inc. All rights reserved.
//

#import "GBDomain.h"
#import "GBApplication.h"

@interface GBClient : GBDomain <NSCoding> {

    NSString *id;
    NSDate *created;
    GBApplication *application;

}

@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSDate *created;
@property (nonatomic, strong) GBApplication *application;

+ (GBClient *)createWithApplicationId:(NSString *)applicationId secret:(NSString *)secret;

@end
