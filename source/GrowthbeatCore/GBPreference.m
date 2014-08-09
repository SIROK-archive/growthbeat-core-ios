//
//  GPPreference.m
//  pickaxe
//
//  Created by Kataoka Naoyuki on 2013/07/17.
//  Copyright (c) 2013年 SIROK, Inc. All rights reserved.
//

#import "GBPreference.h"
#import "GrowthbeatCore.h"

@implementation GBPreference

@synthesize fileName;

- (instancetype) init {
    self = [super init];
    if (self) {
        self.fileName = nil;
    }
    return self;
}

- (instancetype) initWithFileName:(NSString *)initialFileName {
    self = [super init];
    if (self) {
        self.fileName = initialFileName;
    }
    return self;
}

- (id) objectForKey:(id <NSCopying>)key {

    NSDictionary *prefrences = [self preferences];

    return [prefrences objectForKey:key];

}

- (void) setObject:(id)object forKey:(id <NSCopying>)key {

    NSMutableDictionary *prefrences = [NSMutableDictionary dictionaryWithDictionary:[self preferences]];

    [prefrences setObject:object forKey:key];
    [prefrences writeToURL:[self preferenceFileUrl] atomically:YES];

}

- (void) removeObjectForKey:(id <NSCopying>)key {

    NSMutableDictionary *prefrences = [NSMutableDictionary dictionaryWithDictionary:[self preferences]];

    [prefrences removeObjectForKey:key];
    [prefrences writeToURL:[self preferenceFileUrl] atomically:YES];

}

- (void) removeAll {

    for (id key in [[self preferences] keyEnumerator]) {
        [self removeObjectForKey:key];
    }

}

- (NSDictionary *) preferences {
    return [NSDictionary dictionaryWithContentsOfURL:[self preferenceFileUrl]];
}

- (NSURL *) preferenceFileUrl {
    
    if (!fileName) {
        [[[GrowthbeatCore sharedInstance] logger] error:@"GBPreference's fileName is not set."];
        return nil;
    }
    
    NSArray *urls = [[NSFileManager defaultManager] URLsForDirectory:NSLibraryDirectory inDomains:NSUserDomainMask];

    if ([urls count] == 0) {
        return nil;
    }

    NSURL *url = [urls lastObject];
    return [NSURL URLWithString:self.fileName relativeToURL:url];

}

@end
