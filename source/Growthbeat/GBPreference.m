//
//  GPPreference.m
//  pickaxe
//
//  Created by Kataoka Naoyuki on 2013/07/17.
//  Copyright (c) 2013年 SIROK, Inc. All rights reserved.
//

#import "GBPreference.h"

static GBPreference *sharedInstance = nil;
static NSString *const kGBDefaultPreferenceFileName = @"growthbeat-preferences";

@implementation GBPreference

@synthesize fileName;

+ (GBPreference *) sharedInstance {
    @synchronized(self) {
        if (!sharedInstance) {
            sharedInstance = [[self alloc] init];
        }
        return sharedInstance;
    }
}

- (id) init {
    self = [super init];
    if (self) {
        self.fileName = kGBDefaultPreferenceFileName;
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

    NSArray *urls = [[NSFileManager defaultManager] URLsForDirectory:NSLibraryDirectory inDomains:NSUserDomainMask];

    if ([urls count] == 0) {
        return nil;
    }

    NSURL *url = [urls lastObject];
    return [NSURL URLWithString:self.fileName relativeToURL:url];

}

@end
