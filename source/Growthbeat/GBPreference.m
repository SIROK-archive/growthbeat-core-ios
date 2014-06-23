//
//  GPPreference.m
//  pickaxe
//
//  Created by Kataoka Naoyuki on 2013/07/17.
//  Copyright (c) 2013年 SIROK, Inc. All rights reserved.
//

#import "GBPreference.h"

static GBPreference *sharedInstance = nil;
static NSString *const kGBPreferenceFileName = @"growthbeat-preferences";

@interface GBPreference () {

    NSURL *fileUrl;

}

@property (nonatomic, retain) NSURL *fileUrl;

@end

@implementation GBPreference

@synthesize fileUrl;

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
        self.fileUrl = [self preferenceFileUrl];
    }
    return self;

}

- (void) dealloc {

    self.fileUrl = nil;
}

- (id) objectForKey:(id <NSCopying>)key {

    NSDictionary *prefrences = [self preferences];

    return [prefrences objectForKey:key];

}

- (void) setObject:(id)object forKey:(id <NSCopying>)key {

    NSMutableDictionary *prefrences = [NSMutableDictionary dictionaryWithDictionary:[self preferences]];

    [prefrences setObject:object forKey:key];
    [prefrences writeToURL:fileUrl atomically:YES];

}

- (void) removeObjectForKey:(id <NSCopying>)key {

    NSMutableDictionary *prefrences = [NSMutableDictionary dictionaryWithDictionary:[self preferences]];

    [prefrences removeObjectForKey:key];
    [prefrences writeToURL:fileUrl atomically:YES];

}

- (void) removeAll {

    for (id key in [[self preferences] keyEnumerator]) {
        [self removeObjectForKey:key];
    }

}

- (NSDictionary *) preferences {
    return [NSDictionary dictionaryWithContentsOfURL:fileUrl];
}

- (NSURL *) preferenceFileUrl {

    NSArray *urls = [[NSFileManager defaultManager] URLsForDirectory:NSLibraryDirectory inDomains:NSUserDomainMask];

    if ([urls count] == 0) {
        return nil;
    }

    NSURL *url = [urls lastObject];
    return [NSURL URLWithString:kGBPreferenceFileName relativeToURL:url];

}

@end
