//
//  _TestHelper.m
//  AXiOSKit
//
//  Created by 小星星吃KFC on 2021/7/8.
//  Copyright © 2021 axinger. All rights reserved.
//

#import "_TestHelper.h"

@implementation _TestHelper


- (AXHelper * _Nonnull (^)(void (^ _Nonnull)(void)))isDebug {
    
    NSLog(@"%s", __func__);
    return [super isDebug];;
}

@end
