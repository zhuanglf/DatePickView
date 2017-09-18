//
//  WKDatePickerView.m
//  DatePickView
//
//  Created by ZhuangLifeng on 17/6/28.
//  Copyright © 2016年 WondersEducation. All rights reserved.
//

#import "WKDatePickerView.h"
#import "WKNSDateCategory.h"

#define MAXYEAR 2050
#define MINYEAR 1970

@interface WKDatePickerView () <UIPickerViewDelegate,UIPickerViewDataSource,UIGestureRecognizerDelegate>

//日期存储数组
@property (strong, nonatomic) NSMutableArray *yearArray;
@property (strong, nonatomic) NSMutableArray *monthArray;
@property (strong, nonatomic) NSMutableArray *dayArray;
@property (strong, nonatomic) NSMutableArray *hourArray;
@property (strong, nonatomic) NSMutableArray *minuteArray;

@property (assign, nonatomic) NSInteger yearIndex;
@property (assign, nonatomic) NSInteger monthIndex;
@property (assign, nonatomic) NSInteger dayIndex;
@property (assign, nonatomic) NSInteger hourIndex;
@property (assign, nonatomic) NSInteger minuteIndex;

@property (assign, nonatomic) WKDateStyle datePickerStyle;

@property (strong, nonatomic) NSDate *selectDate;

@property (assign, nonatomic) NSInteger preRow;

@property (weak, nonatomic) IBOutlet UIPickerView *datePickerView;

@property (strong, nonatomic) NSDate *scrollToDate;//滚到指定日期
@property (strong, nonatomic) NSDate *currentDate; //默认显示时间

@end

#pragma mark - Constants Define


@implementation WKDatePickerView

#pragma mark - Properties Getter And Setter
- (NSMutableArray *)setArray:(id)mutableArray
{
    if (mutableArray){
        [mutableArray removeAllObjects];
    } else {
        mutableArray = [NSMutableArray array];
    }
    return mutableArray;
}

- (void)setMinLimitDate:(NSDate *)minLimitDate {
    _minLimitDate = minLimitDate;
    if ([_scrollToDate compare:self.minLimitDate] == NSOrderedAscending) {
        _scrollToDate = self.minLimitDate;
    }
    [self getNowDate:_scrollToDate animated:YES];
}

- (void)setMaxLimitDate:(NSDate *)maxLimitDate {
    _maxLimitDate = maxLimitDate;
    if ([_scrollToDate compare:self.maxLimitDate] == NSOrderedDescending) {
        _scrollToDate = self.maxLimitDate;
    }
    [self getNowDate:_scrollToDate animated:YES];
}

#pragma mark - Lifecycle

- (instancetype)initWithCurrentDate:(NSDate *)currentDate dateStyle:(WKDateStyle)datePickerStyle {
    self = [super init];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] lastObject];
        
        self.currentDate = currentDate;
        
        self.datePickerStyle = datePickerStyle;
        
        [self defaultConfig];
        
    }
    return self;
}

/*
- (instancetype)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame]))
    {
       //...
    }
    return self;
}
*/

/*
- (instancetype)initWithCoder:(NSCoder *)decoder {
    if ((self = [super initWithCoder:decoder]))
    {
        //...
    }
    return self;
}
*/

- (void)awakeFromNib
{
    [super awakeFromNib];
    
}

- (void)dealloc
{

}

#pragma mark - Setup
- (void)defaultConfig {
    
    self.datePickerView.showsSelectionIndicator = YES;
    self.datePickerView.delegate = self;
    self.datePickerView.dataSource = self;
    
    if (!_scrollToDate) {
        _scrollToDate = self.currentDate ? self.currentDate : [NSDate date];
    }
    
    
    //循环滚动时需要用到
    _preRow = (_scrollToDate.wk_year - MINYEAR) * 12 + _scrollToDate.wk_month - 1;
    
    //设置年月日时分数据
    self.yearArray = [self setArray:self.yearArray];
    self.monthArray = [self setArray:self.monthArray];
    self.dayArray = [self setArray:self.dayArray];
    self.hourArray = [self setArray:self.hourArray];
    self.minuteArray = [self setArray:self.minuteArray];
    
    for (int i = 0; i< 60; i ++) {
        NSString *num = [NSString stringWithFormat:@"%02d",i];
        if (i > 0 && i <= 12) {
            [self.monthArray addObject:num];
        }
        if (i < 24) {
            [self.hourArray addObject:num];
        }
            [self.minuteArray addObject:num];
    }
    for (NSInteger i = MINYEAR; i < MAXYEAR; i ++) {
        NSString *num = [NSString stringWithFormat:@"%ld",(long)i];
        [_yearArray addObject:num];
    }
    
    //最大最小限制
    if (!self.maxLimitDate) {
        self.maxLimitDate = [NSDate wk_dateWithString:@"2049-12-31 23:59" format:@"yyyy-MM-dd HH:mm"];
    }
    //最小限制
    if (!self.minLimitDate) {
        self.minLimitDate = [NSDate dateWithTimeIntervalSince1970:0];
    }
}

