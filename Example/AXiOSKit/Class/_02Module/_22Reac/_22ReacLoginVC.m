//
//  _22ReacLoginVC.m
//  AXiOSKit_Example
//
//  Created by 小星星吃KFC on 2021/7/9.
//  Copyright © 2021 axinger. All rights reserved.
//

#import "_22ReacLoginVC.h"
#import <Masonry/Masonry.h>
@import ReactiveObjC;
#import "_22LoginViewModel.h"
@interface _22ReacLoginVC ()

@property (nonatomic,strong) UITextField *usernameTextField;
@property (nonatomic,strong) UITextField *passwordTextField;
@property (nonatomic,strong) UIButton *button;
@property (nonatomic,strong) _22LoginViewModel *viewModel;

@end

@implementation _22ReacLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"模拟登录";
    self.view.backgroundColor = UIColor.whiteColor;
    
    
    self.viewModel = [[_22LoginViewModel alloc] init];
    
    self.usernameTextField = [[UITextField alloc] init];
    self.usernameTextField.placeholder = @"输入用户名";
    self.usernameTextField.backgroundColor = [UIColor purpleColor];
    
    self.passwordTextField = [[UITextField alloc] init];
    self.passwordTextField.placeholder = @"输入密码";
    self.passwordTextField.backgroundColor = [UIColor purpleColor];
    
    UIView *superView = self.view;
    [self.view addSubview:self.usernameTextField];
    [self.view addSubview:self.passwordTextField];
    
    @weakify(self)
    [self.usernameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(superView.mas_centerX);
        if (@available(iOS 11.0, *)) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop).mas_equalTo(20);
        } else {
            make.top.equalTo(self.view.mas_top).mas_equalTo(20);
        }
        make.width.equalTo(@(200));
        make.height.equalTo(@(35));
    }];
    [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.usernameTextField.mas_bottom).mas_equalTo(20);
        make.width.equalTo(self.usernameTextField.mas_width);
        make.height.equalTo(self.usernameTextField.mas_height);
        make.centerX.equalTo(self.usernameTextField.mas_centerX);
        
    }];
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:self.button];
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.passwordTextField.mas_bottom).mas_equalTo(20);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(30);
    }];
    [self.button setTitle:@"登陆" forState:UIControlStateNormal];
    self.button.backgroundColor = [UIColor redColor];
    
    //2、绑定viewModel
    [self.usernameTextField.rac_textSignal subscribeNext:^(id x) {
        @strongify(self)
        self.viewModel.username = x;
    }];
    [[self.passwordTextField rac_textSignal] subscribeNext:^(id x) {
        @strongify(self)
        self.viewModel.password = x;
    }];
    
    self.button.rac_command = self.viewModel.loginCommand;
    
    //判断是否正在执行
    [self.button.rac_command.executing subscribeNext:^(id x) {
        if ([x boolValue]) {
            NSLog(@"login..");
        } else {
            NSLog(@"end logining");
        }
    }];
    
    //执行结果
    [self.button.rac_command.executionSignals.flatten subscribeNext:^(id x) {
        NSLog(@"result-flatten:%@",x);
    }];
    [self.button.rac_command.executionSignals subscribeNext:^(RACSignal<id> * _Nullable x) {
        NSLog(@"result-executionSignals:%@",x);
    }];
    //错误处理
    [self.button.rac_command.errors subscribeNext:^(id x) {
        NSLog(@"error:%@",x);
    }];
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end
