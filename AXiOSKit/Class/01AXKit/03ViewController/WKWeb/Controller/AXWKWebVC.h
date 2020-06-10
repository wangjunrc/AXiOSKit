//
//  AXWKWebVC.h
//  AXiOSKit
//
//  Created by liuweixing on 16/10/13.
//  Copyright © 2016年 liuweixing. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
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

/**
 *  加载html 文字
 *  <p style='font-size: 20px'>测试</p>
 */
@property (nonatomic, copy) NSString *HTML;

/// 加载网页 NSURL 格式
/// https://xxxc.com
/// 加载本地网页 返回NSURL
/// [[NSBundle mainBundle] URLForResource:@"H5.bundle/index.html" withExtension:nil];
/// 加载本地网页 返回NSString
/// [NSBundle.mainBundle pathForResource:@"H5.bundle/index.html" ofType:nil];
@property (nonatomic, copy) NSURL *URL;


/**
 加载 webview ,viewController  viewDidLoad 会自动加载一次
 需要更换url的 需主动调用一次
 */
- (void)loadWebView;

/**
 js 回调oc
 
 @param ocMethodName oc方法名
 @param handler 回调
 */
- (void)addScriptMessageWithName:(NSString*)ocMethodName
                         handler:(void (^)(NSString* name, id body))handler;

/**
 js 回调oc
 
 @param delegate 遵守 AXScriptMessageDelegate 协议的 实例
 @param name js与oc 对应的key
 */
- (void)addScriptDelegate:(id<AXScriptMessageDelegate>)delegate
                   forKey:(NSString *)name;

/**
 oc 调用js方法
 
 @param jsMethodName js方法名
 @param handler 回调
 */
- (void)evaluateJavaScript:(NSString*)jsMethodName
                   handler:(void (^)(id data, NSError* error))handler;

@end
NS_ASSUME_NONNULL_END
