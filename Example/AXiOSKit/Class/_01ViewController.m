//
//  ViewController.m
//  AXiOSKitExample
//
//  Created by AXing on 2019/6/19.
//  Copyright © 2019 liu.weixing. All rights reserved.
//

#import "_01ViewController.h"
#import <AXiOSKit/AXiOSKit.h>

#import "FBKVOController.h"
#import "_02ChatViewController.h"
#import "ChatTextMessageModel.h"

@interface _01ViewController ()


@property(nonatomic, strong) CAEmitterLayer *rainLayer;
@property(nonatomic, strong) CALayer *moveLayer;
@property(nonatomic, strong) NSTimer *timer;

@end

@implementation _01ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor ax_colorWithNormalStyle:UIColor.whiteColor];
    //    AXLoger(@"模式>> %ld",self.overrideUserInterfaceStyle);
    if (@available(iOS 13.0, *)) {
        AXLoger(@"模式>> %ld", ax_keyWindow().overrideUserInterfaceStyle);
    } else {
        // Fallback on earlier versions
    }
    
    UIView *topView = self.view;
    CGFloat all_width = 150;
    CGFloat all_height = 50;
    {
        
        UILabel *label = [[UILabel alloc] init];
        [self.view addSubview:label];
        label.frame = CGRectMake(0,0, all_width, all_height);
        label.backgroundColor = UIColor.blueColor;
        label.text = @"文本";
        label.textColor = [UIColor ax_colorWithNormalStyle:UIColor.greenColor darkStyle:UIColor.systemRedColor];
        label.layer.cornerRadius = 5;
        label.layer.masksToBounds = YES;
        
        label.ax_top = topView.top + ax_status_bar_height();
        label.ax_left = topView.ax_left+20;
        topView =label;
    }
    {
        
        UIImageView *imv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ax_icon_weixin"]];
        [self.view addSubview:imv];
        imv.frame = CGRectMake(0,0, all_height, all_height);
        imv.ax_top = topView.ax_bottom + 10;
        imv.ax_left = topView.ax_left;
        topView =imv;
        
    }
    
    {
        UIButton *btn = [[UIButton alloc] init];
        [self.view addSubview:btn];
        btn.frame = CGRectMake(0, 0, all_width, all_height);
        btn.backgroundColor = UIColor.blueColor;
        [btn ax_setTitleStateNormal:@"改变模式"];
        btn.ax_top = topView.ax_bottom + 10;
        btn.ax_left = topView.ax_left;
        
        [btn ax_addTargetBlock:^(UIButton *_Nullable button) {
            
            if (@available(iOS 13.0, *)) {
                
                if (ax_keyWindow().overrideUserInterfaceStyle != UIUserInterfaceStyleDark) {
                    ax_keyWindow().overrideUserInterfaceStyle = UIUserInterfaceStyleDark;
                    
                } else {
                    ax_keyWindow().overrideUserInterfaceStyle = UIUserInterfaceStyleLight;
                }
            }
        }];
        
        topView =btn;
    }
    
    {
        UIButton *btn = [[UIButton alloc] init];
        [self.view addSubview:btn];
        btn.frame = CGRectMake(0, 0, all_width, all_height);
        btn.backgroundColor = UIColor.blueColor;
        [btn ax_setTitleStateNormal:@"push"];
        btn.ax_top = topView.ax_bottom + 10;
        btn.ax_left = topView.ax_left;
        __weak typeof(self) weakSelf = self;;
        [btn ax_addTargetBlock:^(UIButton *_Nullable button) {
           __strong typeof(weakSelf) self = weakSelf;
            _01ViewController *aa = [_01ViewController ax_init];
            [self ax_pushVC:aa];
            
        }];
        topView =btn;
    }
    
    {
        UIButton *btn = [[UIButton alloc] init];
        [self.view addSubview:btn];
        btn.frame = CGRectMake(0, 0, all_width, all_height);
        btn.backgroundColor = UIColor.blueColor;
        [btn ax_setTitleStateNormal:@"show"];
        btn.ax_top = topView.ax_bottom + 10;
        btn.ax_left = topView.ax_left;
        [btn ax_addTargetBlock:^(UIButton *_Nullable button) {
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
            //        model.userid = all_width;
            //        model.toUserId = 200;
            //        model.content = @"aa";
            //
            //       NSString *str  =[model mj_JSONString];
            //          NSLog(@"str>> %@",str);
            //       ChatTextMessageModel *model2 =  [ChatTextMessageModel mj_objectWithKeyValues:str];
            //
            //        NSLog(@"%@",model2.content);
            
        }];
        topView =btn;
    }
    {
        UIButton *btn = [[UIButton alloc] init];
        [self.view addSubview:btn];
        btn.frame = CGRectMake(0, 0, all_width, all_height);
        btn.backgroundColor = UIColor.blueColor;
        [btn ax_setTitleStateNormal:@"dismis 或者 pop "];
        btn.ax_top = topView.ax_bottom + 10;
        btn.ax_left = topView.ax_left;
       __weak typeof(self) weakSelf = self;
        [btn ax_addTargetBlock:^(UIButton *_Nullable button) {
           __strong typeof(weakSelf) self = weakSelf;
            [self ax_haveNav:^(UINavigationController *nav) {
                [self.navigationController popViewControllerAnimated:YES];
                
            } isPushNav:^(UINavigationController *nav) {
                [self.navigationController dismissViewControllerAnimated:YES completion:nil];
            } isPresentNav:^(UINavigationController *nav) {
                [self dismissViewControllerAnimated:YES completion:nil];
            } noneNav:^{
                [self dismissViewControllerAnimated:YES completion:nil];
            }];
        }];
        topView =btn;
    }
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
