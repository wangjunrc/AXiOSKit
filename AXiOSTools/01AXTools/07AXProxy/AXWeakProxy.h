//
//  AXWeakProxy.h
//  AXiOSTools
//
//  Created by liuweixing on 2018/5/31.
//  Copyright © 2018年 liuweixing. All rights reserved.
//

// AXWeakProxy 代码
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AXWeakProxy : NSProxy

@property (nonatomic, weak, readonly)id target;

- (instancetype )initWithTarget:(id )target;

+ (instancetype )proxyWithTarget:(id )target;

@end

NS_ASSUME_NONNULL_END
