//
//  ViewController.m
//  AXiOSKitExample
//
//  Created by AXing on 2019/6/19.
//  Copyright © 2019 liu.weixing. All rights reserved.
//

#import "_01ThemeViewController.h"
#import <AXiOSKit/AXiOSKit.h>
#import "_01ContentViewController.h"
#import "FBKVOController.h"
#import "_02ChatViewController.h"
#import "ChatTextMessageModel.h"

@interface _01ThemeViewController ()

@property(nonatomic,strong) UILabel *label;
@property(nonatomic, strong) CAEmitterLayer *rainLayer;
@property(nonatomic, strong) CALayer *moveLayer;
@property(nonatomic, strong) NSTimer *timer;

@end

@implementation _01ThemeViewController
- (void)injected {
    NSLog(@"重启了 InjectionIII: %@", self);
    [self viewDidLoad];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.containerView.backgroundColor = [UIColor ax_colorWithNormalStyle:UIColor.whiteColor];
    
    self.AXListener.isPushed(^{
        NSLog(@"isPushed");
    }).isPresented(^{
        NSLog(@"isPresented");
    });
    if (@available(iOS 13.0, *)) {
        AXLoger(@"模式>> %ld", ax_keyWindow().overrideUserInterfaceStyle);
    }
    [self _initView];
}

-(void)_initView {
    
    CGFloat all_height = 50;
    __weak typeof(self) weakSelf = self;
    [self _p00ButtonTitle:@"改变模式" handler:^{
        if (@available(iOS 13.0, *)) {
            ax_keyWindow().overrideUserInterfaceStyle = (ax_keyWindow().overrideUserInterfaceStyle != UIUserInterfaceStyleDark )? UIUserInterfaceStyleDark : UIUserInterfaceStyleLight;
        }
    }];
    
    {
        
        UILabel *label = [[UILabel alloc] init];
        [self.containerView addSubview:label];
        label.backgroundColor = UIColor.blueColor;
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.bottomAttribute).mas_equalTo(20);
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
        }];
        self.bottomAttribute = label.mas_bottom;
        if (@available(iOS 13.0, *)) {
            NSString *text = @"暂无";
            switch (ax_keyWindow().overrideUserInterfaceStyle) {
                case UIUserInterfaceStyleUnspecified:
                    text = @"模式 Unspecified";
                    break;
                case UIUserInterfaceStyleLight:
                    text = @"模式 Light";
                    break;
                case UIUserInterfaceStyleDark:
                    text = @"模式 Dark";
                    break;
                default:
                    break;
            }
            label.text =text;
        }else{
            label.text =@"不支持模式";
        }
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor ax_colorWithNormalStyle:UIColor.greenColor darkStyle:UIColor.systemRedColor];
        label.layer.cornerRadius = 5;
        label.layer.masksToBounds = YES;
        self.label = label;
    }
    
    {
        
        UIImageView *imv = [[UIImageView alloc] init];
        imv.image =[UIImage imageNamed:@"ax_icon_weixin"];
        [self.containerView addSubview:imv];
        [imv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.bottomAttribute).mas_equalTo(20);
            make.width.height.mas_equalTo(all_height);
            make.centerX.mas_equalTo(0);
        }];
        self.bottomAttribute = imv.mas_bottom;
    }
    
    
    [self _p00ButtonTitle:@"push" handler:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        _01ThemeViewController *aa = [_01ThemeViewController ax_init];
        [strongSelf ax_pushVC:aa];
    }];
    
    
    [self _p00ButtonTitle:@"show" handler:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        _01ThemeViewController *vc = [_01ThemeViewController ax_init];
        [strongSelf ax_showVC:vc];
    }];
    
    [self _p00ButtonTitle:@"Lookin_2D" handler:^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"Lookin_2D" object:nil];
    }];
    
    [self _p00ButtonTitle:@"dismis 或者 pop" handler:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf ax_haveNav:^(UINavigationController *nav) {
            [strongSelf.navigationController popViewControllerAnimated:YES];
            
        } isPushNav:^(UINavigationController *nav) {
            [strongSelf.navigationController dismissViewControllerAnimated:YES completion:nil];
        } isPresentNav:^(UINavigationController *nav) {
            [strongSelf dismissViewControllerAnimated:YES completion:nil];
        } noneNav:^{
            [strongSelf dismissViewControllerAnimated:YES completion:nil];
        }];
    }];
    
    [self _p00ButtonTitle:@"popToRoot" handler:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf.navigationController popToRootViewControllerAnimated:YES];
        
    }];
    
    self.bottomAttribute = self.view.mas_bottom;
    [self _loadBottomAttribute];
}


- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    
    
    [super traitCollectionDidChange:previousTraitCollection];
    
    if ((self.traitCollection.verticalSizeClass != previousTraitCollection.verticalSizeClass)
        || (self.traitCollection.horizontalSizeClass != previousTraitCollection.horizontalSizeClass)) {
        
        NSLog(@"traitCollectionDidChange");
    }
    
    //    改变当前模式
    if (@available(iOS 13.0, *)) {
        AXLoger(@"模式>>1 %ld", ax_keyWindow().overrideUserInterfaceStyle);
        AXLoger(@"模式>>2 %ld", self.overrideUserInterfaceStyle);
        
        NSString *text = @"暂无";
        switch (ax_keyWindow().overrideUserInterfaceStyle) {
            case UIUserInterfaceStyleUnspecified:
                text = @"模式 Unspecified";
                break;
            case UIUserInterfaceStyleLight:
                text = @"模式 Light";
                break;
            case UIUserInterfaceStyleDark:
                text = @"模式 Dark";
                break;
            default:
                break;
        }
        self.label.text =text;
    }
    
    
}
- (void)dealloc{
    axLong_dealloc;
}
@end
