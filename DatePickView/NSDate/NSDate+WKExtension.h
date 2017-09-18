//
//  NSDate+WKExtension.h
//  WondersAppDevKit
//
//  Created by YuZhenKao on 16/8/3.
//  Copyright © 2016年 penghe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (WKExtension)
/**
 * 获取日、月、年、小时、分钟、秒
 */
- (NSUInteger)wk_day;
- (NSUInteger)wk_month;
- (NSUInteger)wk_year;
- (NSUInteger)wk_hour;
- (NSUInteger)wk_minute;
- (NSUInteger)wk_second;
+ (NSUInteger)wk_day:(NSDate *)date;
+ (NSUInteger)wk_month:(NSDate *)date;
+ (NSUInteger)wk_year:(NSDate *)date;
+ (NSUInteger)wk_hour:(NSDate *)date;
+ (NSUInteger)wk_minute:(NSDate *)date;
+ (NSUInteger)wk_second:(NSDate *)date;

/**
 * 获取一年中的总天数
 */
- (NSUInteger)wk_daysInYear;
+ (NSUInteger)wk_daysInYear:(NSDate *)date;

/**
 * 判断是否是润年
 * @return YES表示润年，NO表示平年
 */
- (BOOL)wk_isLeapYear;
+ (BOOL)wk_isLeapYear:(NSDate *)date;

/**
 * 获取该日期是该年的第几周
 */
- (NSUInteger)wk_weekOfYear;
+ (NSUInteger)wk_weekOfYear:(NSDate *)date;

/**
 * 获取格式化为YYYY-MM-dd格式的日期字符串
 */
- (NSString *)wk_formatYMD;
+ (NSString *)wk_formatYMD:(NSDate *)date;

/**
 * 返回当前月一共有几周(可能为4,5,6)
 */
- (NSUInteger)wk_weeksOfMonth;
+ (NSUInteger)wk_weeksOfMonth:(NSDate *)date;

/**
 * 获取该月的第一天的日期
 */
- (NSDate *)wk_begindayOfMonth;
+ (NSDate *)wk_begindayOfMonth:(NSDate *)date;

/**
 * 获取该月的最后一天的日期
 */
- (NSDate *)wk_lastdayOfMonth;
+ (NSDate *)wk_lastdayOfMonth:(NSDate *)date;

/**
 * 返回day天后的日期(若day为负数,则为|day|天前的日期)
 */
- (NSDate *)wk_dateAfterDay:(NSUInteger)day;
+ (NSDate *)wk_dateAfterDate:(NSDate *)date day:(NSInteger)day;

/**
 * 返回day天后的日期(若day为负数,则为|day|天前的日期)
 */
- (NSDate *)wk_dateAfterMonth:(NSUInteger)month;
+ (NSDate *)wk_dateAfterDate:(NSDate *)date month:(NSInteger)month;

/**
 * 返回numYears年后的日期
 */
- (NSDate *)wk_offsetYears:(int)numYears;
+ (NSDate *)wk_offsetYears:(int)numYears fromDate:(NSDate *)fromDate;

/**
 * 返回numMonths月后的日期
 */
- (NSDate *)wk_offsetMonths:(int)numMonths;
+ (NSDate *)wk_offsetMonths:(int)numMonths fromDate:(NSDate *)fromDate;

/**
 * 返回numDays天后的日期
 */
- (NSDate *)wk_offsetDays:(int)numDays;
+ (NSDate *)wk_offsetDays:(int)numDays fromDate:(NSDate *)fromDate;

/**
 * 返回numHours小时后的日期
 */
- (NSDate *)wk_offsetHours:(int)hours;
+ (NSDate *)wk_offsetHours:(int)numHours fromDate:(NSDate *)fromDate;

/**
 * 距离该日期前几天
 */
- (NSUInteger)wk_daysAgo;
+ (NSUInteger)wk_daysAgo:(NSDate *)date;

/**
 *  获取星期几
 *
 *  @return Return weekday number
 *  [1 - Sunday]
 *  [2 - Monday]
 *  [3 - Tuerday]
 *  [4 - Wednesday]
 *  [5 - Thursday]
 *  [6 - Friday]
 *  [7 - Saturday]
 */
- (NSInteger)wk_weekday;
+ (NSInteger)wk_weekday:(NSDate *)date;

/**
 *  获取星期几(名称)
 *
 *  @return Return weekday as a localized string
 *  [1 - Sunday]
 *  [2 - Monday]
 *  [3 - Tuerday]
 *  [4 - Wednesday]
 *  [5 - Thursday]
 *  [6 - Friday]
 *  [7 - Saturday]
 */
- (NSString *)wk_dayFromWeekday;
+ (NSString *)wk_dayFromWeekday:(NSDate *)date;

/**
 *  日期是否相等
 *
 *  @param anotherDate The another date to compare as NSDate
 *  @return Return YES if is same day, NO if not
 */
- (BOOL)wk_isSameDay:(NSDate *)anotherDate;

/**
 *  是否是今天
 *
 *  @return Return if self is today
 */
- (BOOL)wk_isToday;

/**
 *  Add days to self
 *
 *  @param days The number of days to add
 *  @return Return self by adding the gived days number
 */
- (NSDate *)wk_dateByAddingDays:(NSUInteger)days;

/**
 *  根据月份获取月的名称
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
+ (NSString *)wk_monthWithMonthNumber:(NSInteger)month;

/**
 * 根据日期返回字符串
 */
+ (NSString *)wk_stringWithDate:(NSDate *)date format:(NSString *)format;
- (NSString *)wk_stringWithFormat:(NSString *)format;
+ (NSDate *)wk_dateWithString:(NSString *)string format:(NSString *)format;
- (NSDate *)wk_dateWithFormatter:(NSString *)formatter;

/**
 * 获取指定月份的天数
 */
- (NSUInteger)wk_daysInMonth:(NSUInteger)month;
+ (NSUInteger)wk_daysInMonth:(NSDate *)date month:(NSUInteger)month;

/**
 * 获取当前月份的天数
 */
- (NSUInteger)wk_daysInMonth;
+ (NSUInteger)wk_daysInMonth:(NSDate *)date;

/**
 * 返回x分钟前/x小时前/昨天/x天前/x个月前/x年前
 */
- (NSString *)wk_timeInfo;
+ (NSString *)wk_timeInfoWithDate:(NSDate *)date;
+ (NSString *)wk_timeInfoWithDateString:(NSString *)dateString;

/**
 *48小时内返回xx前/hh:mm:ss，大于48小时返回yy:mm:dd
 */
- (NSString *)wk_kxtimeInfo;

/**
 * 分别获取yyyy-MM-dd/HH:mm:ss/yyyy-MM-dd HH:mm:ss格式的字符串
 */
- (NSString *)wk_ymdFormat;
- (NSString *)wk_hmsFormat;
- (NSString *)wk_ymdHmsFormat;
+ (NSString *)wk_ymdFormat;
+ (NSString *)wk_hmsFormat;
+ (NSString *)wk_ymdHmsFormat;
@end
