//
//  GBIntent.m
//  GrowthbeatCore
//
//  Created by 堀内 暢之 on 2015/03/08.
//  Copyright (c) 2015年 SIROK, Inc. All rights reserved.
//

#import "GBIntent.h"
#import "GBDateUtils.h"

@implementation GBIntent

@synthesize action;
@synthesize data;

- (instancetype) initWithDictionary:(NSDictionary *)dictionary {
    
    self = [super init];
    if (self) {
        if ([dictionary objectForKey:@"action"] && [dictionary objectForKey:@"action"] != [NSNull null]) {
            self.action = [dictionary objectForKey:@"action"];
        }
        if ([dictionary objectForKey:@"data"] && [dictionary objectForKey:@"data"] != [NSNull null]) {
            self.data = [dictionary objectForKey:@"data"];
        }
    }
    return self;
    
}

#pragma mark --
#pragma mark NSCoding

- (instancetype) initWithCoder:(NSCoder *)aDecoder {
	self = [super init];
	if (self) {
		if ([aDecoder containsValueForKey:@"action"]) {
			self.action = [aDecoder decodeObjectForKey:@"action"];
		}
		if ([aDecoder containsValueForKey:@"data"]) {
			self.data = [aDecoder decodeObjectForKey:@"data"];
		}
	}
	return self;
}

- (void) encodeWithCoder:(NSCoder *)aCoder {
	[aCoder encodeObject:action forKey:@"action"];
	[aCoder encodeObject:data forKey:@"data"];
}

@end
