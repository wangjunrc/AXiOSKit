//
//  ViewController.m
//  AXiOSKitExample
//
//  Created by AXing on 2019/6/19.
//  Copyright © 2019 liu.weixing. All rights reserved.
//

#import "_01ViewController.h"
#import <AXiOSKit/AXiOSKit.h>
#import "AAViewController.h"

#import "FBKVOController.h"
#import "ChatViewController.h"
#import "ChatTextMessageModel.h"

@interface _01ViewController ()


@property(nonatomic, strong) CAEmitterLayer *rainLayer;
@property(nonatomic, strong) CALayer *moveLayer;
@property(nonatomic, strong) NSTimer *timer;

@end

@implementation _01ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    if (@available(iOS 13.0, *)) {
        self.view.backgroundColor = [UIColor ax_colorWithNormalStyle:UIColor.whiteColor darkStyle:UIColor.systemBackgroundColor];
    }
    //    AXLoger(@"模式>> %ld",self.overrideUserInterfaceStyle);
    if (@available(iOS 13.0, *)) {
        AXLoger(@"模式>> %ld", ax_keyWindow().overrideUserInterfaceStyle);
    } else {
        // Fallback on earlier versions
    }


    UILabel *label = [[UILabel alloc] init];
    [self.view addSubview:label];
    label.frame = CGRectMake(100, 300, 100, 50);
    label.backgroundColor = UIColor.blueColor;
    label.text = @"文本";
    label.textColor = [UIColor ax_colorWithNormalStyle:UIColor.greenColor darkStyle:UIColor.systemRedColor];
    label.layer.cornerRadius = 5;
    label.layer.masksToBounds = YES;

    UIImageView *imv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ax_icon_weixin"]];
    [self.view addSubview:imv];
    imv.frame = CGRectMake(100, 300, 100, 100);
    imv.ax_top = label.ax_bottom + 10;

    UIButton *btn = [[UIButton alloc] init];
    [self.view addSubview:btn];
    btn.frame = CGRectMake(0, 0, 100, 50);
    btn.backgroundColor = UIColor.blueColor;
    [btn ax_setTitleStateNormal:@"改变模式"];
    btn.ax_top = imv.ax_bottom + 10;
    btn.ax_left = imv.ax_left;
    [btn ax_addActionBlock:^(UIButton *_Nullable button) {
        if (@available(iOS 13.0, *)) {

            if (ax_keyWindow().overrideUserInterfaceStyle != UIUserInterfaceStyleDark) {
                ax_keyWindow().overrideUserInterfaceStyle = UIUserInterfaceStyleDark;

            } else {
                ax_keyWindow().overrideUserInterfaceStyle = UIUserInterfaceStyleLight;
            }
//            AXLoger(@"模式>> %ld", ax_keyWindow().overrideUserInterfaceStyle);
        }
    }];


    UIButton *btn2 = [[UIButton alloc] init];
    [self.view addSubview:btn2];
    btn2.frame = CGRectMake(0, 0, 100, 50);
    btn2.backgroundColor = UIColor.blueColor;
    [btn2 ax_setTitleStateNormal:@"push"];
    btn2.ax_top = btn.ax_bottom + 10;
    btn2.ax_left = btn.ax_left;
    [btn2 ax_addActionBlock:^(UIButton *_Nullable button) {
        AAViewController *aa = [AAViewController ax_init];
        [self ax_pushVC:aa];

    }];

    UIButton *btn3 = [[UIButton alloc] init];
    [self.view addSubview:btn3];
    btn3.frame = CGRectMake(0, 0, 100, 50);
    btn3.backgroundColor = UIColor.blueColor;
    [btn3 ax_setTitleStateNormal:@"show"];
    btn3.ax_top = btn2.ax_bottom + 10;
    btn3.ax_left = btn2.ax_left;
    [btn3 ax_addActionBlock:^(UIButton *_Nullable button) {
        NSLog(@">>>>>>>>>");
//        AAViewController *aa = [AAViewController ax_init];
//        [self ax_showVC:aa];

        [[NSNotificationCenter defaultCenter] postNotificationName:@"Lookin_2D" object:nil];
//
//                AXNetworkTestViewController *aa = [AXNetworkTestViewController ax_init];
//                [self ax_showVC:aa];


//        ChatViewController *aa = [ChatViewController ax_init];
//        [self ax_showVC:aa];

//
//
//        ChatTextMessageModel *model = [[ChatTextMessageModel alloc]init];
//        model.userid = 100;
//        model.toUserId = 200;
//        model.content = @"aa";
//
//       NSString *str  =[model mj_JSONString];
//          NSLog(@"str>> %@",str);
//       ChatTextMessageModel *model2 =  [ChatTextMessageModel mj_objectWithKeyValues:str];
//
//        NSLog(@"%@",model2.content);

    }];
}


- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {


    [super traitCollectionDidChange:previousTraitCollection];

    if ((self.traitCollection.verticalSizeClass != previousTraitCollection.verticalSizeClass)
            || (self.traitCollection.horizontalSizeClass != previousTraitCollection.horizontalSizeClass)) {
        //         your custom implementation here
        NSLog(@"traitCollectionDidChange");
    }

    //    改变当前模式
    if (@available(iOS 13.0, *)) {
        AXLoger(@"模式>>1 %ld", ax_keyWindow().overrideUserInterfaceStyle);
        AXLoger(@"模式>>2 %ld", self.overrideUserInterfaceStyle);
    } else {
        // Fallback on earlier versions
    }


}

@end
