//
//  AXWKScriptMessageHandler.m
//  AXiOSTools
//
//  Created by AXing on 2019/1/19.
//  Copyright © 2019 liu.weixing. All rights reserved.
//

#import "AXWKScriptMessageHandler.h"
#import "AXiOSTools.h"
@implementation AXWKScriptMessageHandler

-(instancetype)initWithHandler:(id<WKScriptMessageHandler>)handler {
    
    self = [super init];
    if (self) {
        _handler = handler;
    }
    return self;
}

+ (instancetype )scriptMessageWithHandler:(id<WKScriptMessageHandler>)handler {
    return [[self alloc]initWithHandler:handler];
}

//依然是这个协议方法,获取注入方法名对象,获取js返回的状态值.
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    
    [self.handler userContentController:userContentController didReceiveScriptMessage:message];
}

@end