#pragma mark - Layout

/*
- (void)layoutSubviews
{
    [super layoutSubviews];
}
*/

#pragma mark - Drawing

/*
- (void)drawRect:(CGRect)rect
{

}
*/

#pragma mark - Actions
- (IBAction)wk_cancelButtonAction:(UIButton *)sender {
    
    if (_cancelSelectedBlock) {
        _cancelSelectedBlock();
    }
}

- (IBAction)wk_sureButtonAction:(UIButton *)sender {
    
    if (_sureSelectedBlock) {
        _sureSelectedBlock(_scrollToDate);
    }
}

#pragma mark - Notification

#pragma mark - KVO

#pragma mark - Delegate And DataSource Protocol

#pragma mark - UIPickerViewDelegate And UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    switch (self.datePickerStyle) {
        case DateStyleShowYearMonthDayHourMinute:
            return 5;
            
        case DateStyleShowYearMonthDay:
            return 3;
            
        case DateStyleShowYearMonth:
            return 2;
            
        case DateStyleShowMonthDayHourMinute:
            return 4;
            
        case DateStyleShowMonthDay:
            return 2;
            
        case DateStyleShowHourMinute:
            return 2;
        
        default:
            return 0;
    }
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSArray *numberArr = [self getNumberOfRowsInComponent];
    return [numberArr[component] integerValue];
}

