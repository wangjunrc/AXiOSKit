//
//  _17OtherShareViewController.m
//  AXiOSKitExample
//
//  Created by 小星星吃KFC on 2020/8/24.
//  Copyright © 2020 liuweixing. All rights reserved.
//

#import "_17OtherShareViewController.h"
#import "WXApi.h"
@interface _17OtherShareViewController ()

@end

@implementation _17OtherShareViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(50, 50, 150, 38)];
    [btn1 setTitle:@"微信分享" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(50, 100, 150, 38)];
    [btn2 setTitle:@"微信登录" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(authAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
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
    
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText = YES;
    req.text = @"分享的内容";
    req.scene = WXSceneSession;
//      [WXApi sendReq:req completion:^(BOOL success) {
//            NSLog(@"唤起微信:%@", success ? @"成功" : @"失败");
//        }];
    [WXApi sendReq:req];
}

- (void)authAction:(id)sender{
    
    SendAuthReq *req = [[SendAuthReq alloc] init];
    req.state = @"wx_oauth_authorization_state";//用于保持请求和回调的状态，授权请求或原样带回
    req.scope = @"snsapi_userinfo";//授权作用域：获取用户个人信息
    
    //发送请求
//    [WXApi sendReq:req completion:^(BOOL success) {
//        NSLog(@"唤起微信:%@", success ? @"成功" : @"失败");
//    }];
    [WXApi sendReq:req];
}
@end
