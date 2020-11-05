//
//  DLSilentDateSetView.h
//  DLAppStore
//
//  Created by 小星星吃KFC on 2020/11/5.
//  Copyright © 2020 江苏电力信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DLSilentDatePickerView : UIView

@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UIDatePicker *datePicker;

@end


@interface DLSilentDateSetView : UIView

@property(nonatomic, strong) UIView *topBgView;

@property(nonatomic, strong) UILabel *titleLabel;

@property(nonatomic, strong) UIButton *completionBtn;
@property(nonatomic, strong) UIView *tipBgView;
@property(nonatomic, strong) UILabel *tipLabel;
@property(nonatomic, strong) UIView *weekBgView;
@property(nonatomic, strong) NSArray<UIButton *> *weekBtnArray;



@property(nonatomic, strong) DLSilentDatePickerView *startDateView;
@property(nonatomic, strong) DLSilentDatePickerView *endDateView;



@property(nonatomic, strong) UIButton *cancelBtn;

@end

NS_ASSUME_NONNULL_END
