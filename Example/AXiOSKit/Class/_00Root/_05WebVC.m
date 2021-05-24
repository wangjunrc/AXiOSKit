//
//  _05WebVC.m
//  AXiOSKit_Example
//
//  Created by 小星星吃KFC on 2021/5/24.
//  Copyright © 2021 axinger. All rights reserved.
//

#import "_05WebVC.h"
#import "AXDemoURLProtocol.h"
#import "DemoWevViewImageSchemeHandler.h"
#import "NSURLProtocol+AXDemo.h"

@interface _05WebVC ()

@property(nonatomic, strong) DemoWevViewImageSchemeHandler *imageSchemeHandler;

@end

@implementation _05WebVC

//                vc.URL = [NSURL
//                URLWithString:@"https://www.baidu.com/"]; vc.URL =
//                [NSURL URLWithString:@"错误地址"];
//                    vc.URL = [NSBundle.mainBundle
//                    URLForResource:@"H5.bundle/index.html"
//                    withExtension:nil];
//                vc.HTML = @"<p style='font-size: 20px'>测试</p>";
//                ///第三方 framework 内部的 ,看第三方 NSBundle
//                是怎么放置的
//                    vc.URL = [NSBundle.mainBundle
//                    URLForResource:@"Frameworks/AXiOSKit.framework/AXHTML.bundle/index.html"
//                    withExtension:nil];
//                /// AXiOSKit 放置方式不一样
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"wkWebView";
    
    @weakify(self)
    [self _buttonTitle:@"网页 - AXWKWebVC" handler:^(UIButton * _Nonnull btn) {
        @strongify(self)
        UIImage *img =[UIImage imageNamed:@"ax_icon_weixin"];
        NSString *base64=[UIImagePNGRepresentation(img) base64EncodedStringWithOptions:0];
        NSLog(@"base64 = %@",base64);
        
        NSURL *URL = [NSBundle.ax_HTMLBundle URLForResource:@"index.html" withExtension:nil];
        
        AXWKWebVC * vc = [[AXWKWebVC alloc] initWithURL:URL];
        @weakify(vc)
        [vc addScriptMessageWithName:@"base64Img" handler:^(NSString * _Nonnull name, id _Nonnull body) {
            @strongify(vc)
            NSLog(@"body = %@",body);
            NSString *content = body;
            UIImageView *imgView = [UIImageView.alloc initWithFrame:CGRectMake(100, 100, 50, 50)];
            content = [content componentsSeparatedByString:@","].lastObject;
            NSData *data = [NSData.alloc initWithBase64EncodedString:content options:0];
            imgView.image = [UIImage.alloc initWithData:data];
            [vc.view addSubview:imgView];
        }];
        [vc.rac_willDeallocSignal subscribeNext:^(id _Nullable x) {
            NSLog(@"rac_willDeallocSignal>> AXWKWebVC");
        }];
        [self ax_pushVC:vc];
        
    }];
    
    
    [self _buttonTitle:@"AXWKWebVC 拦截PNG图片,不拦截jpeg图片" handler:^(UIButton * _Nonnull btn) {
        @strongify(self)
        NSURL *URL = [NSBundle.mainBundle URLForResource:@"H5.bundle/index.html" withExtension:nil];
        AXWKWebVC * vc = [[AXWKWebVC alloc] initWithURL:URL];
        vc.title = @"拦截PNG图片,不拦截jpeg图片";
        vc.userHTMLTitle = NO;
        [[vc rac_signalForSelector:@selector(viewDidLoad)]subscribeNext:^(RACTuple * _Nullable x) {
            [NSURLProtocol registerClass:AXDemoURLProtocol.class];
            [NSURLProtocol wk_registerScheme:@"http"];
            [NSURLProtocol wk_registerScheme:@"https"];

        }];
        [vc.rac_willDeallocSignal subscribeNext:^(id _Nullable x) {

            [NSURLProtocol wk_unregisterScheme:@"http"];
            [NSURLProtocol wk_unregisterScheme:@"https"];
            [NSURLProtocol unregisterClass:AXDemoURLProtocol.class];
        }];
        
        [self ax_pushVC:vc];
    }];
    
    
    [self _buttonTitle:@"AXWKWebVC 拦截图片 iOS 11.0" handler:^(UIButton * _Nonnull btn) {
        @strongify(self)
        AXWKWebVC * vc = [[AXWKWebVC alloc] initWithURL:[NSURL URLWithString:@"https://www.baidu.com"]];
        if (@available(iOS 11.0, *)) {
            [vc.webView.configuration setURLSchemeHandler:self.imageSchemeHandler forURLScheme:@"www.baidu.com"];
        } else {
            // Fallback on earlier versions
        }
        [self ax_pushVC:vc];
    }];
    
    [self _buttonTitle:@"AXWKWebVC load orgTitle" handler:^(UIButton * _Nonnull btn) {
        @strongify(self)
        NSURL *URL = [NSURL URLWithString:@"https://www.baidu.com/"];
        
        AXWKWebVC * vc = [[AXWKWebVC alloc] initWithURL:URL];
        NSError *error=nil;
        NSString *js = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"orgTitle.js"ofType:nil] encoding:NSUTF8StringEncoding error:&error];
        if (!error) {
            [vc evaluateJavaScript:js time:WKUserScriptInjectionTimeAtDocumentStart];
        }
        [self ax_pushVC:vc];
    }];
    
    [self _buttonTitle:@"AXWKWebVC load js" handler:^(UIButton * _Nonnull btn) {
        @strongify(self)
        NSURL *URL = [NSBundle.ax_HTMLBundle URLForResource:@"index.html" withExtension:nil];
        AXWKWebVC * vc = [[AXWKWebVC alloc] initWithURL:URL];
        NSError *error=nil;
        NSString *js = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"myAlert.js"ofType:nil] encoding:NSUTF8StringEncoding error:&error];
        if (!error) {
            [vc evaluateJavaScript:js time:WKUserScriptInjectionTimeAtDocumentStart];
        }
        [self ax_pushVC:vc];
    }];
    
    
    
    /// 底部约束
    [self _lastLoadBottomAttribute];
}



- (DemoWevViewImageSchemeHandler *)imageSchemeHandler {
    if (!_imageSchemeHandler) {
        _imageSchemeHandler = [DemoWevViewImageSchemeHandler.alloc init];
    }
    return _imageSchemeHandler;
}

-(void)dealloc {
    axLong_dealloc;
}
@end
