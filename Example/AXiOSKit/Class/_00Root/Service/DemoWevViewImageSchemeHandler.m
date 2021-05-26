//
//  DemoWevViewImageSchemeHandler.m
//  AXiOSKit_Example
//
//  Created by 小星星吃KFC on 2021/5/21.
//  Copyright © 2021 axinger. All rights reserved.
//

#import "DemoWevViewImageSchemeHandler.h"

@implementation DemoWevViewImageSchemeHandler

//通知开始准备加载相应的网络任务
- (void)webView:(WKWebView *)webView startURLSchemeTask:(id <WKURLSchemeTask>)urlSchemeTask API_AVAILABLE(ios(11.0)){
    NSURLRequest *request = urlSchemeTask.request;
    //可以通过url拦截响应的方法
    if ([request.URL.absoluteString.pathExtension isEqualToString:@"png"]
        || [request.URL.absoluteString.pathExtension isEqualToString:@"gif"]) {
        //一个任务完成需要返回didReceiveResponse和didReceiveData两个方法
        //最后在执行didFinish，不可重复调用，可能会导致崩溃
        [urlSchemeTask didReceiveResponse:[NSURLResponse new]];
        NSData *data = UIImagePNGRepresentation( [UIImage imageNamed:@"西瓜"]);
        [urlSchemeTask didReceiveData:data];
        [urlSchemeTask didFinish];
        return;
    }
    NSURLSessionDataTask *task = [[NSURLSession sharedSession]
        dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //也可以通过解析data等数据，通过data等数据来确定是否拦截
        //一个任务完成需要返回didReceiveResponse和didReceiveData两个方法
        //最后在执行didFinish，不可重复调用，可能会导致崩溃
        if (!data) {
            [urlSchemeTask didReceiveResponse:[NSURLResponse new]];
            [urlSchemeTask didReceiveData:[NSData dataWithContentsOfFile:
                [[NSBundle mainBundle] pathForResource:@"test1" ofType:@"jpeg"]]];
        } else {
            [urlSchemeTask didReceiveResponse:response];
            [urlSchemeTask didReceiveData:data];

        }
        [urlSchemeTask didFinish];
    }];
    [task resume];
}


- (void)webView:(nonnull WKWebView *)webView stopURLSchemeTask:(nonnull id<WKURLSchemeTask>)urlSchemeTask  API_AVAILABLE(ios(11.0)){
    
}



@end
