//
//  AXWKWebVC.h
//  AXiOSTools
//
//  Created by liuweixing on 16/10/13.
//  Copyright © 2016年 liuweixing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AXWKWebVC : UIViewController

/**
 *加载纯外部链接网页
 */
@property (nonatomic, copy) NSString* loadURLString;

/**
 *加载html 文字
 * <font size="30">xx</font>
 */
@property (nonatomic, copy) NSString* loadHTMLString;

/**
 *加载本地网页
 *使用[NSBundle.mainBundle pathForResource:@"xx.html" ofType:nil];方式赋值
 */
@property (nonatomic, copy) NSString* loadHTMLFilePath;

/**
 加载 webview ,viewController  viewDidLoad 会自动加载一次
 需要更换url的 需主动调用一次
 */
- (void)loadWebView;

/**
 js 回调oc
 
 @param name oc方法名
 @param handler 回调
 */
- (void)addScriptMessageWithName:(NSString*)name
                         handler:(void (^)(NSString* name, id body))handler;

/**
 oc 调用js方法
 
 @param javaScriptString js方法名
 @param handler 回调
 */
- (void)evaluateJavaScript:(NSString*)javaScriptString
                   handler:(void (^)(id data, NSError* error))handler;

@end
