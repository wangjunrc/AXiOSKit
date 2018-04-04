//
//  AXDateVC.m
//  AXTools
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


-(void)didSelectDate:(NSDate *)currentDate  block:(void(^)(NSDate *date))block{
    if (currentDate) {
        if (currentDate) {
            self.datePicker.date = currentDate;
        }
    }   self.dateBloack = block;
}

@end
