//
//  AXWKWebVC.m
//  AXiOSKit
//
//  Created by liuweixing on 16/10/13.
//  Copyright © 2016年 liuweixing. All rights reserved.
//

#import "AXWKWebVC.h"

#import "AXiOSKit.h"
#import "NSBundle+AXBundle.h"
#import "AXScriptMessageHandlerHelper.h"
#import <Masonry/Masonry.h>
#import "AXWebScriptMessageModel.h"
#import "NSString+AXKit.h"
#import "AXImageSchemeHanlder.h"
#import <ReactiveObjC/ReactiveObjC.h>
typedef NS_ENUM(NSInteger, WKWebLoadType){
    WKWebLoadTypeHTML,
    WKWebLoadTypeURL,
};

@interface AXWKWebVC ()<WKScriptMessageHandler, WKNavigationDelegate, WKUIDelegate,UINavigationControllerDelegate,UIScrollViewDelegate>

@property (nonatomic, strong,readwrite) WKWebView *webView;

@property (nonatomic, copy,readwrite) NSURL *URL;

@property (nonatomic, copy,readwrite) NSString *HTML;

//@property (nonatomic, copy) NSString *url;

@property (nonatomic, strong) UIProgressView *progressView;

/**
 网页加载的类型
 */
@property (nonatomic, assign) WKWebLoadType loadType;

/**
 *
 */
@property (nonatomic, strong) UIButton *cancelButton;

/**
 * 取消item
 */
@property (nonatomic, strong) UIBarButtonItem *cancelItem;

/**
 * 返回按钮 当打开新web时, 显示
 */
@property (nonatomic) UIBarButtonItem *backItem;

/**
 * 关闭按钮 当打开新web时, 显示
 */
@property (nonatomic, strong) UIBarButtonItem* closeItem;

/**
 *解决self.webView.configuration.userContentController强引用
 */
@property (nonatomic, strong) AXScriptMessageHandlerHelper *handlerHelper;

/**
 *多个js交互,根据name保存,回调
 */
@property (nonatomic, copy) NSMutableDictionary <NSString *,AXScriptErrorBlock >* scriptMessageDict;

@property (nonatomic, copy) NSMutableDictionary <NSString *,AXWebScriptMessageModel *>* scriptMessageModelDict;


@end

@implementation AXWKWebVC

#pragma mark - set
//- (void)setURL:(NSURL *)URL {
//    _URL = URL;
//    self.loadType = WKWebLoadTypeURL;
//}
//- (void)setHTML:(NSString *)HTML {
//    _HTML = HTML;
//    self.loadType = WKWebLoadTypeHTML;
//}
- (instancetype)init{
    self = [super init];
    if (self) {
        self.userHTMLTitle = YES;
    }
    return self;
}

-(instancetype )initWithURL:(NSURL *)URL {
    if (self = [self init]) {
        self.URL = URL;
        self.loadType = WKWebLoadTypeURL;
    }
    return self;
}

-(instancetype )initWithHTML:(NSString *)HTML {
    if (self = [self init]) {
        self.HTML = HTML;
        self.loadType = WKWebLoadTypeHTML;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self _initView];
    [self _intiKVO];
    [self _initNavItme];
    [self _webViewloadURLType];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.progressView setProgress:0.0f animated:NO];
}


#pragma mark -  init
/**
 * view
 */
- (void)_initView{
    self.webView.navigationDelegate = self;
    self.webView.UIDelegate = self;
    [self.view addSubview:self.webView];
    [self.view addSubview:self.progressView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsZero);
    }];
}


#pragma mark - NavItme
- (void)_initNavItme{
    __weak typeof(self) weakSelf = self;
    [self ax_haveNav:^(UINavigationController *nav) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        UIBarButtonItem *roadLoad = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(roadDataWebAction)];
        strongSelf.navigationItem.rightBarButtonItem = roadLoad;
        
    } isPushNav:^(UINavigationController *nav) {
        
    } isPresentNav:^(UINavigationController *nav) {
        
    } noneNav:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf.webView.scrollView addSubview:strongSelf.cancelButton];
    }];
}

