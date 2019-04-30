//
//  AXWKWebVC.h
//  AXiOSTools
//
//  Created by liuweixing on 16/10/13.
//  Copyright © 2016年 liuweixing. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

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
 NSURL *path = [[NSBundle mainBundle] URLForResource:@"Cookie" withExtension:@"html"];
 */
@property (nonatomic, copy) NSString* loadHTMLFilePath;


@property (nonatomic, strong) NSURL* loadURL;


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
 oc 调用js方法
 
 @param jsMethodName js方法名
 @param handler 回调
 */
- (void)evaluateJavaScript:(NSString*)jsMethodName
                   handler:(void (^)(id data, NSError* error))handler;

@end
NS_ASSUME_NONNULL_END
