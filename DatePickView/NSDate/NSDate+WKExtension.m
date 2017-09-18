//
//  NSDate+WKExtension.m
//  WondersAppDevKit
//
//  Created by YuZhenKao on 16/8/3.
//  Copyright © 2016年 penghe. All rights reserved.
//

#import "NSDate+WKExtension.h"

@implementation NSDate (WKExtension)
- (NSUInteger)wk_day {
    return [NSDate wk_day:self];
}

- (NSUInteger)wk_month {
    return [NSDate wk_month:self];
}

- (NSUInteger)wk_year {
    return [NSDate wk_year:self];
}

- (NSUInteger)wk_hour {
    return [NSDate wk_hour:self];
}

- (NSUInteger)wk_minute {
    return [NSDate wk_minute:self];
}

- (NSUInteger)wk_second {
    return [NSDate wk_second:self];
}

+ (NSUInteger)wk_day:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitDay) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSDayCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents day];
}

+ (NSUInteger)wk_month:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitMonth) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSMonthCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents month];
}

+ (NSUInteger)wk_year:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitYear) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSYearCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents year];
}

+ (NSUInteger)wk_hour:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitHour) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSHourCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents hour];
}

+ (NSUInteger)wk_minute:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitMinute) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSMinuteCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents minute];
}

+ (NSUInteger)wk_second:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitSecond) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSSecondCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents second];
}

- (NSUInteger)wk_daysInYear {
    return [NSDate wk_daysInYear:self];
}

+ (NSUInteger)wk_daysInYear:(NSDate *)date {
    return [self wk_isLeapYear:date] ? 366 : 365;
}

- (BOOL)wk_isLeapYear {
    return [NSDate wk_isLeapYear:self];
}

+ (BOOL)wk_isLeapYear:(NSDate *)date {
    NSUInteger year = [date wk_year];
    if ((year % 4  == 0 && year % 100 != 0) || year % 400 == 0) {
        return YES;
    }
    return NO;
}

- (NSString *)wk_formatYMD {
    return [NSDate wk_formatYMD:self];
}

+ (NSString *)wk_formatYMD:(NSDate *)date {
    return [NSString stringWithFormat:@"%lu-%02lu-%02lu",(long)[date wk_year],(long)[date wk_month], (long)[date wk_day]];
}

- (NSUInteger)wk_weeksOfMonth {
    return [NSDate wk_weeksOfMonth:self];
}

+ (NSUInteger)wk_weeksOfMonth:(NSDate *)date {
    return [[date wk_lastdayOfMonth] wk_weekOfYear] - [[date wk_begindayOfMonth] wk_weekOfYear] + 1;
}

- (NSUInteger)wk_weekOfYear {
    return [NSDate wk_weekOfYear:self];
}

+ (NSUInteger)wk_weekOfYear:(NSDate *)date {
    NSUInteger i;
    NSUInteger year = [date wk_year];
    
    NSDate *lastdate = [date wk_lastdayOfMonth];
    
    for (i = 1;[[lastdate wk_dateAfterDay:-7 * i] wk_year] == year; i++) {
        
    }
    
    return i;
}

- (NSDate *)wk_dateAfterDay:(NSUInteger)day {
    return [NSDate wk_dateAfterDate:self day:day];
}

+ (NSDate *)wk_dateAfterDate:(NSDate *)date day:(NSInteger)day {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
    [componentsToAdd setDay:day];
    
    NSDate *dateAfterDay = [calendar dateByAddingComponents:componentsToAdd toDate:date options:0];
    
    return dateAfterDay;
}

- (NSDate *)wk_dateAfterMonth:(NSUInteger)month {
    return [NSDate wk_dateAfterDate:self month:month];
}

+ (NSDate *)wk_dateAfterDate:(NSDate *)date month:(NSInteger)month {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
    [componentsToAdd setMonth:month];
    NSDate *dateAfterMonth = [calendar dateByAddingComponents:componentsToAdd toDate:date options:0];
    
    return dateAfterMonth;
}

