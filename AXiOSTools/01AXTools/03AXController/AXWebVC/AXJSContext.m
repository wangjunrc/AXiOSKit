//
//  AXJSContext.m
//  JS
//
//  Created by AXing on 2018/12/27.
//  Copyright © 2018 AXing. All rights reserved.
//

#import "AXJSContext.h"

@interface AXJSContextModel : NSObject<AXJSContextDelegate>

@property (nonatomic, strong)void(^callHandler)(id data);

@end

@implementation AXJSContextModel

- (void)postMessage:(id)data{
    if (self.callHandler) {
        self.callHandler(data);
    }
}

@end

@interface AXJSContext ()

@property (nonatomic, weak)UIWebView *webView;

@property (nonatomic, strong) JSContext *jsContext;

@end


@implementation AXJSContext

+ (instancetype)contextForWebView:(UIWebView*)webView{
    
    AXJSContext* bridge = [[self alloc] init];
    bridge.webView = webView;
    bridge.jsContext = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    return bridge;
}

- (void)registerHandler:(NSString *)handlerName handler:(void(^)(id data))handler{
    
    AXJSContextModel *model  = [[AXJSContextModel alloc] init];
    model.callHandler = ^(id  _Nonnull data) {
       
        if (handler) {
            handler(data);
        }
    };
    self.jsContext[handlerName] = model;
}


- (NSString *)stringByEvaluatingJavaScriptFromString:(NSString *)script {
    
    return  [self.webView stringByEvaluatingJavaScriptFromString:script];
}


@end
