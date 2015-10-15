//
//  DateUtils.m
//  Weekly
//
//  Created by horry on 15/10/15.
//  Copyright © 2015年 ___horryBear___. All rights reserved.
//

#import "DateUtils.h"

@interface DateUtils() {
	NSCalendar *calendar;
}

@end

@implementation DateUtils

+ (DateUtils *)sharedDateUtils {
	static DateUtils *instance;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		instance = [[self alloc] init];
	});
	return instance;
}

- (id)init {
	if (self = [super init]) {
		calendar = [NSCalendar currentCalendar];
	}
	return self;
}

- (BOOL)compareWithMonthAndDay:(NSDate *)date toDate:(NSDate *)compareDate {
	NSDateComponents *components = [calendar components:NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date];
	NSInteger month = [components month];
	NSInteger day = [components day];
	
	components = [calendar components:NSCalendarUnitMonth | NSCalendarUnitDay fromDate:compareDate];
	NSInteger compareMonth = [components month];
	NSInteger compareDay = [components day];
	
	return !(month == compareMonth) || !(day == compareDay);
}

- (NSInteger)dayInDate:(NSDate *)date {
	NSDateComponents *components = [calendar components:NSCalendarUnitDay fromDate:date];
	return [components day];
}

- (NSInteger)monthInDate:(NSDate *)date {
	NSDateComponents *components = [calendar components:NSCalendarUnitMonth fromDate:date];
	return [components month];
}

@end
