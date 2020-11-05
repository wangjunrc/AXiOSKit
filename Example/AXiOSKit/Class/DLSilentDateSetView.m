//
//  DLSilentDateSetView.m
//  DLAppStore
//
//  Created by 小星星吃KFC on 2020/11/5.
//  Copyright © 2020 江苏电力信息技术有限公司. All rights reserved.
//

#import "DLSilentDateSetView.h"
#import <Masonry/Masonry.h>
@implementation DLSilentDatePickerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.whiteColor;
        [self _initView];
    }
    return self;
}

- (void)_initView {
    [self addSubview:self.titleLabel];
    [self addSubview:self.datePicker];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(15);
        make.left.right.mas_equalTo(0);
    }];
    [self.datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).mas_equalTo(0);
        make.left.right.bottom.mas_equalTo(0);
    }];
}

- (UIDatePicker *)datePicker {
    if (!_datePicker) {
        _datePicker = [UIDatePicker.alloc init];
        _datePicker.backgroundColor = [UIColor whiteColor];
        _datePicker.datePickerMode = UIDatePickerModeTime;
        if (@available(iOS 13.4, *)) {
            _datePicker.preferredDatePickerStyle = UIDatePickerStyleWheels;
        }
        //   else if (@available(iOS 14, *)) {
        //        self.datePicker.preferredDatePickerStyle = UIDatePickerStyleInline;
        //    }
        //    1. "en_GB"英文 24小时
        //    2. "zh_GB"中文24小时
        //    3. ”zh_CN“中文12小时
        _datePicker.calendar = [NSCalendar currentCalendar];
        _datePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_GB"];
        _datePicker.timeZone = [NSTimeZone systemTimeZone];
    }
    return _datePicker;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel.alloc init];
        _titleLabel.font = [UIFont systemFontOfSize:(15)];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

@end

@implementation DLSilentDateSetView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _initView];
    }
    return self;
}

- (void)_initView {
    [self addSubview:self.topBgView];
    [self.topBgView addSubview:self.titleLabel];
    [self.topBgView addSubview:self.completionBtn];
    
    [self addSubview:self.tipBgView];
    [self.tipBgView addSubview:self.tipLabel];
    
    [self addSubview:self.weekBgView];
    __weak typeof(self) weakSelf = self;
    [self.weekBtnArray enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf.weekBgView addSubview:obj];
    }];
    [self addSubview:self.startDateView];
    [self addSubview:self.endDateView];
    [self addSubview:self.cancelBtn];
    
    [self.topBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(45);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(0);
    }];
    [self.completionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.right.mas_equalTo(18);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(27);
    }];
    
    [self.tipBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topBgView.mas_bottom).mas_equalTo(0);
        make.left.right.mas_equalTo(0);
//        make.bottom.equalTo(self.tipLabel.mas_bottom).mas_offset(10);
        make.height.mas_equalTo(50);
    }];
    
    self.tipLabel .backgroundColor = UIColor.whiteColor;
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.mas_equalTo(UIEdgeInsetsMake(10, 18, 10, 10));
//        make.top.left.mas_equalTo(10);
//        make.right.mas_equalTo(-10);
//        make.bottom.equalTo(self.tipBgView.mas_bottom).mas_offset(-10);
        
        make.left.equalTo(self.tipLabel.superview.mas_left).offset(10);
        make.top.equalTo(self.tipLabel.superview.mas_top).offset(10);
        make.right.equalTo(self.tipLabel.superview.mas_right).offset(-10);
        make.bottom.equalTo(self.tipLabel.superview.mas_bottom).offset(-10);
        
        
    }];
    
    [self.weekBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tipBgView.mas_bottom).mas_equalTo(0);
        make.left.right.mas_equalTo(0);
