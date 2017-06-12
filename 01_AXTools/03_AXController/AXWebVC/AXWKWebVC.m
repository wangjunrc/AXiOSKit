//
//  AXWKWebVC.m
//  AXTools
//
//  Created by Mole Developer on 16/10/13.
//  Copyright © 2016年 MoleDeveloper. All rights reserved.
//

#import "AXWKWebVC.h"
@import WebKit;
@interface AXWKWebVC ()<WKNavigationDelegate,WKUIDelegate>

@property (nonatomic, strong) WKWebView *wkWebView;

@property (nonatomic, strong) UIProgressView *progressView;
/**
 * <#注释#>
 */
@property (nonatomic, strong)   CALayer *progresslayer;
@end

@implementation AXWKWebVC
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self setupView];
    [self setupBack];
}


-(void)setupView{
    [self.view addSubview:self.wkWebView];
    
    [self.wkWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsZero);
    }];
    
    
    if (!self.navigationController) {
        self.progressView.frame = CGRectMake(0, 20, axScreenWidth, 2);
        [self.view addSubview:self.progressView];

    }else {
         [self.navigationController.view addSubview:self.progressView];
    }
    
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    
    
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        self.progresslayer.opacity = 1;
        //不要让进度条倒着走...有时候goback会出现这种情况
        if ([change[@"new"] floatValue] < [change[@"old"] floatValue]) {
            return;
        }
        self.progresslayer.frame = CGRectMake(0, 0, self.view.bounds.size.width * [change[@"new"] floatValue], 3);
        if ([change[@"new"] floatValue] == 1) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.progresslayer.opacity = 0;
            });
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.progresslayer.frame = CGRectMake(0, 0, 0, 3);
            });
        }
    }
    else if ([keyPath isEqualToString:@"title"]) {
        
    }
    else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}



- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation { // 类似UIWebView的 -webViewDidStartLoad:
    AXLogFunc;
    
}

- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    AXLogFunc;
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation { // 类似
    
    AXLogFunc;
    
    // 获取 id = 'media' 的'audio'节点，并播放
//    [self.wkWebView evaluateJavaScript: @"var audio=document.getElementById('wx_call'); audio.play();" completionHandler:^(id aa, NSError * _Nullable error) {
//        AXLog(@"----> %@  %@",error,aa);
//    }];
    if (self.title.length==0) {
        
        if (self.wkWebView.title.length>0) {
            self.title = self.wkWebView.title ;
        }else{
             self.title = @"网页";
        }
    }
    
    
}
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    // 类似 UIWebView 的- webView:didFailLoadWithError:
    AXLogFunc;
    [self fun_loadErrorback];

    
}

/**
 * 拦截HTTPStatusCode 
 */
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    
    if (((NSHTTPURLResponse *)navigationResponse.response).statusCode == 200) {
        decisionHandler (WKNavigationResponsePolicyAllow);
    }else {
        [self fun_loadErrorback];
        decisionHandler(WKNavigationResponsePolicyCancel);
    }
}


//服务器开始请求的时候调用
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
    NSURL *URL = navigationAction.request.URL;
    NSString *scheme = [URL scheme];
    
    if ([scheme isEqualToString:@"tel"]) {
        
        /// 防止iOS 10及其之后，拨打电话系统弹出框延迟出现
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [[UIApplication sharedApplication] openURL:URL];
        });
        decisionHandler(WKNavigationActionPolicyCancel);
        return;
    }
     decisionHandler(WKNavigationActionPolicyAllow);
}

//这与用于授权验证的API，与AFN、UIWebView的授权验证API是一样的
- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential *))completionHandler {

}


- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures {
    // 接口的作用是打开新窗口委托
    
    AXLog(@"接口的作用是打开新窗口委托");
    
    if (!navigationAction.targetFrame.isMainFrame) {
        //        [webView loadRequest:navigationAction.request];
        return  [[WKWebView alloc]init];
    }
    return nil;
    
}
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler
{    // js 里面的alert实现，如果不实现，网页的alert函数无效
    AXLog(@"message%@",message);
    
    [self ax_showAlertByTitle:message certain:^{
        completionHandler();
    }];
}


- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler {
    //  js 里面的alert实现，如果不实现，网页的alert函数无效  ,
    AXLog(@"message%@",message);
    
    [self ax_showAlertByTitle:message message:nil certain:^{
         completionHandler(YES);
    } cancel:^{
         completionHandler(NO);
    }];
    
}

- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString *))completionHandler {
    
    completionHandler(@"Client Not handler");
    
}


#pragma mark - set and get

-(WKWebView *)wkWebView{
    if (!_wkWebView) {
        
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
        config.allowsInlineMediaPlayback = YES;
        //播放背景音乐
//    config.mediaPlaybackRequiresUserAction = YES;
        _wkWebView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:config];
        [_wkWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
        _wkWebView.navigationDelegate = self;
        _wkWebView.UIDelegate = self;
        [_wkWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
        [_wkWebView  addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
        _wkWebView.backgroundColor = [UIColor groupTableViewBackgroundColor];

    }
    return _wkWebView;
}

- (UIProgressView *)progressView{
    if (!_progressView) {
        _progressView = [[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleBar];
        _progressView.frame = CGRectMake(0, 62, axScreenWidth, 2);
        
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, 0, 0, 2);
        layer.backgroundColor = [UIColor blueColor].CGColor;
        [_progressView.layer addSublayer:layer];
        self.progresslayer = layer;
    }
    return _progressView;
}


#pragma mark - events
-(void)setupBack{
    
    if (!self.navigationController) {//没有导航
        
        UIButton *button = [self setupBackBtn];
        [self.wkWebView.scrollView addSubview:button];
        
    }else if ([self.navigationController.viewControllers.firstObject isEqual: self]){
        //被present 自带导航
        UIButton *button = [self setupBackBtn];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    }
    
    if (self.navigationController) {
        UIBarButtonItem *roadLoad = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(roadLoadClicked)];
        self.navigationItem.rightBarButtonItem = roadLoad;
    }
}
- (void)roadLoadClicked{
    [self.wkWebView reload];
}

-(UIButton *)setupBackBtn{
    UIButton *button = [[UIButton alloc]init];
    NSString*title = @"取消";
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:20];
    CGSize temp = [title ax_sizeWithaFont:button.titleLabel.font];
    button.frame = CGRectMake(20, 20, temp.width, temp.height);
    [button addTarget:self action:@selector(buttonEvents:) forControlEvents:UIControlEventTouchUpInside];
    
    return button;
    
}


-(void)buttonEvents:(UIButton *)button{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)rightBarButtonItemEvents:(UIBarButtonItem *)item{
    [self.wkWebView reload];
}
-(void)dealloc{
    [self.wkWebView removeObserver:self forKeyPath:@"estimatedProgress"];
    [self.wkWebView removeObserver:self forKeyPath:@"title"];
}

//- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
//    return UIInterfaceOrientationMaskPortrait;
//}
//
//- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
//    return UIInterfaceOrientationPortrait;
//}

//加载失败,返回
-(void)fun_loadErrorback{

    [self ax_showAlertByTitle:@"服务器异常,无法打开" certain:^{
        
        if (self.navigationController) {
            [self.navigationController popViewControllerAnimated:YES];
            
        }else {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }];
}

@end
