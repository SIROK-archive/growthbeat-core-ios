//
//  GBDateUtils.m
//  Growthbeat
//
//  Created by Naoyuki Kataoka on 2014/06/13.
//  Copyright (c) 2014 SIROK, Inc. All rights reserved.
//

#import "GBDateUtils.h"

@implementation GBDateUtils

+ (NSDate *) dateWithDateTimeString:(NSString *)dateTimeString {

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];

    [dateFormatter setCalendar:[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar]];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];

    return [dateFormatter dateFromString:dateTimeString];

}

@end
