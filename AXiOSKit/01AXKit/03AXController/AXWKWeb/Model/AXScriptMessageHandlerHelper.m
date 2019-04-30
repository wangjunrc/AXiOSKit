//
//  AXScriptMessageHandlerHelper.m
//  AXiOSKit
//
//  Created by AXing on 2019/1/19.
//  Copyright © 2019 liu.weixing. All rights reserved.
//

#import "AXScriptMessageHandlerHelper.h"

@implementation AXScriptMessageHandlerHelper : NSObject 

- (instancetype)initWithHandler:(id<WKScriptMessageHandler>)handler
{

    self = [super init];
    if (self) {
        _handler = handler;
    }
    return self;
}

+ (instancetype)scriptMessageWithHandler:(id<WKScriptMessageHandler>)handler
{
    return [[self alloc] initWithHandler:handler];
}

- (void)userContentController:(WKUserContentController*)userContentController didReceiveScriptMessage:(WKScriptMessage*)message
{
    if (self.handler && [self.handler respondsToSelector:@selector(userContentController:didReceiveScriptMessage:)]) {
        [self.handler userContentController:userContentController didReceiveScriptMessage:message];
    }
}

@end
