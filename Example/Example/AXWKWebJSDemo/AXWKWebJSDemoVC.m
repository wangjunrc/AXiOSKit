//
//  AXWKWebJSDemoVC.m
//  AXiOSTools
//
//  Created by liuweixing on 16/10/13.
//  Copyright © 2016年 liuweixing. All rights reserved.
//

#import "AXWKWebJSDemoVC.h"
@import WebKit;
#if __has_include("WKWebViewJavascriptBridge.h")
#import "WKWebViewJavascriptBridge.h"
#endif

typedef NS_ENUM(NSInteger, wkWebLoadType){
    loadWebURLString = 0,
    loadWebHTMLString,
    POSTWebURLString,
};

@interface AXWKWebJSDemoVC ()<WKScriptMessageHandler, WKNavigationDelegate, WKUIDelegate,UINavigationControllerDelegate,UIScrollViewDelegate>


@property (nonatomic, copy) NSString *url;
/**
 加载纯外部链接网页
 */
@property (nonatomic, copy) NSString *loadURLString;

/**
 * 加载本地网页 不需要带.html 后缀
 */
@property (nonatomic, copy) NSString *loadHTMLString;

@property (nonatomic, strong) WKWebView *webView;

//网页加载的类型
@property (nonatomic, assign) wkWebLoadType loadType;

#if __has_include("WKWebViewJavascriptBridge.h")
@property (nonatomic, strong)WKWebViewJavascriptBridge *bridge;
#endif


@end

@implementation AXWKWebJSDemoVC
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self init_setView];
    self.loadHTMLString = @"AXWKWebJSDemoPage.html";
    [self func_loadHostPathURL:self.url];
}


/**
 * view
 */
- (void)init_setView{
    
    self.webView.frame = self.view.bounds;
    [self.view addSubview:self.webView];
    
    [self init_WebViewJavascriptBridge];
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height-400, self.view.bounds.size.width, 400)];
    [self.view addSubview:bgView];
    bgView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    UITextField *tf = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, bgView.bounds.size.width, 50)];
    tf.placeholder = @"输入文字";
    [bgView addSubview:tf];
    tf.backgroundColor = [UIColor orangeColor];
    tf.tag = 100;
    
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 60, bgView.bounds.size.width, 50)];
    [bgView addSubview:btn];
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:@"oc按钮_js注入" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn2 = [[UIButton alloc]initWithFrame:CGRectMake(0, 120, bgView.bounds.size.width, 50)];
    [bgView addSubview:btn2];
    btn2.backgroundColor = [UIColor redColor];
    [btn2 setTitle:@"oc按钮_原生" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(btnAction2) forControlEvents:UIControlEventTouchUpInside];
}


/**
 WebViewJavascriptBridge js 交互
 */
- (void)init_WebViewJavascriptBridge{
    
#if __has_include("WKWebViewJavascriptBridge.h")
    // 开启日志，方便调试
    [WKWebViewJavascriptBridge enableLogging];
    // 给哪个webview建立JS与OjbC的沟通桥梁
    self.bridge = [WKWebViewJavascriptBridge bridgeForWebView:self.webView];
    // 设置代理，如果不需要实现，可以不设置
    // 如果控制器里需要监听WKWebView 的`navigationDelegate`方法，就需要添加下面这行。
    [self.bridge setWebViewDelegate:self];
    
    //js调oc
    [self.bridge registerHandler:@"jsToOC_bridgeMethod" handler:^(id data, WVJBResponseCallback responseCallback) {
        
        //data  js 传来的参数
        
        UITextField *tf = [self.view viewWithTag:100];
        tf.text = data;
        //        if (responseCallback) {
        //            // 反馈给JS ,js 不需要反馈 就不需要写
        //            responseCallback(@{@"userId": @"OC返回给js"});
        //        }
    }];
#endif
}


-(void)btnAction{
    
#if __has_include("WKWebViewJavascriptBridge.h")
    UITextField *tf = [self.view viewWithTag:100];
    [self.bridge callHandler:@"payCallBack"data: tf.text responseCallback:^(id responseData) {
        
        NSLog(@"from js: %@", responseData);
    }];
#endif
}

-(void)btnAction2 {
    
    UITextField *tf = [self.view viewWithTag:100];
    
    NSString *jsStr = [NSString stringWithFormat:@"ocToJS_wkMethod('%@')",tf.text];
    
    [self.webView evaluateJavaScript:jsStr completionHandler:^(id _Nullable data, NSError * _Nullable error) {
        NSLog(@"evaluateJavaScript>> %@  %@",data,error.localizedDescription);
    }];
}

// js注入方法
//WKScriptMessageHandler
//依然是这个协议方法,获取注入方法名对象,获取js返回的状态值.
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    
    NSLog(@"didReceiveScriptMessage");
    
    if ([message.name isEqualToString:@"JSUseOCFunctionName_test1"]) {
        NSLog(@"JS传来的json字符串>>%@", message.body);
        
        UITextField *tf = [self.view viewWithTag:100];
        tf.text = message.body;
        
        // 告诉js.,oc收到了
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            NSString *jsStr = [NSString stringWithFormat:@"JSUserOCCallback('oc收到了%@')",tf.text];
            [self.webView evaluateJavaScript:jsStr completionHandler:^(id _Nullable data, NSError * _Nullable error) {
                NSLog(@"evaluateJavaScript>> %@  %@",data,error.localizedDescription);
            }];
        });
    }else if ([message.name isEqualToString:@"JSReceiveOCMessage"]){
        
    }
}



- (void)func_loadHostPathURL:(NSString *)url{
    
    //获取JS所在的路径
    NSString *path = nil;
    //获得html内容
    NSString *html =nil;
    
    
    NSString *type = url.pathExtension;
    
    if ([type isEqualToString:@"html"]) {
        
        path = [[NSBundle mainBundle] pathForResource:url ofType:nil];
        html = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        
    }else if (type.length == 0){
        
        path = [[NSBundle mainBundle] pathForResource:url ofType:@"html"];
        html = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    }else{
        html = [NSString stringWithFormat:@"<font size=\"30\">'%@'路径错误</font>",url];;
    }
    
    //加载js
    if (html.length==0) {
        html = [NSString stringWithFormat:@"<font size=\"30\">%@</font>",url];
    }
    
    [self.webView loadHTMLString:html baseURL:[[NSBundle mainBundle] bundleURL]];
    
}


#pragma mark - set and get

- (void)setLoadURLString:(NSString *)loadURLString {
    _loadURLString = loadURLString;
    self.url = loadURLString;
    self.loadType = loadWebURLString;
}


- (void)setLoadHTMLString:(NSString *)loadHTMLString {
    _loadHTMLString = loadHTMLString;
    self.url = loadHTMLString;
    self.loadType = loadWebHTMLString;
}


- (WKWebView *)webView{
    if (!_webView) {
        
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
        config.allowsInlineMediaPlayback = YES;
        //播放背景音乐
        //            config.mediaPlaybackRequiresUserAction = YES;
        //        config.mediaTypesRequiringUserActionForPlayback = WKAudiovisualMediaTypeAudio;
        
        WKUserContentController *userContentController = [[WKUserContentController alloc] init];;
        // js调用oc方法注入方法名
        [userContentController addScriptMessageHandler:self name:@"JSUseOCFunctionName_test1"];
        [userContentController addScriptMessageHandler:self name:@"JSReceiveOCMessage"];
        
        config.userContentController = userContentController;
        
        _webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:config];
        //        [_wkWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.webURLSring]]];
        _webView.navigationDelegate = self;
        _webView.UIDelegate = self;
        _webView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
    }
    return _webView;
}



@end

