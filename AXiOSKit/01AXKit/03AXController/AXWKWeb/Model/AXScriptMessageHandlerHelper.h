//
//  AXWKScriptMessageHandlerHelper.h
//  AXiOSKit
//
//  Created by AXing on 2019/1/19.
//  Copyright © 2019 liu.weixing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AXScriptMessageHandlerHelper : NSObject <WKScriptMessageHandler>

/**weak handler*/
@property (nonatomic, weak) id<WKScriptMessageHandler> handler;

- (instancetype)initWithHandler:(id<WKScriptMessageHandler>)handler;

+ (instancetype)scriptMessageWithHandler:(id<WKScriptMessageHandler>)handler;

@end

NS_ASSUME_NONNULL_END
