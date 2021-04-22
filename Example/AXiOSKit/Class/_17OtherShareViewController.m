//
//  _17OtherShareViewController.m
//  AXiOSKitExample
//
//  Created by 小星星吃KFC on 2020/8/24.
//  Copyright © 2020 liuweixing. All rights reserved.
//

#import "_17OtherShareViewController.h"
//#import <WechatOpenSDK/WXApi.h>
@interface _17OtherShareViewController ()

@end

@implementation _17OtherShareViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
//    __weak typeof(self) weakSelf = self;
//    [self _buttonTitle:@"微信分享" handler:^(UIButton * _Nonnull btn) {
//        __strong typeof(weakSelf) strongSelf = weakSelf;
//        [strongSelf shareAction:btn];
//    }];
//    [self _buttonTitle:@"微信登录" handler:^(UIButton * _Nonnull btn) {
//        __strong typeof(weakSelf) strongSelf = weakSelf;
//        [strongSelf authAction:btn];
//    }];
    
    UILabel *lb = [[UILabel alloc]init];
    lb.text = @"闪动加载";
    lb.backgroundColor = UIColor.orangeColor;
    lb.textColor = [UIColor lightGrayColor];
    lb.font = [UIFont boldSystemFontOfSize:40];
    [self.containerView addSubview:lb];
    [lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomAttribute).mas_offset(10);
        make.centerX.mas_equalTo(0);
        make.width.mas_equalTo(170);
        make.height.mas_equalTo(70);
    }];
    self.bottomAttribute = lb.mas_bottom;
    [lb layoutIfNeeded];
    
    NSLog(@"lb.frame = %@",NSStringFromCGRect(lb.frame));
    
    [self _lastLoadBottomAttribute];
    
    [self.containerView layoutIfNeeded];
    CAGradientLayer *colorLayer = [CAGradientLayer layer];
    colorLayer.frame = CGRectMake(-85,-35, 170, 170);
//    colorLayer.frame = lb.frame;
//    colorLayer.position = self.view.center;
    [lb.superview.layer addSublayer:colorLayer];
    NSLog(@"colorLayer.frame = %@",NSStringFromCGRect(colorLayer.frame));
    colorLayer.colors = @[(__bridge id)[UIColor lightGrayColor].CGColor,
                          (__bridge id)[UIColor grayColor].CGColor,
                          (__bridge id)[UIColor lightGrayColor].CGColor];
    colorLayer.locations = @[@(- 0.2),@(- 0.1),@(0)];
    colorLayer.startPoint = CGPointMake(0, 0.6);
    colorLayer.endPoint = CGPointMake(1, 0.4);
    colorLayer.mask = lb.layer;

    if (@available(iOS 10.0, *)) {
        [NSTimer scheduledTimerWithTimeInterval:1.5 repeats:YES block:^(NSTimer * _Nonnull timer) {
            CABasicAnimation *fadeA = [CABasicAnimation animationWithKeyPath:@"locations"];
            fadeA.fromValue = @[@(-0.2), @(-0.1),@(0)] ;
            fadeA.toValue = @[@(1.0),@(1.1),@(1.2)] ;
            fadeA.duration = 2 ;
            [colorLayer addAnimation:fadeA forKey:nil ];
        }];
    } else {
        // Fallback on earlier versions
    }
    
}

- (void)shareAction:(id)sender{
    
//    SendMessageToWXReq *sendReq = [[SendMessageToWXReq alloc] init];
//    sendReq.bText = NO;//不使用文本信息
//    sendReq.scene = 1;//0.好友列表 1.朋友圈 2.收藏
//
//    //创建分享内容对象
//    WXMediaMessage *urlMessage = [WXMediaMessage message];
//    urlMessage.title = @"标题";//标题
//    urlMessage.description = @"描述内容";//描述内容
////    [urlMessage setThumbImage:[UIImage imageNamed:@"exporte"]];//设置图片
//
//    //创建多媒体对象
//    WXWebpageObject *webObj = [WXWebpageObject object];
//    webObj.webpageUrl = @"https://www.baidu.com/";//URL链接
//
//    //完成发送对象实例
//    urlMessage.mediaObject = webObj;
//    sendReq.message = urlMessage;
//
//    //发送请求
//    [WXApi sendReq:sendReq completion:^(BOOL success) {
//        NSLog(@"唤起微信:%@", success ? @"成功" : @"失败");
//    }];
//
    
//    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
//    req.bText = YES;
//    req.text = @"分享的内容";
//    req.scene = WXSceneSession;
////      [WXApi sendReq:req completion:^(BOOL success) {
////            NSLog(@"唤起微信:%@", success ? @"成功" : @"失败");
////        }];
//    [WXApi sendReq:req];
}

//- (void)authAction:(id)sender{
//
//    SendAuthReq *req = [[SendAuthReq alloc] init];
//    req.state = @"wx_oauth_authorization_state";//用于保持请求和回调的状态，授权请求或原样带回
//    req.scope = @"snsapi_userinfo";//授权作用域：获取用户个人信息
//
//    //发送请求
////    [WXApi sendReq:req completion:^(BOOL success) {
////        NSLog(@"唤起微信:%@", success ? @"成功" : @"失败");
////    }];
//    [WXApi sendReq:req];
//}
@end
