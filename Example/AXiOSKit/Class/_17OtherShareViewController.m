//
//  _17OtherShareViewController.m
//  AXiOSKitExample
//
//  Created by 小星星吃KFC on 2020/8/24.
//  Copyright © 2020 liuweixing. All rights reserved.
//

#import "_17OtherShareViewController.h"
#if __has_include(<WechatOpenSDK/WXApi.h>)
#import <WechatOpenSDK/WXApi.h>
#endif
//调用swift, 不可见文件
#import "AXiOSKit_Example-Swift.h"

@interface _17OtherShareViewController ()

@end

@implementation _17OtherShareViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    __weak typeof(self) weakSelf = self;
    [self _titlelabel:@"效果一样的,都可以分享,但含有'未验证'字样"];
    [self _buttonTitle:@"微信分享,官方SDK" handler:^(UIButton * _Nonnull btn) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf shareAction:btn];
    }];
    
    [self _buttonTitle:@"微信分享,MonkeyKing" handler:^(UIButton * _Nonnull btn) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf _shareActionMonkeyKing:btn];
    }];
    
//    [self _buttonTitle:@"微信登录" handler:^(UIButton * _Nonnull btn) {
//        __strong typeof(weakSelf) strongSelf = weakSelf;
//        [strongSelf authAction:btn];
//    }];
    
    [self _lastLoadBottomAttribute];
}


- (void)shareAction:(UIButton *)sender{
    #if __has_include(<WechatOpenSDK/WXApi.h>)
    SendMessageToWXReq *sendReq = [[SendMessageToWXReq alloc] init];
    sendReq.bText = NO;//不使用文本信息
    sendReq.scene = 1;//0.好友列表 1.朋友圈 2.收藏

    //创建分享内容对象
    WXMediaMessage *urlMessage = [WXMediaMessage message];
    urlMessage.title = @"标题";//标题
    urlMessage.description = @"描述内容";//描述内容
//    [urlMessage setThumbImage:[UIImage imageNamed:@"exporte"]];//设置图片

    //创建多媒体对象
    WXWebpageObject *webObj = [WXWebpageObject object];
    webObj.webpageUrl = @"https://www.baidu.com/";//URL链接

    //完成发送对象实例
    urlMessage.mediaObject = webObj;
    sendReq.message = urlMessage;

    //发送请求
//    [WXApi sendReq:sendReq completion:^(BOOL success) {
//        NSLog(@"唤起微信:%@", success ? @"成功" : @"失败");
//    }];


    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText = YES;
    req.text = @"分享的内容";
    req.scene = WXSceneSession;
//      [WXApi sendReq:req completion:^(BOOL success) {
//            NSLog(@"唤起微信:%@", success ? @"成功" : @"失败");
//        }];
    [WXApi sendReq:req];
#endif
}

- (void)_shareActionMonkeyKing:(UIButton *)sender{
    
    [MonkeyKingUtil weChatMessageSession];
    
}

- (void)authAction:(id)sender{
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
}
@end
