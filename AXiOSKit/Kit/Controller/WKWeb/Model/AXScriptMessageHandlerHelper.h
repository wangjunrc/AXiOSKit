//
//  AXWKScriptMessageHandlerHelper.h
//  AXiOSKit
//
//  Created by axing on 2019/1/19.
//  Copyright © 2019 liu.weixing. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol WKScriptMessageHandler;
NS_ASSUME_NONNULL_BEGIN

/// weak handler,wkwebview会强引用
@interface AXScriptMessageHandlerHelper : NSObject <WKScriptMessageHandler>

@property (nonatomic, weak) id<WKScriptMessageHandler> handler;

- (instancetype)initWithHandler:(id<WKScriptMessageHandler>)handler;

+ (instancetype)scriptMessageWithHandler:(id<WKScriptMessageHandler>)handler;

@end

NS_ASSUME_NONNULL_END
