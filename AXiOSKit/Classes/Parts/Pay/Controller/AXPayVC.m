//
//  AXPayVC.m
//  AXiOSKit
//
//  Created by axing on 2019/5/29.
//  Copyright © 2019 liu.weixing. All rights reserved.
//

#import "AXPayVC.h"
#import "NSObject+AXKit.h"
#import "UIImage+AXBundle.h"
#if __has_include(<Masonry/Masonry.h>)
#import <Masonry/Masonry.h>
#elif __has_include("Masonry.h")
#import "Masonry.h"
#endif
#import "AXPayChildVC.h"
#import <AXiOSKit/AXViewControllerTransitioning.h>
@interface AXPayVC ()

@end

@implementation AXPayVC

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
    //    self.view.backgroundColor = [UIColor clearColor];
    AXPayChildVC* choosePayVC = [[AXPayChildVC alloc] init];
    
    choosePayVC.payArray = self.dataArray;
    choosePayVC.orderText = self.orderText;
    choosePayVC.amountText = self.amountText;
    
    __weak typeof(self) weakSelf = self;
    choosePayVC.cancelBlock = ^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf dismissViewControllerAnimated:YES completion:nil];
    };
    
    choosePayVC.confirmPayBlock = ^(AXChoosePayModel* payModel) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        
        if (strongSelf.confirmPayBlock) {
            strongSelf.confirmPayBlock(payModel);
        }
        [strongSelf dismissViewControllerAnimated:YES completion:nil];
    };
    
    UINavigationController* nav =
    [[UINavigationController alloc] initWithRootViewController:choosePayVC];
    [self.view addSubview:nav.view];
    [self addChildViewController:nav];
    [nav didMoveToParentViewController:self];
//    nav.view.backgroundColor = UIColor.orangeColor;
    [nav.view mas_makeConstraints:^(MASConstraintMaker* make) {
        make.left.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(300 + 44);
    }];
}

- (NSArray<AXChoosePayModel *> *)dataArray{
    if (!_dataArray) {
        NSMutableArray<AXChoosePayModel *> *temp = [NSMutableArray array];
        {
            AXChoosePayModel *model = [AXChoosePayModel ax_init];
            model.name = @"支付宝";
            model.iconImage =  [UIImage axBundle_imageNamed:@"ax_icon_zhifubao"];
            [temp addObject:model];
        }
        {
            AXChoosePayModel *model = [AXChoosePayModel ax_init];
            model.name = @"微信";
            //            model.iconImage = [UIImage axBundle_imageNamed:@"ax_icon_weixin"];
            model.iconImage = [UIImage imageNamed:@"ax_icon_weixin"];
            model.select = YES;
            [temp addObject:model];
        }
        _dataArray = temp.copy;
    }
    return _dataArray;
}

/// 调用者自控制是否点击空白页面 消失
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if ([touches.anyObject.view isEqual:self.view]) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
