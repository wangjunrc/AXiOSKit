//
//  AXWKWebVC.h
//  AXiOSKit
//
//  Created by liuweixing on 16/10/13.
//  Copyright © 2016年 liuweixing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^AXScriptErrorBlock)(id data, NSError* error) ;

typedef void (^AXScriptBodyBlock)(NSString *name, id body);

@class AXWKWebVC;
@protocol AXScriptMessageDelegate <NSObject>

/**
 处理消息
 
 @param webVC webView
 @param name 消息名称
 @param body 消息内容
 */
- (void)webVC:(AXWKWebVC *)webVC messageName:(NSString *)name messageBody:(id)body;

@end

@interface AXWKWebVC : UIViewController
/// 加载网页 NSURL 格式
/// https://xxxc.com
/// 加载本地网页 返回NSURL
/// [[NSBundle mainBundle] URLForResource:@"H5.bundle/index.html" withExtension:nil];
/// 加载本地网页 返回NSString
/// [NSBundle.mainBundle pathForResource:@"H5.bundle/index.html" ofType:nil];
-(instancetype )initWithURL:(NSURL *)URL;

/**
 *  加载html 文字
 *  <p style='font-size: 20px'>测试</p>
 */
-(instancetype )initWithHTML:(NSString *)HTML;

/// 使用 html title 默认YES
@property(nonatomic, assign,getter=isUserHTMLTitle) BOOL userHTMLTitle;

@property (nonatomic, strong,readonly) WKWebView *webView;

/// 初始化的html 文字
@property (nonatomic, copy,readonly) NSString *HTML;

/// 初始化的NSURL
@property (nonatomic, copy,readonly) NSURL *URL;

/**
 加载 webview ,viewController  viewDidLoad 会自动加载一次
 需要更换url的 需主动调用一次
 */
- (void)loadWebView;

///高度刷新回调  会回调多次。如果要求 webView 的高度等于内容高度可根据此高度改变 XXXWebView 高度
@property (nonatomic, copy) void(^loadOverHeight)(CGFloat height);

/**
 js 回调oc
 就是oc先定义一个方法,js 发送一个消息
 @param ocMethodName oc方法名
 @param handler 回调
 */
- (void)addScriptMessageWithName:(NSString *)ocMethodName
                         handler:(AXScriptBodyBlock )handler;

/**
 js 回调oc,使用代理方式
 
 @param delegate 遵守 AXScriptMessageDelegate 协议的 实例
 @param name js与oc 对应的key
 */
- (void)addScriptDelegate:(id<AXScriptMessageDelegate>)delegate
                   forKey:(NSString *)name;

/**
 oc 注入js方法,
 js定义了方法,oc调用,就是注入一个js调用
 
 @param js js方法名
 @param handler 回调
 */
- (void)evaluateJavaScript:(NSString *)js
                   handler:(AXScriptErrorBlock )handler;

///  oc 注入js方法,没有回调 
///  js定义了方法,oc调用,就是注入一个js调用
/// @param js js方法名
/// @param time 注入时机
- (void)addUserScript:(NSString *)js
                 time:(WKUserScriptInjectionTime )time;

- (void)addUserScript:(NSString *)js
                 time:(WKUserScriptInjectionTime )time
     forMainFrameOnly:(BOOL )only;

@end
NS_ASSUME_NONNULL_END
