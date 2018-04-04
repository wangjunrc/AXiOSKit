//
//  AXWKWebVC.m
//  AXTools
//
//  Created by liuweixing on 16/10/13.
//  Copyright © 2016年 liuweixing. All rights reserved.
//

#import "AXWKWebVC.h"
#import "AXToolsHeader.h"
@import WebKit;
typedef enum{
    loadWebURLString = 0,
    loadWebHTMLString,
    POSTWebURLString,
}wkWebLoadType;
@interface AXWKWebVC ()<WKNavigationDelegate,WKUIDelegate>

@property (nonatomic, strong) WKWebView *wkWebView;

//网页加载的类型
@property(nonatomic,assign) wkWebLoadType loadType;

//保存的网址链接
@property (nonatomic, copy) NSString *URLString;

@property (nonatomic, strong) UIProgressView *progressView;

/**
 * 
 */
@property (nonatomic, strong)UIButton  *cancelButton;

/**
 * 取消item
 */
@property (nonatomic, strong)UIBarButtonItem  *cancelItem;

/**
 * 返回按钮 当打开新web时, 显示
 */
@property (nonatomic)UIBarButtonItem *backItem;

/**
 * 关闭按钮 当打开新web时, 显示
 */
@property (nonatomic)UIBarButtonItem* closeItem;

@end

@implementation AXWKWebVC
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self func_setView];
    [self func_navItme];
    //加载web页面
    [self func_webViewloadURLType];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.progressView setProgress:0.0f animated:NO];
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    [self func_setMas];
}


#pragma mark -  代理 WKNavigationDelegate
/**
 * 开始加载 类似UIWebView的 -webViewDidStartLoad:
 */
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {

    AXLog(@"开始加载 title: %@",webView.title);

}

/**
 * 当内容开始返回时调用
 */
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    AXLog(@"当内容开始返回时调用title: %@",webView.title);
}

/**
 * 页面加载完成之后调用
 */
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation { // 类似

    AXLog(@"页面加载完成之后调用 title: %@",webView.title);
    
    //更新左边itme
    [self func_canGoBackItems];

}

/**
 * 加载失败 类似 UIWebView 的- webView:didFailLoadWithError:
 */
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    AXLog(@"加载失败 %@",error);
//    [self fun_loadErrorback];

}

/**
 * 拦截HTTPStatusCode  决定是否允许或取消一个导航后其反应是已知的
 */
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    
    NSInteger  statusCode = ((NSHTTPURLResponse *)navigationResponse.response).statusCode;
    AXLog(@"拦截HTTPStatusCode %ld",(long)statusCode);
    
    if (statusCode == 200) {
        decisionHandler (WKNavigationResponsePolicyAllow);
    }else {
        [self fun_loadErrorback];
        decisionHandler(WKNavigationResponsePolicyCancel);
    }
}

/**
 * 接收到服务器跳转请求之后调用 主服务器接受到重定向时调用
 */
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{
   
    AXLog(@"接收到服务器跳转请求之后调用 %@",navigation);
}

/**
 * 服务器开始请求的时候调用 是否允许这个导航" 决定是否允许或取消一个导航
 */
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
 
     NSURL *URL = navigationAction.request.URL;
    
    AXLog(@"服务器开始请求的时候调用 %@  %@ %ld",URL.scheme,URL ,(long)navigationAction.navigationType);
    
    if ([URL.scheme  isEqual: @"http"] || [URL.scheme  isEqual: @"https"] ||self.loadType !=loadWebURLString ) {
        
         decisionHandler(WKNavigationActionPolicyAllow);
        return;
        
    }
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [[UIApplication sharedApplication] openURL:URL];
        decisionHandler(WKNavigationActionPolicyCancel);
    });
#pragma clang diagnostic pop
}


/**
 * 这与用于授权验证的API，与AFN、UIWebView的授权验证API是一样的 web视图需要响应身份验证时调用
 */
- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition , NSURLCredential *))completionHandler {
 
     AXLog(@"授权验证的API");
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        if ([challenge previousFailureCount] == 0) {
            NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
            completionHandler(NSURLSessionAuthChallengeUseCredential, credential);
        } else {
            completionHandler(NSURLSessionAuthChallengeCancelAuthenticationChallenge, nil);
        }
    } else {
        completionHandler(NSURLSessionAuthChallengeCancelAuthenticationChallenge, nil);
    }
}

