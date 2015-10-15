//
//  DateUtils.h
//  Weekly
//
//  Created by horry on 15/10/15.
//  Copyright © 2015年 ___horryBear___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateUtils : NSObject

+ (DateUtils *)sharedDateUtils;

- (BOOL)compareWithMonthAndDay:(NSDate *)date toDate:(NSDate *)compareDate;
- (NSInteger)dayInDate:(NSDate *)date;
- (NSInteger)monthInDate:(NSDate *)date;
@end