#pragma mark - KVO
-(void)_intiKVO{
    
    __weak typeof(self) weakSelf = self;
    if (self.isUserHTMLTitle) {
        [RACObserve(self.webView, title) subscribeNext:^(NSString *title) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            AXLoger(@"title = %@",title);
            //使用KVO 显示title 更快一点
            if (title.length>0) {
                strongSelf.title = title;
            }
        }];
    }
    
    [RACObserve(self.webView, estimatedProgress) subscribeNext:^(NSNumber *progress) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        AXLoger(@"progress = %@",progress);
        strongSelf.progressView.alpha = 1.0f;
        BOOL animated = strongSelf.webView.estimatedProgress > strongSelf.progressView.progress;
        [strongSelf.progressView setProgress:strongSelf.webView.estimatedProgress animated:animated];
        if(strongSelf.webView.estimatedProgress >= 1.0f) {
            [UIView animateWithDuration:0.3f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
                strongSelf.progressView.alpha = 0.0f;
            } completion:^(BOOL finished) {
                [strongSelf.progressView setProgress:0.0f animated:NO];
            }];
        }
    }];
    
}

#pragma mark -  代理 WKNavigationDelegate
/**
 * 开始加载 类似UIWebView的 -webViewDidStartLoad:
 */
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    
    //    AXLog(@"开始加载 title: %@",webView.title);
}

/**
 * 当内容开始返回时调用
 */
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    //    AXLog(@"当内容开始返回时调用title: %@",webView.title);
}

/**
 * 页面加载完成之后调用
 */
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation { // 类似
    
    AXLog(@"页面加载完成之后调用 webView.title: %@",webView.title);
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
///先：针对一次action来决定是否允许跳转，action中可以获取request，
///允许与否都需要调用decisionHandler，比如decisionHandler(WKNavigationActionPolicyCancel);
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
    NSURL *URL = navigationAction.request.URL;
    
    AXLog(@"服务器开始请求的时候调用\n scheme:%@\n URL:%@\n navigationType:%ld",URL.scheme,URL ,(long)navigationAction.navigationType);
    
    if ([URL.scheme isEqual:@"tel"]) {
        ax_OpenURL(URL);
        decisionHandler(WKNavigationActionPolicyCancel);
        return;
    }
    
    if ([URL.scheme isEqual:@"sms"]) {
        //短信的处理
        ax_OpenURL(URL);
        decisionHandler(WKNavigationActionPolicyCancel);
        return;
    }
    
    if ([URL.scheme isEqual:@"mailto"]) {
        //邮件的处理
        ax_OpenURL(URL);
        decisionHandler(WKNavigationActionPolicyCancel);
        return;
    }
    
    if ([URL.absoluteString containsString:@"ituns.apple.com"]) {
        //打开appstore
        ax_OpenURL(URL);
        decisionHandler(WKNavigationActionPolicyCancel);
        return;
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}


/**
 * 这与用于授权验证的API，与AFN、UIWebView的授权验证API是一样的 web视图需要响应身份验证时调用
 */
///后：根据response来决定，是否允许跳转，允许与否都需要调用decisionHandler，
///如decisionHandler(WKNavigationResponsePolicyAllow);
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
    
    [self ax_showAlertByTitle:message confirm:^{
        completionHandler();
    }];
}

