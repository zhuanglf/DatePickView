//
//  ViewController.m
//  DatePickView
//
//  Created by ZhuangLifeng on 17/6/28.
//  Copyright © 2017年 庄黎峰. All rights reserved.
//

#import "ViewController.h"
#import "WKAlertController.h"
#import "WKDatePickerView.h"
#import "WKNSDateCategory.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)chooseDateButtonAction:(UIButton *)sender {
    
    //选择开始日期
    WKDatePickerView *datePickerView = [[WKDatePickerView alloc] initWithCurrentDate:[NSDate date] dateStyle:DateStyleShowYearMonthDayHourMinute];
//    datePickerView.minLimitDate = [NSDate wk_dateWithString:@"2010-01-01 00:00" format:@"yyyy-MM-dd HH:mm"];
//    datePickerView.maxLimitDate = [NSDate wk_dateWithString:@"2020-12-31 23:59" format:@"yyyy-MM-dd HH:mm"];
    
    WKAlertController *alertController = [WKAlertController alertControllerWithAlertView:datePickerView preferredStyle:WKActionSheetAnimationStyle];
    alertController.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    alertController.backgoundTapDismissEnable = YES;
    
    [self presentViewController:alertController animated:YES completion:nil];
    
    datePickerView.sureSelectedBlock = ^(NSDate *date){
        
        NSString *dateString = [NSDate wk_stringWithDate:date format:@"yyyy-MM-dd HH:mm"];
        NSLog(@"%@",dateString);

        
        [alertController dismissViewControllerAnimated:YES completion:^{
            
        }];
    };
    
    datePickerView.cancelSelectedBlock = ^() {
        [alertController dismissViewControllerAnimated:YES completion:^{
            
        }];
    };

}

@end
