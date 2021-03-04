//
//  AXDateVC.h
//  AXiOSKit
//
//  Created by 小星星吃KFC on 2021/3/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AXDateVC : UIViewController

@property (strong, nonatomic)  UIDatePicker *datePicker;

/**
 时间选择器

 @param datePickerMode 时间类型
 @param showDate 当前显示时间
 @param confirm 确定
 @param cancel 取消
 */
- (void)didSelectPickerMode:(UIDatePickerMode )datePickerMode
                   showDate:(NSDate *)showDate
                    confirm:(void(^)(NSDate *date))confirm
                     cancel:(void(^)(void))cancel;

/**
 时间选择器 默认显示 UIDatePickerModeDate 年月日

 @param showDate 当前显示时间
 @param confirm 确定
 @param cancel 取消
 */
- (void)didSelectDate:(NSDate *)showDate
              confirm:(void(^)(NSDate *date))confirm
               cancel:(void(^)(void))cancel;


@end

NS_ASSUME_NONNULL_END