/**
 *  js 里面的alert实现 含有确定和取消，如果不实现，网页的alert函数无效  ,  显示一个JavaScript确认面板
 */
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler {
    
    AXLog(@"runJavaScriptConfirmPanelWithMessage %@",message);
    
    [self ax_showAlertByTitle:message message:nil confirm:^{
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
    
    [self ax_showAlertTFByTitle:prompt message:defaultText confirm:^(NSString *text) {
        
        completionHandler(text);
        
    } cancel:nil];
}

/**
 * 网页加载内容进程终止
 */
/// 当WKWebView加载的网页占用内存过大时，会出现白屏现象。
- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView{
    AXLog(@"网页加载内容进程终止");
    [webView reload];   //刷新就好了
}

// js注入方法
//WKScriptMessageHandler
//依然是这个协议方法,获取注入方法名对象,获取js返回的状态值.
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    
    AXScriptErrorBlock handler = self.scriptMessageDict[message.name];
    if (handler) {
        handler(message.name,message.body);
        return;
    }
    
    AXWebScriptMessageModel *model = self.scriptMessageModelDict[message.name];
    if (model) {
        id<AXScriptMessageDelegate> delegate = model.obj;
        if (delegate && [delegate respondsToSelector:@selector(webVC:messageName:messageBody:)]) {
            [delegate webVC:self messageName:message.name messageBody:message.body];
        }
        return;
    }
}

/**
 js 回调oc
 
 @param name oc方法名
 @param handler 回调
 */
-(void)addScriptMessageWithName:(NSString *)name
                        handler:(void(^)(NSString* name, id body) )handler {
    
    if (self.scriptMessageDict[name] !=nil || self.scriptMessageModelDict[name] !=nil) {
        AXLog(@"addScriptMessageHandler重复注册");
        return;
    }
    if (handler) {
        //通过window.webkit.messageHandlers.<name>.postMessage(<messageBody>) 来实现js->oc传递消息
        self.scriptMessageDict[name] = handler;
        [self.webView.configuration.userContentController addScriptMessageHandler:self.handlerHelper name:name];
    }
}

- (void)addScriptDelegate:(id<AXScriptMessageDelegate>)delegate
                   forKey:(NSString *)name {
    
    if (self.scriptMessageDict[name] !=nil || self.scriptMessageModelDict[name] !=nil) {
        AXLog(@"addScriptMessageHandler重复注册");
        return;
    }
    
    if (delegate && name.length>0 ){
        
        AXWebScriptMessageModel *model = [[AXWebScriptMessageModel alloc]init];
        model.obj = delegate;
        
        self.scriptMessageModelDict[name] = model;
        
        [self.webView.configuration.userContentController addScriptMessageHandler:self.handlerHelper name:name];
    }
}

/**
 oc 调用js方法
 
 @param javaScriptString js方法名
 @param handler 回调
 */
- (void)evaluateJavaScript:(NSString *)javaScriptString
                   handler:(void(^)(id data, NSError* error))handler {
    
    [self.webView evaluateJavaScript:javaScriptString completionHandler:handler];
}

- (void)evaluateJavaScript:(NSString *)js
                      time:(WKUserScriptInjectionTime )time {
    WKUserScript *jsUserScript = [WKUserScript.alloc initWithSource:js
                                                      injectionTime:time
                                                   forMainFrameOnly:NO];
    [self.webView.configuration.userContentController addUserScript:jsUserScript];
}

//#pragma mark - KVO
//
//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
//
//    if (object != self.webView ) {
//
//        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
//    }else{
//
//        if ([keyPath isEqualToString:NSStringFromSelector(@selector(estimatedProgress))]) {
//            self.progressView.alpha = 1.0f;
//            BOOL animated = self.webView.estimatedProgress > self.progressView.progress;
//            [self.progressView setProgress:self.webView.estimatedProgress animated:animated];
//
//            if(self.webView.estimatedProgress >= 1.0f) {
//
//                [UIView animateWithDuration:0.3f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
//                    self.progressView.alpha = 0.0f;
//                } completion:^(BOOL finished) {
//                    [self.progressView setProgress:0.0f animated:NO];
//
//                }];
//            }
//        }else if ([keyPath isEqualToString:NSStringFromSelector(@selector(title))]){
//            //使用KVO 显示title 更快一点
//            if (self.title.length==0) {
//
//                NSString *title = change[@"new"];
//                if (title.length>0) {
//                    self.title = title;
//                }else{
//                    self.title = AXKitLocalizedString(@"网页");
//                }
//            }
//        }else {
//            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
//        }
//
//    }
//}


#pragma mark - func

-(void)loadWebView {
    [self _webViewloadURLType];
}

- (void)_webViewloadURLType{
    
    switch (self.loadType) {
        case WKWebLoadTypeHTML:{
            [self.webView loadHTMLString:self.HTML baseURL:[NSBundle.mainBundle bundleURL]];
            break;
        }
            
        case WKWebLoadTypeURL:{
            if (self.URL == nil) {
                NSString *HTML = @"<p style='font-size: 50px'>路径错误</p>";
                [self.webView loadHTMLString:HTML baseURL:[NSBundle.mainBundle bundleURL]];
                break;
            }
            NSURLRequest *request = [NSURLRequest requestWithURL:self.URL];
            [self.webView loadRequest:request];
            break;
        }
    }
}


/**
 * 页面加载完成 更新LeftBarButtonItems
 */
- (void)func_canGoBackItems{
    
    if (self.webView.canGoBack) {
        
        UIBarButtonItem *spaceButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        spaceButtonItem.width = 20;
        __weak typeof(self) weakSelf = self;
        [self ax_haveNav:nil isPushNav:^(UINavigationController *nav) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            strongSelf.navigationItem.leftBarButtonItems = @[strongSelf.backItem,spaceButtonItem,strongSelf.closeItem];
            
        } isPresentNav:^(UINavigationController *nav) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            strongSelf.navigationItem.leftBarButtonItems = @[strongSelf.cancelItem,spaceButtonItem,strongSelf.closeItem];
            
        } noneNav:nil];
        
        // 这行代码可以是侧滑返回webView的上一级，而不是根控制器（*只针对侧滑有效）
        self.webView.allowsBackForwardNavigationGestures = YES;
    }else{
        
        // 这行代码可以是侧滑返回webView的上一级，而不是根控制器（*只针对侧滑有效）
        self.webView.allowsBackForwardNavigationGestures = YES;
        
        self.navigationItem.leftBarButtonItems = nil;
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        __weak typeof(self) weakSelf = self;
        [self ax_haveNav:nil isPushNav:^(UINavigationController *nav) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            //            self.navigationItem.leftBarButtonItem = self.navigationItem.backBarButtonItem;
            
            
            strongSelf.navigationItem.leftBarButtonItem = strongSelf.backItem;
        } isPresentNav:^(UINavigationController *nav) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            strongSelf.navigationItem.leftBarButtonItem = strongSelf.cancelItem;
        } noneNav:nil];
    }
}

