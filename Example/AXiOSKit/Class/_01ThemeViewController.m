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
    
    self.view.backgroundColor = [UIColor ax_colorWithNormalStyle:UIColor.whiteColor];
    
//
//    NSLog(@"isPresented == %d",self.navigationController && [self.navigationController.viewControllers.firstObject isEqual:self]);
//
    
//    !self.navigationController &&
//    ![self.navigationController.viewControllers.firstObject isEqual:strongSelf.viewController]
    ;
    
//    self.presentationController; _UIPageSheetPresentationController pr
    /// _UIFullscreenPresentationController
   
//   BOOL is2= [self.presentationController isKindOfClass:NSClassFromString(@"_UIPageSheetPresentationController")];
//    NSLog(@"self.presentationController = %@ is2 %d",self.presentationController,is2);
    
     self.AXListener.isPushed(^{
         NSLog(@"isPushed");
     }).isPresented(^{
         NSLog(@"isPresented");
     });
//
    if (@available(iOS 13.0, *)) {
        AXLoger(@"模式>> %ld", ax_keyWindow().overrideUserInterfaceStyle);
    }
    
    [self _initView];
}

-(void)_initView {
    UIView *topView = self.view;
    CGFloat all_width = 150;
    CGFloat all_height = 50;
    
    {
        UIButton *btn = [[UIButton alloc] init];
        [self.view addSubview:btn];
        btn.frame = CGRectMake(0, 0, all_width, all_height);
        btn.backgroundColor = UIColor.blueColor;
        [btn ax_setTitleStateNormal:@"改变模式"];
        btn.ax_top = topView.top + ax_status_bar_height();
        btn.ax_left = topView.ax_left+50;
        
        [btn ax_addTargetBlock:^(UIButton *_Nullable button) {
            
            if (@available(iOS 13.0, *)) {
                ax_keyWindow().overrideUserInterfaceStyle = (ax_keyWindow().overrideUserInterfaceStyle != UIUserInterfaceStyleDark )? UIUserInterfaceStyleDark : UIUserInterfaceStyleLight;
            }
        }];
        
        topView =btn;
    }
    
    {
        
        UILabel *label = [[UILabel alloc] init];
        [self.view addSubview:label];
        label.frame = CGRectMake(0,0, all_width, all_height);
        label.backgroundColor = UIColor.blueColor;
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
        
        label.ax_top = topView.ax_bottom + 10;
        label.ax_left = topView.ax_left;
        self.label = label;
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
        [btn ax_setTitleStateNormal:@"push"];
        btn.ax_top = topView.ax_bottom + 10;
        btn.ax_left = topView.ax_left;
        __weak typeof(self) weakSelf = self;;
        [btn ax_addTargetBlock:^(UIButton *_Nullable button) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            _01ThemeViewController *aa = [_01ThemeViewController ax_init];
            [strongSelf ax_pushVC:aa];
            
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
        __weak typeof(self) weakSelf = self;
        [btn ax_addTargetBlock:^(UIButton *_Nullable button) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            _01ThemeViewController *aa = [_01ThemeViewController ax_init];
            [strongSelf ax_showVC:aa];
        }];
        topView =btn;
    }
    {
        UIButton *btn = [[UIButton alloc] init];
        [self.view addSubview:btn];
        btn.frame = CGRectMake(0, 0, all_width, all_height);
        btn.backgroundColor = UIColor.blueColor;
        [btn ax_setTitleStateNormal:@"Lookin_2D"];
        btn.ax_top = topView.ax_bottom + 10;
        btn.ax_left = topView.ax_left;
        [btn ax_addTargetBlock:^(UIButton *_Nullable button) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"Lookin_2D" object:nil];
            
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
