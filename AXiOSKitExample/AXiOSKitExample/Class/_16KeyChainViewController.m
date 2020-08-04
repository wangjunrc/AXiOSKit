//
//  _16KeyChainViewController.m
//  AXiOSKitExample
//
//  Created by 小星星吃KFC on 2020/8/3.
//  Copyright © 2020 liuweixing. All rights reserved.
//

#import "_16KeyChainViewController.h"
#import <Masonry/Masonry.h>
#import <AXiOSKit/AXiOSKit.h>
#import <SSKeychain/SSKeychain.h>

@interface _16KeyChainViewController ()

@end

@implementation _16KeyChainViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = UIColor.whiteColor;

    UIButton *btn = UIButton.alloc.init;
    [btn setTitle:@"get" forState:UIControlStateNormal];
    btn.backgroundColor = UIColor.orangeColor;
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(100);
        make.top.mas_equalTo(100);
    }];
    [btn ax_addActionBlock:^(UIButton *_Nullable button) {
        NSString *pas =    [SSKeychain passwordForService:@"com.ax.group" account:@"user"];
        AXLoger(@"%@", pas);
    }];

    UIButton *btn2 = UIButton.alloc.init;
    [btn2 setTitle:@"set" forState:UIControlStateNormal];
    btn2.backgroundColor = UIColor.orangeColor;
    [self.view addSubview:btn2];
    [btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(100);
        make.top.equalTo(btn.mas_bottom).offset(10);
    }];
    [btn2 ax_addActionBlock:^(UIButton *_Nullable button) {
        AXLoger(@"%@", [NSBundle mainBundle].bundleIdentifier);
        NSError *error = nil;
        BOOL result = [ SSKeychain setPassword:@"abc123" forService:@"com.ax.group" account:@"user" error:&error];
        AXLoger(@"result = %d", result);
    }];
    
}

@end