#pragma mark - action

/**
 * 取消item 事件
 */
- (void)backItemAction:(UIBarButtonItem *)item{
    if (self.webView.canGoBack) {
        [self.webView goBack];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

/**
 * 关闭item 事件
 */
- (void)closeItemAction:(UIBarButtonItem *)item{
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 * 重新加载
 */
- (void)roadDataWebAction{
    [self.webView reload];
}

- (void)cancelButtonAction:(UIButton *)button{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)rightBarButtonItemEvents:(UIBarButtonItem *)item{
    [self.webView reload];
}


- (void)updateHeight {
    [self nowUpdateHeight];
    [self delayUpdateHeight];
}

- (void)nowUpdateHeight {
    
    __weak typeof(self) weakSelf = self;
    [self.webView evaluateJavaScript:@"document.body.offsetHeight" completionHandler:^(id _Nullable result,NSError * _Nullable error) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        // 高度会有一点少 ，手动补上 20
        CGFloat height = [result floatValue] + 20.0;
        strongSelf.webView.height = height;
        if (strongSelf.loadOverHeight) {
            strongSelf.loadOverHeight(height);
        }
    }];
}

- (void)delayUpdateHeight {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, DelayTime * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [self nowUpdateHeight];
    });
}


//加载失败,返回
- (void)fun_loadErrorback{
    __weak typeof(self) weakSelf = self;
    [self ax_showAlertByTitle:@"服务器异常,无法打开" confirm:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf.navigationController) {
            [strongSelf.navigationController popViewControllerAnimated:YES];
        }else {
            [strongSelf dismissViewControllerAnimated:YES completion:nil];
        }
    }];
}

#pragma mark - get

- (WKWebView *)webView{
    if (!_webView) {
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
        config.allowsInlineMediaPlayback = YES;
        //播放背景音乐
        //            config.mediaPlaybackRequiresUserAction = YES;
        //        config.mediaTypesRequiringUserActionForPlayback = WKAudiovisualMediaTypeAudio;
        
        
        //        AXImageSchemeHanlder *imageScheme = AXImageSchemeHanlder.alloc.init;
        //        imageScheme.oriImageScheme = self.oriImageScheme;
        //        imageScheme.oriImageUrl = self.oriImageUrl;
        //        imageScheme.placeholderImage = self.placeholderImage;
        //
        //        __weak typeof(self) weakSelf = self;
        //        imageScheme.updateImageBlock = ^ {
        //            [weakSelf updateHeight];
        //        };
        //        [config setURLSchemeHandler:imageScheme forURLScheme:XXXCustomImageScheme];
        
        
        WKUserContentController *userContentController = [[WKUserContentController alloc] init];
        config.userContentController = userContentController;
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, 100, 100) configuration:config];
        _webView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        //        [_webView addObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress)) options:NSKeyValueObservingOptionNew context:nil];
        //        [_webView addObserver:self forKeyPath:NSStringFromSelector(@selector(title)) options:NSKeyValueObservingOptionNew context:nil];
        
        _webView.allowsBackForwardNavigationGestures = YES; //允许右滑返回上个链接，左滑前进
        _webView.allowsLinkPreview = YES; //允许链接3D Touch
        _webView.customUserAgent = @"customUserAgent/1.0.0"; //自定义UA，UIWebView就没有此功能，
        
    }
    return _webView;
}