- (NSDate *)wk_begindayOfMonth {
    return [NSDate wk_begindayOfMonth:self];
}

+ (NSDate *)wk_begindayOfMonth:(NSDate *)date {
    return [self wk_dateAfterDate:date day:-[date wk_day] + 1];
}

- (NSDate *)wk_lastdayOfMonth {
    return [NSDate wk_lastdayOfMonth:self];
}

+ (NSDate *)wk_lastdayOfMonth:(NSDate *)date {
    NSDate *lastDate = [self wk_begindayOfMonth:date];
    return [[lastDate wk_dateAfterMonth:1] wk_dateAfterDay:-1];
}

- (NSUInteger)wk_daysAgo {
    return [NSDate wk_daysAgo:self];
}

+ (NSUInteger)wk_daysAgo:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    NSDateComponents *components = [calendar components:(NSCalendarUnitDay)
                                               fromDate:date
                                                 toDate:[NSDate date]
                                                options:0];
#else
    NSDateComponents *components = [calendar components:(NSDayCalendarUnit)
                                               fromDate:date
                                                 toDate:[NSDate date]
                                                options:0];
#endif
    
    return [components day];
}

- (NSInteger)wk_weekday {
    return [NSDate wk_weekday:self];
}

+ (NSInteger)wk_weekday:(NSDate *)date {
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [gregorian components:(NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitWeekday) fromDate:date];
    NSInteger weekday = [comps weekday];
    
    return weekday;
}

- (NSString *)wk_dayFromWeekday {
    return [NSDate wk_dayFromWeekday:self];
}

+ (NSString *)wk_dayFromWeekday:(NSDate *)date {
    switch([date wk_weekday]) {
        case 1:
            return @"星期天";
            break;
        case 2:
            return @"星期一";
            break;
        case 3:
            return @"星期二";
            break;
        case 4:
            return @"星期三";
            break;
        case 5:
            return @"星期四";
            break;
        case 6:
            return @"星期五";
            break;
        case 7:
            return @"星期六";
            break;
        default:
            break;
    }
    return @"";
}

- (BOOL)wk_isSameDay:(NSDate *)anotherDate {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components1 = [calendar components:(NSCalendarUnitYear
                                                          | NSCalendarUnitMonth
                                                          | NSCalendarUnitDay)
                                                fromDate:self];
    NSDateComponents *components2 = [calendar components:(NSCalendarUnitYear
                                                          | NSCalendarUnitMonth
                                                          | NSCalendarUnitDay)
                                                fromDate:anotherDate];
    return ([components1 year] == [components2 year]
            && [components1 month] == [components2 month]
            && [components1 day] == [components2 day]);
}

- (BOOL)wk_isToday {
    return [self wk_isSameDay:[NSDate date]];
}

- (NSDate *)wk_dateByAddingDays:(NSUInteger)days {
    NSDateComponents *c = [[NSDateComponents alloc] init];
    c.day = days;
    return [[NSCalendar currentCalendar] dateByAddingComponents:c toDate:self options:0];
}

/**
 *  Get the month as a localized string from the given month number
 *
 *  @param month The month to be converted in string
 *  [1 - January]
 *  [2 - February]
 *  [3 - March]
 *  [4 - April]
 *  [5 - May]
 *  [6 - June]
 *  [7 - July]
 *  [8 - August]
 *  [9 - September]
 *  [10 - October]
 *  [11 - November]
 *  [12 - December]
 *
 *  @return Return the given month as a localized string
 */
+ (NSString *)wk_monthWithMonthNumber:(NSInteger)month {
    switch(month) {
        case 1:
            return @"January";
            break;
        case 2:
            return @"February";
            break;
        case 3:
            return @"March";
            break;
        case 4:
            return @"April";
            break;
        case 5:
            return @"May";
            break;
        case 6:
            return @"June";
            break;
        case 7:
            return @"July";
            break;
        case 8:
            return @"August";
            break;
        case 9:
            return @"September";
            break;
        case 10:
            return @"October";
            break;
        case 11:
            return @"November";
            break;
        case 12:
            return @"December";
            break;
        default:
            break;
    }
    return @"";
}

