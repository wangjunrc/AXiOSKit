//
//  AView.m
//  AXiOSToolsExample
//
//  Created by AXing on 2019/2/15.
//  Copyright © 2019 liu.weixing. All rights reserved.
//

#import "AView.h"
#import "AXiOSTools.h"

@implementation AView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.view1];
        [self addSubview:self.view2];
        [self addSubview:self.view3];
        
        //开启和监听 设备旋转的通知（不开启的话，设备方向一直是UIInterfaceOrientationUnknown）
        if (![UIDevice currentDevice].generatesDeviceOrientationNotifications) {
            [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
        }
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(handleDeviceOrientationChange:)
                                                    name:UIDeviceOrientationDidChangeNotification object:nil];
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    
}

- (UIView *)view1 {
    if (nil == _view1) {
        _view1 = [[UIView alloc]init];
        _view1.backgroundColor = [UIColor redColor];
    }
    return _view1;
}

- (UIView *)view2 {
    if (nil == _view2) {
        _view2 = [[UIView alloc]init];
        _view2.backgroundColor = [UIColor orangeColor];
    }
    return _view2;
}

- (UIView *)view3 {
    if (nil == _view3) {
        _view3 = [[UIView alloc]init];
        _view3.backgroundColor = [UIColor blueColor];
    }
    return _view3;
}

// 两个视图垂直排列
- (void)verticalTwoViews {
    
    [self.view1 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(10);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    
    [self.view2 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view1.mas_bottom).mas_equalTo(10);
        make.left.mas_equalTo(10);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    
    
    [self.view3 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view2.mas_bottom).mas_equalTo(10);
        make.left.mas_equalTo(10);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    
    
}

// 两个视图水平排列
- (void)horizontalTwoViews {
    
    [self.view1 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(10);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    
    [self.view2 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view1.mas_bottom).mas_equalTo(10);
        make.left.mas_equalTo(10);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    
    
    [self.view3 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view2.mas_bottom).mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    
    
}



//设备方向改变的处理
- (void)handleDeviceOrientationChange:(NSNotification *)notification{
    
    
    //这个能取到APP启动时的屏幕方向,不是设备方向,比如,手机竖屏时,APP只支持横屏,这个办法能正确
    //UIDeviceOrientation deviceOrientation = [UIDevice currentDevice].orientation;这个方法不行
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    
    switch (orientation) {
        case UIInterfaceOrientationPortrait:
//            NSLog(@"portrait");
            [self verticalTwoViews];
            break;
        case UIInterfaceOrientationLandscapeLeft:
//            NSLog(@"landscape left");
            [self horizontalTwoViews];
            break;
        case UIInterfaceOrientationLandscapeRight:
//            NSLog(@"landscape right");
            [self horizontalTwoViews];
            break;
        case UIInterfaceOrientationPortraitUpsideDown:
//            NSLog(@"portrait upside down");
            break;
        case UIInterfaceOrientationUnknown:
            break;
        default:
            break;
    }
    
}


//最后在dealloc中移除通知 和结束设备旋转的通知
- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    [[UIDevice currentDevice]endGeneratingDeviceOrientationNotifications];
}
@end
