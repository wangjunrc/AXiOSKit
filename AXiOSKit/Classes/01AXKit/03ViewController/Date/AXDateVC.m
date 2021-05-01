//
//  AXDateVC.m
//  AXiOSKit
//
//  Created by 小星星吃KFC on 2021/3/4.
//

#import "AXDateVC.h"
#import <Masonry/Masonry.h>
#import <AXViewControllerTransitioning/AXViewControllerTransitioning.h>

@interface AXDateVC ()
@property(nonatomic,strong)UIView *bgView;
@property(nonatomic,strong)UIView *titleView;
@property(nonatomic, strong) UIButton *cancelBtn;
@property(nonatomic, strong) UIButton *confirmBtn;
@property (nonatomic, copy) void(^confirmBloack)(NSDate *date);

@property (nonatomic, copy) void(^cancelBlock)(void);

@end

@implementation AXDateVC

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        [self ax_alertObserver:^(AXAlertTransitioningObserver *observer) {
            observer.alertControllerStyle = AXAlertControllerStyleUpward;
        }];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.bgView];
    [self.bgView addSubview:self.titleView];
    [self.titleView addSubview:self.cancelBtn];
    [self.titleView addSubview:self.confirmBtn];
    [self.bgView addSubview:self.datePicker];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_equalTo(0);
        make.height.mas_equalTo(250);
    }];
    
    [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(50);
    }];
    
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.centerY.mas_equalTo(0);
        make.height.equalTo(self.titleView);
        make.width.mas_equalTo(50);
    }];
    
    [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.centerY.mas_equalTo(0);
        make.height.equalTo(self.titleView);
        make.width.mas_equalTo(50);
    }];
   
    [self.datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_equalTo(0);
        make.top.equalTo(self.titleView.mas_bottom);
    }];
}

/// 调用者自控制是否点击空白页面 消失
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if ([touches.anyObject.view isEqual:self.view]) {
        if (self.cancelBlock) {
            self.cancelBlock();
        }
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)cancelBtnEvents:(UIButton *)sender {
    if (self.cancelBlock) {
        self.cancelBlock();
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)centerButtonEvents:(UIButton *)sender {
    if (self.confirmBloack) {
        self.confirmBloack(self.datePicker.date);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - set and get

/**
 时间选择器
 
 @param datePickerMode 时间类型
 @param showDate 当前显示时间
 @param confirm 确定
 @param cancel 取消
 */
- (void)didSelectPickerMode:(UIDatePickerMode )datePickerMode showDate:(NSDate *)showDate confirm:(void(^)(NSDate *date))confirm cancel:(void(^)(void))cancel{
    
    if (showDate) {
        self.datePicker.date = showDate;
    }
    self.datePicker.datePickerMode = datePickerMode;
    self.confirmBloack = confirm;
    self.cancelBlock = cancel;
}

/**
 时间选择器 默认显示 UIDatePickerModeDate 年月日
 
 @param showDate 当前显示时间
 @param confirm 确定
 @param cancel 取消
 */
- (void)didSelectDate:(NSDate *)showDate confirm:(void(^)(NSDate *date))confirm cancel:(void(^)(void))cancel{
    
    [self didSelectPickerMode:UIDatePickerModeDate showDate:showDate confirm:confirm cancel:cancel];
}

- (UIDatePicker *)datePicker {
    if (!_datePicker) {
        _datePicker = [[UIDatePicker alloc]init];
        
        _datePicker.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _datePicker.datePickerMode = UIDatePickerModeDate;
        if (@available(iOS 13.4, *)) {
            _datePicker.preferredDatePickerStyle = UIDatePickerStyleWheels;
        }
    //   else if (@available(iOS 14, *)) {
    //        self.datePicker.preferredDatePickerStyle = UIDatePickerStyleInline;
    //    }
    //    1. "en_GB"英文 24小时
    //    2. "zh_GB"中文24小时
    //    3. ”zh_CN“中文12小时
        /// UIDatePickerModeCountDownTimer 设置只有 时分 24 小时 含有单位
        _datePicker.calendar = [NSCalendar currentCalendar];
        _datePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_GB"];
        _datePicker.timeZone =[NSTimeZone systemTimeZone];
    }
    return _datePicker;
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
        _bgView.backgroundColor = UIColor.whiteColor;
    }
    return _bgView;
}

- (UIView *)titleView {
    if (!_titleView) {
        _titleView = [[UIView alloc]init];
        _titleView.backgroundColor = UIColor.whiteColor;
    }
    return _titleView;
}
- (UIButton *)cancelBtn {
    if (!_cancelBtn) {
        _cancelBtn = [[UIButton alloc]init];
        _cancelBtn.backgroundColor = UIColor.whiteColor;
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(cancelBtnEvents:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

- (UIButton *)confirmBtn {
    if (!_confirmBtn) {
        _confirmBtn = [[UIButton alloc]init];
        _confirmBtn.backgroundColor = UIColor.whiteColor;
        [_confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_confirmBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        [_confirmBtn addTarget:self action:@selector(centerButtonEvents:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmBtn;
}

@end