- (UIProgressView *)progressView{
    if (!_progressView) {
        _progressView = [[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleDefault];
        
        __block CGRect tempFrame = CGRectZero;
        __weak typeof(self) weakSelf = self;
        [self ax_haveNav:^(UINavigationController *nav) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            tempFrame = CGRectMake(0,0, strongSelf.view.bounds.size.width, 3);
            
        } isPushNav:nil isPresentNav:nil noneNav:^{
            __strong typeof(weakSelf) strongSelf = weakSelf;
            tempFrame = CGRectMake(0, 0, strongSelf.view.bounds.size.width, 3);
        }];
        _progressView.frame = tempFrame;
        // 设置进度条的色彩
        _progressView.trackTintColor = [UIColor colorWithRed:240.0/255 green:240.0/255 blue:240.0/255 alpha:1.0];
        _progressView.progressTintColor = [UIColor greenColor];
    }
    return _progressView;
}

- (UIBarButtonItem*)backItem{
    if (!_backItem) {
        UIImage* backItemImage = [[UIImage axBundle_imageNamed:@"ax_itemBack"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        UIImage* backItemHlImage = [[UIImage axBundle_imageNamed:@"ax_itemBack_h"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        UIButton* backButton = [[UIButton alloc] init];
        //        [backButton setTitle:AXKitLocalizedString(@"ax.back") forState:UIControlStateNormal];
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
        NSString*title = AXKitLocalizedString(@"ax.cancel");
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

- (UIBarButtonItem*)closeItem{
    if (!_closeItem) {
        _closeItem = [[UIBarButtonItem alloc] initWithTitle:AXKitLocalizedString(@"ax.close") style:UIBarButtonItemStylePlain target:self action:@selector(closeItemAction:)];
    }
    return _closeItem;
}

- (UIBarButtonItem *)cancelItem{
    if (!_cancelItem) {
        _cancelItem = [[UIBarButtonItem alloc]initWithCustomView:self.cancelButton];
    }
    return _cancelItem;
}

- (AXScriptMessageHandlerHelper *)handlerHelper {
    if (!_handlerHelper) {
        _handlerHelper = [AXScriptMessageHandlerHelper scriptMessageWithHandler:self];
    }
    return _handlerHelper;
}

- (NSMutableDictionary<NSString *,AXScriptErrorBlock > *)scriptMessageDict {
    if (!_scriptMessageDict) {
        _scriptMessageDict = NSMutableDictionary.dictionary;
    }
    return _scriptMessageDict;
}
- (NSMutableDictionary<NSString *,AXWebScriptMessageModel *> *)scriptMessageModelDict {
    if (!_scriptMessageModelDict) {
        _scriptMessageModelDict = NSMutableDictionary.dictionary;
    }
    return _scriptMessageModelDict;
}
#pragma mark - dealloc
- (void)dealloc{
//    [self.webView.configuration.userContentController removeAllUserScripts];
//    self.webView.scrollView.delegate = nil;
    //    [self.webView removeObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress))];
    //    [self.webView removeObserver:self forKeyPath:NSStringFromSelector(@selector(title))];
    axLong_dealloc;
}

//- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
//    return UIInterfaceOrientationMaskPortrait;
//}
//
//- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
//    return UIInterfaceOrientationPortrait;
//}

@end


#pragma mark - 文档
/**
 https://juejin.cn/post/6943484128230637604
 
 */
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
 
 
 
 // oc调用js方法
 NSString *jsStr = [NSString stringWithFormat:@"showAler('%@')",@"AB"];
 [self.webView evaluateJavaScript:jsStr completionHandler:^(id _Nullable data, NSError * _Nullable error) {
 NSLog(@"evaluateJavaScript>> %@  %@",data,error.localizedDescription);
 }];
 
 
 
 // 在JS中如果调用了bridge.send()，那么将触发OC端_bridge初始化方法中的回调。
 
 // 在JS中调用了bridge.callHandler('testJavascriptHandler')，它将触发OC端注册的同名方法
 
 在JS端：
 
 
 
 <script type="text/javascript">
 
 
 //这是必须要写的，用来初始化一些设置
 function setupWebViewJavascriptBridge(callback) {
 if (window.WebViewJavascriptBridge) { return callback(WebViewJavascriptBridge); }
 if (window.WVJBCallbacks) { return window.WVJBCallbacks.push(callback); }
 window.WVJBCallbacks = [callback];
 var WVJBIframe = document.createElement('iframe');
 WVJBIframe.style.display = 'none';
 WVJBIframe.src = 'wvjbscheme://__BRIDGE_LOADED__';
 document.documentElement.appendChild(WVJBIframe);
 setTimeout(function() { document.documentElement.removeChild(WVJBIframe) }, 0)
 }
 
 // xcode中的 oc代码
 //这也是固定的， OC 调JS ， 需要给OC调用的函数必须写在这个函数里面
 
 bridge.registerHandler('testJSFunction', function(data, responseCallback) {
 alert('JS方法被调用:'+data);
 responseCallback('js执行过了');
 })
 
 
 
 // h5 页面中的js代码  调oc 代码
 //这个 shareClick 就是 原生那边 注入的函数 ， 通过这个方法来调用原生 和传值
 //parmas 是JS 给OC的数据 ， response 是 OC函数被调用之后 再 告诉JS 我被调用了
 //比如微信分享，给Dic给原生 ， 原生分享成功后再把结果回调给JS 进行处理
 function shareClick() {
 
 var params = {'title':'测试分享的标题','content':'测试分享的内容','url':'http://www.baidu.com'};
 WebViewJavascriptBridge.callHandler('shareClick',params,function(response) {
 
 console.log(response);
 
 
 });
 }
 
 
 //
 // WebViewJavascriptBridge js 交互
 // */
//- (void)_initWebViewJavascriptBridge{
//
//    // 开启日志，方便调试
//    [WKWebViewJavascriptBridge enableLogging];
//    // 给哪个webview建立JS与OjbC的沟通桥梁
//    self.bridge = [WKWebViewJavascriptBridge bridgeForWebView:self.webView];
//    // 设置代理，如果不需要实现，可以不设置
//    // 如果控制器里需要监听WKWebView 的`navigationDelegate`方法，就需要添加下面这行。
//    [self.bridge setWebViewDelegate:self];
//
//    [self.bridge registerHandler:@"iosWeixinPay" handler:^(id data, WVJBResponseCallback responseCallback) {
//        //data  js 传来的参数
//        NSLog(@"data>> %@", data);
//
//        //        if (responseCallback) {
//        //            // 反馈给JS ,js 不需要反馈 就不需要写
//        //            responseCallback(@{@"userId": @"123456"});
//        //        }
//    }];
//
//    //    [self.bridge callHandler:@"function_name"data:@{} responseCallback:^(id responseData) {
//    //
//    //        NSLog(@"from js: %@", responseData);
//    //    }];
//
//}

/**
 
 Native加载并缓存H5页面中的image
 拦截请求，最核心的是在NSURLProtocol子类中，实现这个方法
 + (BOOL)canInitWithRequest:(NSURLRequest *)request {
 //处理过不再处理
 if ([NSURLProtocol propertyForKey:DAURLProtocolHandledKey inRequest:request]) {
 return NO;
 }
 //根据request header中的 accept 来判断是否加载图片
 
 {
 "Accept" = "image/png,image/svg+xml,image/*;q=0.8,*\/*;q=0.5\";
 "User-Agent" = "Mozilla/5.0 (iPhone; CPU iPhone OS 10_3 like Mac OS X) AppleWebKit/603.1.30 (KHTML, like Gecko) Mobile/14E269 WebViewDemo/1.0.0";
 }
 NSDictionary *headers = request.allHTTPHeaderFields;
 NSString *accept = headers[@"Accept"];
 if (accept.length >= @"image".length && [accept rangeOfString:@"image"].location != NSNotFound) {
 return YES;
 }
 return NO;
 }
 
 */
