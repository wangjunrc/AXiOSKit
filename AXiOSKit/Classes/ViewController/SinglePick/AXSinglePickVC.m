//
//  AXSinglePickVC.m
//  BigApple
//
//  Created by liuweixing on 2016/10/21.
//  Copyright © 2016年 liuweixing. All rights reserved.
//

#import "AXSinglePickVC.h"
#import <Masonry/Masonry.h>
#import <AXiOSKit/AXViewControllerTransitioning.h>
@interface AXSinglePickVC () <UIPickerViewDelegate, UIPickerViewDataSource>

@property(nonatomic,strong) UIView *bgView;
@property(nonatomic,strong) UIView *titleView;
@property (nonatomic,strong)  UIPickerView* pickerView;
@property(nonatomic, strong) UIButton *cancelBtn;
@property(nonatomic,strong) UIButton* confirmBtn;
@property(nonatomic, copy) void (^confirmBlock)(NSInteger index);

@property(nonatomic, copy) void (^cancelBlock)(void);

@property(nonatomic, copy) NSArray* dataArray;

@property(nonatomic, assign) NSInteger showRow;

@end

@implementation AXSinglePickVC

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        [self ax_alertObserver:^(AXAlertTransitioningObserver *observer) {
            observer.alertControllerStyle = AXAlertControllerStyleUpward;
        }];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.bgView];
    [self.bgView addSubview:self.titleView];
    [self.titleView addSubview:self.cancelBtn];
    [self.titleView addSubview:self.confirmBtn];
    [self.bgView addSubview:self.pickerView];
    
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
    
    [self.pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_equalTo(0);
        make.top.equalTo(self.titleView.mas_bottom);
    }];
}

#pragma mark - UIPicker Delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView*)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView*)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
    return self.dataArray.count;
}

- (NSString*)pickerView:(UIPickerView*)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    return self.dataArray[row];
}

- (void)pickerView:(UIPickerView*)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    //    if (component == 0) {
    //        //        [pickerView selectedRowInComponent:1];
    //        [pickerView reloadComponent:1];
    //    }
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

- (void)cancelBtnEvents:(UIButton*)sender{
    
    if (self.cancelBlock) {
        self.cancelBlock();
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)confirmBtnEvents:(UIButton*)sender{
    
    if (self.confirmBlock) {
        NSInteger selectComp = [self.pickerView selectedRowInComponent:0];
        self.confirmBlock(selectComp);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 单选
 
 @param dataArray 内容
 @param row 当前显示的row
 @param confirm 确定
 @param cancel 取消
 */
- (void)didSelected:(NSArray<NSString*>*)dataArray showRow:(NSInteger)row confirm:(void (^)(NSInteger index))confirm cancel:(void (^)(void))cancel
{
    
    self.dataArray = dataArray;
    self.confirmBlock = confirm;
    self.cancelBlock = cancel;
    self.showRow = row;
    [self.pickerView reloadComponent:0];
    
    if (row < self.dataArray.count) {
        [self.pickerView selectRow:row inComponent:0 animated:YES];
    }
    
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
        [_confirmBtn addTarget:self action:@selector(confirmBtnEvents:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmBtn;
}
- (UIPickerView *)pickerView {
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc]init];
        _pickerView.dataSource = self;
        _pickerView.delegate = self;
    }
    return _pickerView;
}
@end