+ (NSString *)wk_stringWithDate:(NSDate *)date format:(NSString *)format {
    return [date wk_stringWithFormat:format];
}

- (NSString *)wk_stringWithFormat:(NSString *)format {
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:format];
    
    NSString *retStr = [outputFormatter stringFromDate:self];
    
    return retStr;
}

+ (NSDate *)wk_dateWithString:(NSString *)string format:(NSString *)format {
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setDateFormat:format];
    
    NSDate *date = [inputFormatter dateFromString:string];
    
    return date;
}

- (NSDate *)wk_dateWithFormatter:(NSString *)formatter {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = formatter;
    NSString *dateStr = [dateFormatter stringFromDate:self];
    return [dateFormatter dateFromString:dateStr];
}

- (NSUInteger)wk_daysInMonth:(NSUInteger)month {
    return [NSDate wk_daysInMonth:self month:month];
}

+ (NSUInteger)wk_daysInMonth:(NSDate *)date month:(NSUInteger)month {
    switch (month) {
        case 1: case 3: case 5: case 7: case 8: case 10: case 12:
            return 31;
        case 2:
            return [date wk_isLeapYear] ? 29 : 28;
    }
    return 30;
}

- (NSUInteger)wk_daysInMonth {
    return [NSDate wk_daysInMonth:self];
}

+ (NSUInteger)wk_daysInMonth:(NSDate *)date {
    return [self wk_daysInMonth:date month:[date wk_month]];
}

- (NSString *)wk_timeInfo {
    return [NSDate wk_timeInfoWithDate:self];
}

+ (NSString *)wk_timeInfoWithDate:(NSDate *)date {
    return [self wk_timeInfoWithDateString:[self wk_stringWithDate:date format:[self wk_ymdHmsFormat]]];
}

+ (NSString *)wk_timeInfoWithDateString:(NSString *)dateString {
    NSDate *date = [self wk_dateWithString:dateString format:[self wk_ymdHmsFormat]];
    
    NSDate *curDate = [NSDate date];
    NSTimeInterval time = -[date timeIntervalSinceDate:curDate];
    
    int month = (int)([curDate wk_month] - [date wk_month]);
    int year = (int)([curDate wk_year] - [date wk_year]);
    int day = (int)([curDate wk_day] - [date wk_day]);
    
    NSTimeInterval retTime = 1.0;
    if (time < 3600) { // 小于一小时
        retTime = time / 60;
        retTime = retTime <= 0.0 ? 1.0 : retTime;
        return [NSString stringWithFormat:@"%.0f分钟前", retTime];
    } else if (time < 3600 * 24) { // 小于一天，也就是今天
        retTime = time / 3600;
        retTime = retTime <= 0.0 ? 1.0 : retTime;
        return [NSString stringWithFormat:@"%.0f小时前", retTime];
    } else if (time < 3600 * 24 * 2) {
        return @"昨天";
    }
    // 第一个条件是同年，且相隔时间在一个月内
    // 第二个条件是隔年，对于隔年，只能是去年12月与今年1月这种情况
    else if ((abs(year) == 0 && abs(month) <= 1)
             || (abs(year) == 1 && [curDate wk_month] == 1 && [date wk_month] == 12)) {
        int retDay = 0;
        if (year == 0) { // 同年
            if (month == 0) { // 同月
                retDay = day;
            }
        }
        
        if (retDay <= 0) {
            // 获取发布日期中，该月有多少天
            int totalDays = (int)[self wk_daysInMonth:date month:[date wk_month]];
            
            // 当前天数 + （发布日期月中的总天数-发布日期月中发布日，即等于距离今天的天数）
            retDay = (int)[curDate wk_day] + (totalDays - (int)[date wk_day]);
        }
        
        return [NSString stringWithFormat:@"%d天前", (abs)(retDay)];
    } else  {
        if (abs(year) <= 1) {
            if (year == 0) { // 同年
                return [NSString stringWithFormat:@"%d个月前", abs(month)];
            }
            
            // 隔年
            int month = (int)[curDate wk_month];
            int preMonth = (int)[date wk_month];
            if (month == 12 && preMonth == 12) {// 隔年，但同月，就作为满一年来计算
                return @"1年前";
            }
            return [NSString stringWithFormat:@"%d个月前", (abs)(12 - preMonth + month)];
        }
        
        return [NSString stringWithFormat:@"%d年前", abs(year)];
    }
    
    return @"1小时前";
}