- (NSArray *)getNumberOfRowsInComponent {
    
    NSInteger yearNum = self.yearArray.count;
    NSInteger monthNum = self.monthArray.count;
    NSInteger dayNum = [self DaysfromYear:[self.yearArray[_yearIndex] integerValue] andMonth:[self.monthArray[_monthIndex] integerValue]];
    NSInteger hourNum = self.hourArray.count;
    NSInteger minuteNUm = self.minuteArray.count;
    
    NSInteger timeInterval = MAXYEAR - MINYEAR;
    
    switch (self.datePickerStyle) {
        case DateStyleShowYearMonthDayHourMinute:
            return @[@(yearNum),@(monthNum),@(dayNum),@(hourNum),@(minuteNUm)];
            break;
            
        case DateStyleShowYearMonthDay:
            return @[@(yearNum),@(monthNum),@(dayNum)];
            break;
            
        case DateStyleShowYearMonth:
            return @[@(yearNum),@(monthNum)];
            break;
            
        case DateStyleShowMonthDayHourMinute:
            return @[@(monthNum*timeInterval),@(dayNum),@(hourNum),@(minuteNUm)];
            break;
            
        case DateStyleShowMonthDay:
            return @[@(monthNum*timeInterval),@(dayNum),@(hourNum)];
            break;
            
        case DateStyleShowHourMinute:
            return @[@(hourNum),@(minuteNUm)];
            break;
        
        default:
            return @[];
            break;
    }
    
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 35.0;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel *customLabel = (UILabel *)view;
    if (!customLabel) {
        customLabel = [[UILabel alloc] init];
        customLabel.textAlignment = NSTextAlignmentCenter;
        [customLabel setFont:[UIFont systemFontOfSize:20.0]];
    }
    NSString *title;
    
    switch (self.datePickerStyle) {
        case DateStyleShowYearMonthDayHourMinute:
            if (component == 0) {
                title = [NSString stringWithFormat:@"%@年",self.yearArray[row]];
            }
            if (component == 1) {
                title = [NSString stringWithFormat:@"%@月",self.monthArray[row]];
            }
            if (component == 2) {
                title = [NSString stringWithFormat:@"%@日",self.dayArray[row]];
            }
            if (component == 3) {
                title = [NSString stringWithFormat:@"%@时",self.hourArray[row]];
            }
            if (component == 4) {
                title = [NSString stringWithFormat:@"%@分",self.minuteArray[row]];
            }
            break;
            
        case DateStyleShowYearMonthDay:
            if (component == 0) {
                title = [NSString stringWithFormat:@"%@年",self.yearArray[row]];
            }
            if (component == 1) {
                title = [NSString stringWithFormat:@"%@月",self.monthArray[row]];
            }
            if (component == 2) {
                title = [NSString stringWithFormat:@"%@日",self.dayArray[row]];
            }
            break;
            
        case DateStyleShowYearMonth:
            if (component == 0) {
                title = [NSString stringWithFormat:@"%@年",self.yearArray[row]];
            }
            if (component == 1) {
                title = [NSString stringWithFormat:@"%@月",self.monthArray[row]];
            }
            break;
            
        case DateStyleShowMonthDayHourMinute:
            if (component == 0) {
                title = [NSString stringWithFormat:@"%@月",self.monthArray[row%12]];
            }
            if (component == 1) {
                title = [NSString stringWithFormat:@"%@日",self.dayArray[row]];
            }
            if (component == 2) {
                title = [NSString stringWithFormat:@"%@时",self.hourArray[row]];
            }
            if (component == 3) {
                title = [NSString stringWithFormat:@"%@分",self.minuteArray[row]];
            }
            break;
            
        case DateStyleShowMonthDay:
            if (component == 0) {
                title = [NSString stringWithFormat:@"%@月",self.monthArray[row%12]];
            }
            if (component == 1) {
                title = [NSString stringWithFormat:@"%@日",self.dayArray[row]];
            }
            break;
            
        case DateStyleShowHourMinute:
            if (component == 0) {
                title = [NSString stringWithFormat:@"%@时",self.hourArray[row]];
            }
            if (component == 1) {
                title = [NSString stringWithFormat:@"%@分",self.minuteArray[row]];
            }
            break;
        
        default:
            title = @"";
            break;
    }
    
    customLabel.text = title;
    customLabel.textColor = [UIColor blackColor];
    return customLabel;
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    switch (self.datePickerStyle) {
        case DateStyleShowYearMonthDayHourMinute:{
            
            if (component == 0) {
                _yearIndex = row;
            }
            if (component == 1) {
                _monthIndex = row;
            }
            if (component == 2) {
                _dayIndex = row;
            }
            if (component == 3) {
                _hourIndex = row;
            }
            if (component == 4) {
                _minuteIndex = row;
            }
            if (component == 0 || component == 1){
                [self DaysfromYear:[self.yearArray[_yearIndex] integerValue] andMonth:[self.monthArray[_monthIndex] integerValue]];
                if (self.dayArray.count - 1 < _dayIndex) {
                    _dayIndex = self.dayArray.count - 1;
                }
            }
        }
            break;
            
            
        case DateStyleShowYearMonthDay:{
            
            if (component == 0) {
                _yearIndex = row;
            }
            if (component == 1) {
                _monthIndex = row;
            }
            if (component == 2) {
                _dayIndex = row;
            }
            if (component == 0 || component == 1){
                [self DaysfromYear:[self.yearArray[_yearIndex] integerValue] andMonth:[self.monthArray[_monthIndex] integerValue]];
                if (self.dayArray.count - 1 < _dayIndex) {
                    _dayIndex = self.dayArray.count - 1;
                }
            }
        }
            break;
            
        case DateStyleShowYearMonth:{
            
            if (component == 0) {
                _yearIndex = row;
            }
            if (component == 1) {
                _monthIndex = row;
            }
        }
            break;
            
        case DateStyleShowMonthDayHourMinute:{
            
            if (component == 1) {
                _dayIndex = row;
            }
            if (component == 2) {
                _hourIndex = row;
            }
            if (component == 3) {
                _minuteIndex = row;
            }
            
            if (component == 0) {
                _monthIndex = row % 12;
                if (self.dayArray.count - 1 < _dayIndex) {
                    _dayIndex = self.dayArray.count -  1;
                }
            }
            [self DaysfromYear:[self.yearArray[_yearIndex] integerValue] andMonth:[self.monthArray[_monthIndex] integerValue]];
            
        }
            break;
            
        case DateStyleShowMonthDay:{
            
            if (component == 1) {
                _dayIndex = row;
            }
            if (component == 0) {
                _monthIndex = row % 12;
                if (self.dayArray.count - 1 < _dayIndex) {
                    _dayIndex = self.dayArray.count - 1;
                }
            }
            [self DaysfromYear:[self.yearArray[_yearIndex] integerValue] andMonth:[self.monthArray[_monthIndex] integerValue]];
        }
            break;
            
        case DateStyleShowHourMinute:{
            
            if (component == 0) {
                _hourIndex = row;
            }
            if (component == 1) {
                _minuteIndex = row;
            }
        }
            break;
            
        default:
            break;
    }
    
    [pickerView reloadAllComponents];
    
    NSString *dateStr = [NSString stringWithFormat:@"%@-%@-%@ %@:%@",self.yearArray[_yearIndex],self.monthArray[_monthIndex],self.dayArray[_dayIndex],self.hourArray[_hourIndex],self.minuteArray[_minuteIndex]];
    
    _scrollToDate = [NSDate wk_dateWithString:dateStr format:@"yyyy-MM-dd HH:mm"];
    
    if ([_scrollToDate compare:self.minLimitDate] == NSOrderedAscending) {
        _scrollToDate = self.minLimitDate;
        [self getNowDate:self.minLimitDate animated:YES];
    } else if ([_scrollToDate compare:self.maxLimitDate] == NSOrderedDescending){
        _scrollToDate = self.maxLimitDate;
        [self getNowDate:self.maxLimitDate animated:YES];
    }
    
    NSLog(@"%@",_scrollToDate);

}

