//
//  WKDatePickerView.h
//  DatePickView
//
//  Created by ZhuangLifeng on 17/6/28.
//  Copyright © 2016年 WondersEducation. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - @class

#pragma mark - Enum
typedef NS_ENUM(NSInteger, WKDateStyle) {
    
    DateStyleShowYearMonthDayHourMinute  = 0,
    DateStyleShowYearMonthDay,
    DateStyleShowYearMonth,
    DateStyleShowMonthDayHourMinute,
    DateStyleShowMonthDay,
    DateStyleShowHourMinute
    
};

#pragma mark - Blocks
typedef void(^SureSelectedBlock)(NSDate *);
typedef void(^CancelSelectedBlock)();

@interface WKDatePickerView: UIView

#pragma mark - Properties

//限制最大时间（没有设置默认2049）
@property (strong, nonatomic) NSDate *maxLimitDate;
//限制最小时间（没有设置默认1970）
@property (strong, nonatomic) NSDate *minLimitDate;

@property (copy, nonatomic) SureSelectedBlock sureSelectedBlock;

@property (copy, nonatomic) CancelSelectedBlock cancelSelectedBlock;

#pragma mark - Actions

/**
 创建日期选择器

 @param currentDate 指定当前时间
 @param datePickerStyle 样式
 */
- (instancetype)initWithCurrentDate:(NSDate *)currentDate dateStyle:(WKDateStyle)datePickerStyle;

@end