- (NSString *)wk_kxtimeInfo
{
    NSDate *curDate = [NSDate date];
    NSTimeInterval time = -[self timeIntervalSinceDate:curDate];
    int day = (int)([curDate wk_day] - [self wk_day]);
    
    NSTimeInterval retTime = 1.0;
    if (time < 60*10) {//小于10分钟
        return @"刚刚";
    }else if (time < 3600) {//小于一小时
        retTime = time / 60;
        retTime = retTime <= 0.0 ? 1.0 : retTime;
        return [NSString stringWithFormat:@"%.0f分钟前", retTime];
    }else if (day < 1) { // 小于一天，也就是今天
        return [NSDate wk_stringWithDate:self format:[self wk_hmsFormat]];
    } else if (day == 1) {
        return @"昨天";
    }else
    {
        return [NSDate wk_stringWithDate:self format:[self wk_ymdFormat]];
    }
    
    
    return @"一小时前";
}

- (NSString *)wk_ymdFormat {
    return [NSDate wk_ymdFormat];
}

- (NSString *)wk_hmsFormat {
    return [NSDate wk_hmsFormat];
}

- (NSString *)wk_ymdHmsFormat {
    return [NSDate wk_ymdHmsFormat];
}

+ (NSString *)wk_ymdFormat {
    return @"yyyy-MM-dd";
}

+ (NSString *)wk_hmsFormat {
    return @"HH:mm:ss";
}

+ (NSString *)wk_ymdHmsFormat {
    return [NSString stringWithFormat:@"%@ %@", [self wk_ymdFormat], [self wk_hmsFormat]];
}

- (NSDate *)wk_offsetYears:(int)numYears {
    return [NSDate wk_offsetYears:numYears fromDate:self];
}

+ (NSDate *)wk_offsetYears:(int)numYears fromDate:(NSDate *)fromDate {
    if (fromDate == nil) {
        return nil;
    }
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#else
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
#endif
    
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setYear:numYears];
    
    return [gregorian dateByAddingComponents:offsetComponents
                                      toDate:fromDate
                                     options:0];
}

- (NSDate *)wk_offsetMonths:(int)numMonths {
    return [NSDate wk_offsetMonths:numMonths fromDate:self];
}

+ (NSDate *)wk_offsetMonths:(int)numMonths fromDate:(NSDate *)fromDate {
    if (fromDate == nil) {
        return nil;
    }
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#else
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
#endif
    
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setMonth:numMonths];
    
    return [gregorian dateByAddingComponents:offsetComponents
                                      toDate:fromDate
                                     options:0];
}

- (NSDate *)wk_offsetDays:(int)numDays {
    return [NSDate wk_offsetDays:numDays fromDate:self];
}

+ (NSDate *)wk_offsetDays:(int)numDays fromDate:(NSDate *)fromDate {
    if (fromDate == nil) {
        return nil;
    }
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#else
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
#endif
    
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setDay:numDays];
    
    return [gregorian dateByAddingComponents:offsetComponents
                                      toDate:fromDate
                                     options:0];
}

- (NSDate *)wk_offsetHours:(int)hours {
    return [NSDate wk_offsetHours:hours fromDate:self];
}

+ (NSDate *)wk_offsetHours:(int)numHours fromDate:(NSDate *)fromDate {
    if (fromDate == nil) {
        return nil;
    }
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#else
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
#endif
    
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setHour:numHours];
    
    return [gregorian dateByAddingComponents:offsetComponents
                                      toDate:fromDate
                                     options:0];
}
@end
