//
//  AXJSContext.h
//  JS
//
//  Created by AXing on 2018/12/27.
//  Copyright © 2018 AXing. All rights reserved.
//

/**
 UIWebView js 和 oc 通过JavaScriptCore交互
 */
#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import <UIKit/UIKit.h>

@protocol AXJSContextDelegate <JSExport>

/**
 js调用oc 统一方法名

 @param data 传值
 */
- (void)postMessage:(id)data ;

@end

@interface AXJSContext : NSObject

/**
 初始化方法

 @param webView UIWebView
 @return AXJSContext
 */
+ (instancetype)contextForWebView:(UIWebView*)webView;

/**
 oc注册方法,js调用
js 调用oc 方法 格式
 {handlerName}.postMessage(data);
 @param handlerName oc方法名
 @param handler js传给oc
 */
- (void)registerHandler:(NSString *)handlerName
                handler:(void(^)(id data))handler;


/**
 oc直接调用js方法

 @param script js方法名和js参数拼接 sring
 @return string
 */
- (nullable NSString *)stringByEvaluatingJavaScriptFromString:(NSString *)script;

@end
