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
    self.navigationBar.barStyle = UIBarStyleDefault;//状态栏颜色
    self.navigationBar.translucent = NO;//半透明--- view坐标为0,0, NO view坐标为0,64
    [self.navigationBar setShadowImage:[UIImage new]];//取消导航白线
}
//- (UIStatusBarStyle)preferredStatusBarStyle{//没有导航栏的vc重写此方法,改变状态栏颜色
//    return UIStatusBarStyleDefault;
//}

-(void)dealloc{
    
    axLong_Dealloc;
}
-(BOOL)shouldAutorotate{
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return UIInterfaceOrientationPortrait;
}
@end
