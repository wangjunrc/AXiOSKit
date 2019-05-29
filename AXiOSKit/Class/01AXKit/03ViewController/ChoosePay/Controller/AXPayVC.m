//
//  AXPayVC.m
//  AXiOSKit
//
//  Created by AXing on 2019/5/29.
//  Copyright © 2019 liu.weixing. All rights reserved.
//

#import "AXPayVC.h"
#import "AXChoosePayVC.h"
#import "AXiOSKit.h"

@interface AXPayVC ()

@end

@implementation AXPayVC

- (AXAlertControllerStyle )axAlertControllerStyle {
    return AXAlertControllerStyleUpward;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    AXChoosePayVC *choosePayVC = [[AXChoosePayVC alloc]init];
    choosePayVC.dataArray = self.dataArray;
    choosePayVC.orderMsgStr = self.orderMsgStr;
    choosePayVC.amountFloat = self.amountFloat;
    
    __weak typeof(self) weakSelf = self;
    choosePayVC.cancelBlock = ^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf dismissViewControllerAnimated:YES completion:nil];
    };
    
    choosePayVC.confirmPayBlock = ^(AXChoosePayModel *payModel) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        
        if (strongSelf.confirmPayBlock) {
            strongSelf.confirmPayBlock(payModel);
        }
        [self dismissViewControllerAnimated:YES completion:nil];
    };
    
    
    
    AXNavigationController *nav = [[AXNavigationController alloc]initWithRootViewController:choosePayVC];
    [self.view addSubview:nav.view];
    [self addChildViewController:nav];
    nav.view.backgroundColor = [UIColor greenColor];
    
    [nav.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(223+44);
    }];
    
}

@end
