//
//  AXNaviC.m
//  AXTools
//
//  Created by Mole Developer on 16/6/12.
//  Copyright © 2016年 MoleDeveloper. All rights reserved.
//

#import "AXNaviC.h"

@interface AXNaviC ()

@end

@implementation AXNaviC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    NSDictionary *dic = @{ NSForegroundColorAttributeName :[UIColor whiteColor] };
    self.navigationBar.titleTextAttributes = dic;
    
    
    self.navigationBar.barStyle = UIBarStyleDefault;//状态栏颜色
//    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"topbg.png"] forBarMetrics:UIBarMetricsDefault];//背景图片
//    self.navigationBar.barTintColor = [UIColor whiteColor];
     self.navigationBar.barTintColor = [UIColor ax_colorFrom16RGB:0x1DB56C];//背景色
    self.navigationBar.translucent = NO;//半透明--- view坐标为0,0, NO view坐标为0,64
    [self.navigationBar setShadowImage:[UIImage new]];//取消导航白线
    self.navigationBar.tintColor=[UIColor whiteColor];// UINavigationBar itme 图片文字渲染颜色
    
}
//- (UIStatusBarStyle)preferredStatusBarStyle{//没有导航栏的vc重写此方法,改变状态栏颜色
//    return UIStatusBarStyleDefault;
//}

-(void)dealloc{
    
    H_Long_Dealloc;
}
-(BOOL)shouldAutorotate{
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}
@end
