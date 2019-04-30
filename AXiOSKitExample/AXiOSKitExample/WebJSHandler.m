//
//  WebJSHandler.m
//  AXiOSKitExample
//
//  Created by AXing on 2019/4/30.
//  Copyright © 2019 liu.weixing. All rights reserved.
//

#import "WebJSHandler.h"

@implementation WebJSHandler

- (void)webVC:(nonnull AXWKWebVC *)webVC handleMessage:(nonnull id)message {
    NSLog(@"WebJSHandler message>> %@",message);
    
}

@end