#pragma mark -  代理 WKUIDelegate

/**
 * 接口的作用是打开新窗口委托  创建一个新的webView
 */
- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures {
    
    AXLog(@"接口的作用是打开新窗口委托 %d",navigationAction.targetFrame.isMainFrame);
    
    if (!navigationAction.targetFrame.isMainFrame) {
        [webView loadRequest:navigationAction.request];
    }
    
    return nil;
    
}

/**
 * js 里面的alert实现，只有确定,没有取消,如果不实现，网页的alert函数无效  显示一个JavaScript警告面板
 */
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{

    AXLog(@"runJavaScriptAlertPanelWithMessage %@",message);
    
    [self ax_showAlertByTitle:message certain:^{
        completionHandler();
    }];
}

/**
 *  js 里面的alert实现 含有确定和取消，如果不实现，网页的alert函数无效  ,  显示一个JavaScript确认面板
 */
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler {

    AXLog(@"runJavaScriptConfirmPanelWithMessage %@",message);
    
    [self ax_showAlertByTitle:message message:nil certain:^{
         completionHandler(YES);
    } cancel:^{
         completionHandler(NO);
    }];
    
}

/**
 * js 里面的alert实现 TextField文本输入，如果不实现，网页的alert函数无效, 显示一个JavaScript文本输入面板。
 */
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString *))completionHandler {
    
     AXLog(@"runJavaScriptTextInputPanelWithPrompt %@ %@",prompt,defaultText);
    
    
    [self ax_showAlertTFByTitle:prompt message:defaultText certain:^(NSString *text) {
        
         completionHandler(text);
        
    } cancel:^{
        
    }];
    
}

/**
 * 网页加载内容进程终止
 */
- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView{
    AXLog(@"网页加载内容进程终止");
}

#pragma mark - func
/**
 * view
 */
-(void)func_setView{
    
    [self.view addSubview:self.wkWebView];
    
    [self ax_havNav:^(UINavigationController *nav) {
        [nav.view addSubview:self.progressView];
    } isPresentNav:nil noHave:^{
        [self.view addSubview:self.progressView];
    }];
}

/**
 * 约束
 */
-(void)func_setMas{
    
    [self.wkWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsZero);
    }];
}

/**
 * UINavigationController itme
 */
-(void)func_navItme{
    
    [self ax_havNav:^(UINavigationController *nav) {
        
        UIBarButtonItem *roadLoad = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(roadWeAction)];
        self.navigationItem.rightBarButtonItem = roadLoad;
        
    } isPresentNav:^(UINavigationController *nav) {
        
        self.navigationItem.leftBarButtonItem = self.cancelItem;
        
    } noHave:^{
        
        [self.wkWebView.scrollView addSubview:self.cancelButton];
    }];
    
}


/**
 * 页面加载完成 更新LeftBarButtonItems
 */
-(void)func_canGoBackItems{
    
    if (self.wkWebView.canGoBack) {
        
        UIBarButtonItem *spaceButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        spaceButtonItem.width = -6.5;
        
        [self ax_havNav:^(UINavigationController *nav) {
            
            self.navigationItem.leftBarButtonItems = @[spaceButtonItem,self.backItem,self.closeItem] ;
            
        } isPresentNav:^(UINavigationController *nav) {
            
            self.navigationItem.leftBarButtonItems = @[spaceButtonItem,self.cancelItem,self.closeItem] ;
            
        } noHave:^{
            
        }];
        
    }else{
        
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        
        [self ax_havNav:^(UINavigationController *nav) {
            
            self.navigationItem.leftBarButtonItem = self.navigationItem.backBarButtonItem;
            
        } isPresentNav:^(UINavigationController *nav) {
            
            self.navigationItem.leftBarButtonItem = self.cancelItem;
            
        } noHave:^{
            
        }];
        
    }
}