//        make.height.mas_equalTo(42+30);
    }];

    // 实现masonry水平固定间隔方法

    //    [self.weekBtnArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:10 leadSpacing:18 tailSpacing:18];


    // 实现masonry水平固定控件宽度方法
    [self.weekBtnArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:42 leadSpacing:18 tailSpacing:18];
    [self.weekBtnArray mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(15);
        make.height.mas_equalTo(42);
        make.bottom.mas_equalTo(-15);
    }];

    
    [self.startDateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.weekBgView.mas_bottom).mas_equalTo(1);
        make.left.mas_equalTo(0);
        make.bottom.equalTo(self.cancelBtn.mas_top).mas_equalTo(-6);
        make.right.equalTo(self.endDateView.mas_left);

        make.width.equalTo(self.endDateView.mas_width);
    }];

    [self.endDateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.startDateView);
        make.right.mas_equalTo(0);
        make.left.equalTo(self.startDateView.mas_right);
    }];
//
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(44);
        make.bottom.mas_equalTo(-ax_safe_area_insets_bottom_offset(20));
    }];
    
    
}

- (UIView *)topBgView {
    if (!_topBgView) {
        _topBgView = [UIView.alloc init];
        _topBgView.backgroundColor = UIColor.whiteColor;
    }
    return _topBgView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel.alloc init];
        _titleLabel.text = @"时间设定";
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont systemFontOfSize:(18)];
    }
    return _titleLabel;
}

- (UIButton *)completionBtn {
    if (!_completionBtn) {
        _completionBtn = [UIButton.alloc init];
        _completionBtn.backgroundColor = [UIColor redColor];
        _completionBtn.layer.cornerRadius = 5;
        [_completionBtn setTitle:@"完成" forState:UIControlStateNormal];
        [_completionBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        _completionBtn.titleLabel.font = [UIFont systemFontOfSize:(12)];
    }
    return _completionBtn;
}

- (UIView *)tipBgView {
    if (!_tipBgView) {
        _tipBgView = [UIView.alloc init];
        _tipBgView.backgroundColor = [UIColor redColor];
    }
    return _tipBgView;
}

- (UILabel *)tipLabel {
    if (!_tipLabel) {
        _tipLabel = [UILabel.alloc init];
        _tipLabel.text = @"设置的时候段内您拒绝接收来自此平台的任何信息。";
        _tipLabel.font = [UIFont systemFontOfSize:(12)];
        _tipLabel.textColor = [UIColor greenColor];
    }
    return _tipLabel;
}
- (UIView *)weekBgView {
    if (!_weekBgView) {
        _weekBgView = [UIView.alloc init];
        _weekBgView.backgroundColor = [UIColor whiteColor];
    }
    return _weekBgView;
}


- (NSArray<UIButton *> *)weekBtnArray {
    if (!_weekBtnArray) {
        NSArray<NSString *> *textArr = @[@"周一", @"周二", @"周三", @"周四", @"周五", @"周六", @"周日"];
        NSMutableArray<UIButton *> *temp = [NSMutableArray array];
        [textArr enumerateObjectsUsingBlock:^(NSString *_Nonnull obj, NSUInteger idx, BOOL *_Nonnull stop) {
            UIButton *btn = [UIButton.alloc init];
            btn.titleLabel.font = [UIFont systemFontOfSize:(12)];
            [btn setTitle:obj forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
            [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
            btn.layer.cornerRadius = 3;
            btn.layer.borderWidth = 0.5;
            ///默认灰色
            btn.layer.borderColor = [UIColor redColor].CGColor;
            btn.layer.backgroundColor = [UIColor whiteColor].CGColor;
            
            [temp addObject:btn];
        }];
        _weekBtnArray = temp.copy;
    }
    return _weekBtnArray;
}

- (DLSilentDatePickerView *)startDateView {
    if (!_startDateView) {
        _startDateView = [DLSilentDatePickerView.alloc init];
        _startDateView.titleLabel.text = @"开始";
    }
    return _startDateView;
}
- (DLSilentDatePickerView *)endDateView {
    if (!_endDateView) {
        _endDateView = [DLSilentDatePickerView.alloc init];
        _endDateView.titleLabel.text = @"结束";
    }
    return _endDateView;
}

- (UIButton *)cancelBtn {
    if (!_cancelBtn) {
        _cancelBtn = [UIButton.alloc init];
        _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:(16)];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}
-(void)btnAction:(UIButton *)btn{
    btn.selected = !btn.selected;
}
-(void)cancelAction:(UIButton *)btn{
    
}

@end
