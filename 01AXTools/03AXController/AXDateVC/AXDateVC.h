//
//  AXDateVC.h
//  AXiOSTools
//
//  Created by liuweixing on 16/4/28.
//  Copyright © 2016年 liuweixing. All rights reserved.
//

#import "AXBaseAlertVC.h"
@interface AXDateVC : AXBaseAlertVC

@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;

-(void)didSelectDate:(NSDate *)currentDate  block:(void(^)(NSDate *date))block;

@end