- (void)func_webViewloadURLType{
    switch (self.loadType) {
        case loadWebURLString:{
            //创建一个NSURLRequest 的对象
            NSURLRequest * Request_zsj = [NSURLRequest requestWithURL:[NSURL URLWithString:self.URLString] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
            //加载网页
            [self.wkWebView loadRequest:Request_zsj];
            break;
        }
        case loadWebHTMLString:{
            [self func_loadHostPathURL:self.URLString];
            break;
        }
        case POSTWebURLString:{
            // JS发送POST的Flag，为真的时候会调用JS的POST方法
            
            //POST使用预先加载本地JS方法的html实现，请确认WKJSPOST存在
            [self func_loadHostPathURL:@"WKJSPOST"];
            break;
        }
    }
}


- (void)func_loadHostPathURL:(NSString *)url{
    //获取JS所在的路径
    NSString *path = [[NSBundle mainBundle] pathForResource:url ofType:@"html"];
    //获得html内容
    NSString *html = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    //加载js
    if (html.length==0) {
        html = [NSString stringWithFormat:@"<font size=\"30\">%@</font>",url];
    }
    
    [self.wkWebView loadHTMLString:html baseURL:[[NSBundle mainBundle] bundleURL]];
}


#pragma mark - action

/**
 * 取消item 事件
 */
-(void)backItemAction:(UIBarButtonItem *)item{
    if (self.wkWebView.canGoBack) {
        [self.wkWebView goBack];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

/**
 * 关闭item 事件
 */
-(void)closeItemAction:(UIBarButtonItem *)item{
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 * 重新加载
 */
- (void)roadWeAction{
    [self.wkWebView reload];
}


-(void)cancelButtonAction:(UIButton *)button{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)rightBarButtonItemEvents:(UIBarButtonItem *)item{
    [self.wkWebView reload];
}

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


#pragma mark - kvo
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    
    
    if (object == self.wkWebView ) {
        
        if ([keyPath isEqualToString:@"estimatedProgress"]) {
            
            [self.progressView setAlpha:1.0f];
            BOOL animated = self.wkWebView.estimatedProgress > self.progressView.progress;
            [self.progressView setProgress:self.wkWebView.estimatedProgress animated:animated];
            
            if(self.wkWebView.estimatedProgress >= 1.0f) {
                [UIView animateWithDuration:0.3f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
                    [self.progressView setAlpha:0.0f];
                } completion:^(BOOL finished) {
                    [self.progressView setProgress:0.0f animated:NO];
                }];
            }
        }else if ([keyPath isEqualToString:@"title"]){
        //使用KVO 显示title 更快一点
            
            NSString *title = change[@"new"];
            if (self.title.length==0) {
                if (title.length>0) {
                    self.title = title;
                }else{
                    self.title = AXMyLocalizedString(@"网页");
                }
            }
        }
        
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}


#pragma mark - set and get
-(void)setWebURLSring:(NSString *)webURLSring{
    
    _webURLSring = webURLSring;
    
    self.URLString = webURLSring;
    self.loadType = loadWebURLString;
}


- (void)setWebHTMLSring:(NSString *)webHTMLSring{
    _webHTMLSring = webHTMLSring;
    
    self.URLString = webHTMLSring;
    self.loadType = loadWebHTMLString;
}


-(WKWebView *)wkWebView{
    if (!_wkWebView) {
        
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
        config.allowsInlineMediaPlayback = YES;
        //播放背景音乐
//            config.mediaPlaybackRequiresUserAction = YES;
//        config.mediaTypesRequiringUserActionForPlayback = WKAudiovisualMediaTypeAudio;
        
        _wkWebView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:config];
//        [_wkWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.webURLSring]]];
        _wkWebView.navigationDelegate = self;
        _wkWebView.UIDelegate = self;
        [_wkWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
         [_wkWebView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
        
        _wkWebView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
    }
    return _wkWebView;
}


- (UIProgressView *)progressView{
    if (!_progressView) {
        _progressView = [[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleDefault];
    
        __block CGRect tempFrame = CGRectZero;
        [self ax_havNav:^(UINavigationController *nav) {
           tempFrame = CGRectMake(0, 64, self.view.bounds.size.width, 3);
        } isPresentNav:nil noHave:^{
            tempFrame = CGRectMake(0, 20, self.view.bounds.size.width, 3);
        }];
        
        _progressView.frame = tempFrame;
        
        // 设置进度条的色彩
        [_progressView setTrackTintColor:[UIColor colorWithRed:240.0/255 green:240.0/255 blue:240.0/255 alpha:1.0]];
        _progressView.progressTintColor = [UIColor greenColor];
    }
    return _progressView;
}

-(UIBarButtonItem*)backItem{
    if (!_backItem) {
        UIImage* backItemImage = [[UIImage imageNamed:@"backItemImage"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        UIImage* backItemHlImage = [[UIImage imageNamed:@"backItemImage-hl"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        
        UIButton* backButton = [[UIButton alloc] init];
        [backButton setTitle:AXMyLocalizedString(@"ax.back") forState:UIControlStateNormal];
        [backButton setTitleColor:self.navigationController.navigationBar.tintColor forState:UIControlStateNormal];
        [backButton setTitleColor:[self.navigationController.navigationBar.tintColor colorWithAlphaComponent:0.5] forState:UIControlStateHighlighted];
        [backButton.titleLabel setFont:[UIFont systemFontOfSize:17]];
        [backButton setImage:backItemImage forState:UIControlStateNormal];
        [backButton setImage:backItemHlImage forState:UIControlStateHighlighted];
        [backButton sizeToFit];
        
        [backButton addTarget:self action:@selector(backItemAction:) forControlEvents:UIControlEventTouchUpInside];
        _backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        
    }
    return _backItem;
}

- (UIButton *)cancelButton{
    if (!_cancelButton) {
        _cancelButton = [[UIButton alloc]init];
        NSString*title = AXMyLocalizedString(@"ax.cancel");
        [_cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_cancelButton setTitle:title forState:UIControlStateNormal];
        [_cancelButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        _cancelButton.titleLabel.font = [UIFont systemFontOfSize:20];
        CGSize temp = [title ax_sizeWithaFont:_cancelButton.titleLabel.font];
        _cancelButton.frame = CGRectMake(20, 20, temp.width, temp.height);
        [_cancelButton addTarget:self action:@selector(cancelButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}

-(UIBarButtonItem*)closeItem{
    if (!_closeItem) {
        _closeItem = [[UIBarButtonItem alloc] initWithTitle:AXMyLocalizedString(@"ax.close") style:UIBarButtonItemStylePlain target:self action:@selector(closeItemAction:)];
    }
    return _closeItem;
}

-(UIBarButtonItem *)cancelItem{
    if (!_cancelItem) {
        _cancelItem = [[UIBarButtonItem alloc]initWithCustomView:self.cancelButton];
    }
    return _cancelItem;
}


#pragma mark - dealloc
-(void)dealloc{
    axLong_dealloc;
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




#pragma mark - 文档
/*

typedef NS_ENUM(NSInteger, WKNavigationType) { 
    WKNavigationTypeLinkActivated,//链接的href属性被用户激活。
    WKNavigationTypeFormSubmitted,//一个表单提交。
    WKNavigationTypeBackForward,//回到前面的条目列表请求。
    WKNavigationTypeReload,//网页加载。
    WKNavigationTypeFormResubmitted,//一个表单提交(例如通过前进,后退,或重新加载)。
    WKNavigationTypeOther = -1,//导航是发生一些其他原因。 } NS_ENUM_AVAILABLE(10_10, 8_0);
    
  
 typedef NS_ENUM(NSInteger, WKUserScriptInjectionTime) { 
    WKUserScriptInjectionTimeAtDocumentStart,//注入后的脚本创建文档元素,但在其他任何内容已经被加载。 
    WKUserScriptInjectionTimeAtDocumentEnd//注入脚本文档完成加载后,但在任何子资源可能完成加载。 } NS_ENUM_AVAILABLE(10_10, 8_0);
 
 typedef NS_ENUM(NSInteger, WKNavigationActionPolicy) {
    WKNavigationActionPolicyCancel,//取消导航
    WKNavigationActionPolicyAllow,//允许导航继续 } NS_ENUM_AVAILABLE(10_10, 8_0);
 
 
 
 
 */

@end
