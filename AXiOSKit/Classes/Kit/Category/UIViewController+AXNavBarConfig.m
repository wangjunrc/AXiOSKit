//
//  UIViewController+AXNavBarConfig.m
//  AXiOSKitDemo
//
//  Created by liuweixing 2018/6/21.
//  Copyright © 2018年 liuweixing. All rights reserved.
//

#import "UIViewController+AXNavBarConfig.h"
#import "AXiOSKit.h"

@implementation UIViewController (AXNavBarConfig)


/**
 设置 navigationBar 颜色 文字颜色
 
 @param aColor navigationBar 颜色
 @param textColor 文字颜色
 */
-(void)ax_setNavigationBarColor:(UIColor *)aColor textColor:(UIColor *)textColor{
    
    [self ax_setNavigationBarTextColor:textColor];
    
    if ([self isKindOfClass:UINavigationController.class]) {
       UINavigationController *nav = (UINavigationController *)self;
        [nav.navigationBar setBackgroundImage:[UIImage ax_imageSquareWithColor:aColor] forBarMetrics:UIBarMetricsDefault];
        
    }else if ([self isKindOfClass:UIViewController.class]){
        [self.navigationController.navigationBar setBackgroundImage:[UIImage ax_imageSquareWithColor:aColor] forBarMetrics:UIBarMetricsDefault];
    }
    
}


/**
 设置 navigationBar 透明
 */
-(void)ax_setNavBarBackgroundImageTransparent{
    
    if ([self isKindOfClass:UINavigationController.class]) {
        
        UINavigationController *nav = (UINavigationController *)self;
        nav.navigationBar.translucent = YES;
        [nav.navigationBar setBackgroundImage:[[UIImage alloc]init] forBarMetrics:UIBarMetricsDefault];
        nav.navigationBar.shadowImage = [[UIImage alloc]init];
        
    }else if ([self isKindOfClass:UIViewController.class]){
        
        self.navigationController.navigationBar.translucent = YES;
        [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc]init] forBarMetrics:UIBarMetricsDefault];
        self.navigationController.navigationBar.shadowImage = [[UIImage alloc]init];
    }
}

-(void)ax_setNavBarBackgroundImageWithColor:(UIColor *)aColor {
    
    UIImage *bgImage = [UIImage ax_imageSquareWithColor:aColor];
    
    if ([self isKindOfClass:UINavigationController.class]) {
        
        UINavigationController *nav = (UINavigationController *)self;
//        nav.navigationBar.translucent = YES;
        [nav.navigationBar setBackgroundImage:bgImage forBarMetrics:UIBarMetricsDefault];
        
    }else if ([self isKindOfClass:UIViewController.class]){
        
//        self.navigationController.navigationBar.translucent = YES;
        [self.navigationController.navigationBar setBackgroundImage:bgImage forBarMetrics:UIBarMetricsDefault];
        
    }
}

/**
 取消分隔线
 */
-(void)ax_setSeparatorHidden{
    
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc]init];
}




/**
 item title 文字白色,
 */
-(void)ax_setNavigationTextWhite{
    
    [self ax_setNavigationBarTextColor:[UIColor whiteColor]];
}


/**
 navigationBar 文字颜色
 
 @param textColor 颜色
 */
-(void)ax_setNavigationBarTextColor:(UIColor *)textColor{
    
    NSDictionary *dic = @{NSForegroundColorAttributeName:textColor};
    self.navigationController.navigationBar.titleTextAttributes = dic;
    self.navigationController.navigationBar.tintColor = textColor;
}


@end