#pragma mark - tools
//通过年月求每月天数
- (NSInteger)DaysfromYear:(NSInteger)year andMonth:(NSInteger)month {
    NSInteger num_year  = year;
    NSInteger num_month = month;
    
    BOOL isrunNian = num_year % 4 == 0 ? (num_year % 100 == 0 ? (num_year % 400 == 0 ? YES : NO) : YES) : NO;
    switch (num_month) {
        case 1:case 3:case 5:case 7:case 8:case 10:case 12:{
            [self setdayArray:31];
            return 31;
        }
        case 4:case 6:case 9:case 11:{
            [self setdayArray:30];
            return 30;
        }
        case 2:{
            if (isrunNian) {
                [self setdayArray:29];
                return 29;
            }else{
                [self setdayArray:28];
                return 28;
            }
        }
        default:
            break;
    }
    return 0;
}

//设置每月的天数数组
- (void)setdayArray:(NSInteger)num {
    [self.dayArray removeAllObjects];
    for (int i=1; i<=num; i++) {
        [self.dayArray addObject:[NSString stringWithFormat:@"%02d",i]];
    }
}

//滚动到指定的时间位置
- (void)getNowDate:(NSDate *)date animated:(BOOL)animated {
    if (!date) {
        date = [NSDate date];
    }
    
    [self DaysfromYear:date.wk_year andMonth:date.wk_month];
    
    _yearIndex = date.wk_year - MINYEAR;
    _monthIndex = date.wk_month - 1;
    _dayIndex = date.wk_day-1;
    _hourIndex = date.wk_hour;
    _minuteIndex = date.wk_minute;
    
    //循环滚动时需要用到
    _preRow = (_scrollToDate.wk_year - MINYEAR) * 12 + _scrollToDate.wk_month - 1;
    
    NSArray *indexArray;
    
    switch (self.datePickerStyle) {
        case DateStyleShowYearMonthDayHourMinute:
            indexArray = @[@(_yearIndex),@(_monthIndex),@(_dayIndex),@(_hourIndex),@(_minuteIndex)];
            break;
            
        case DateStyleShowYearMonthDay:
            indexArray = @[@(_yearIndex),@(_monthIndex),@(_dayIndex)];
            break;
            
        case DateStyleShowYearMonth:
            indexArray = @[@(_yearIndex),@(_monthIndex)];
            break;
            
        case DateStyleShowMonthDayHourMinute:
            indexArray = @[@(_monthIndex),@(_dayIndex),@(_hourIndex),@(_minuteIndex)];
            break;
            
        case DateStyleShowMonthDay:
            indexArray = @[@(_monthIndex),@(_dayIndex)];
            break;
            
        case DateStyleShowHourMinute:
            indexArray = @[@(_hourIndex),@(_minuteIndex)];
            break;
            
        default:
            break;
    }
    
    [self.datePickerView reloadAllComponents];
    
    for (int i = 0; i < indexArray.count; i ++) {
        if ((self.datePickerStyle == DateStyleShowMonthDayHourMinute || self.datePickerStyle == DateStyleShowMonthDay)&& i == 0) {
            NSInteger mIndex = [indexArray[i] integerValue] + (12 * (_scrollToDate.wk_year - MINYEAR));
            [self.datePickerView selectRow:mIndex inComponent:i animated:animated];
        } else {
            [self.datePickerView selectRow:[indexArray[i] integerValue] inComponent:i animated:animated];
        }
        
    }
}

@end
