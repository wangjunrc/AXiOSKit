//
//  AXDateVC.m
//  AXiOSTools
//
//  Created by liuweixing on 16/4/28.
//  Copyright © 2016年 liuweixing. All rights reserved.
//

#import "AXDateVC.h"

typedef void(^DateBloack)(NSDate *date);

@interface AXDateVC ()

@property(nonatomic,copy)DateBloack  dateBloack;

@end

@implementation AXDateVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.datePicker.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.datePicker.datePickerMode = UIDatePickerModeDate;
}

- (IBAction)cancelBtnEvents:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)centerButtonEvents:(UIButton *)sender {
    if (self.dateBloack) {
        self.dateBloack(self.datePicker.date);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - set and get

/**
 时间选择器 默认显示 UIDatePickerModeDate 年月日
 
 @param showDate 当前显示时间
 @param block 回调
 */
-(void)didSelectDate:(NSDate *)showDate block:(void(^)(NSDate *date))block{
    
    [self didSelectPickerMode:UIDatePickerModeDate showDate:showDate block:block];
}

/**
 时间选择器
 
 @param datePickerMode 时间类型
 @param showDate 当前显示时间
 @param block 回调
 */
-(void)didSelectPickerMode:(UIDatePickerMode )datePickerMode showDate:(NSDate *)showDate block:(void(^)(NSDate *date))block{
    
    if (showDate) {
        self.datePicker.date = showDate;
    }
    self.datePicker.datePickerMode = datePickerMode;
    self.dateBloack = block;
    
}

@end
