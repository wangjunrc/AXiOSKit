//
//  NSMutableArray+AXKVO.h
//  AXiOSKit
//
//  Created by 小星星吃KFC on 2020/9/28.
//  Copyright © 2020 liu.weixing. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableArray (AXKVO)


/// NSMutableArray 监听方法
/// @param handler 回调
-(void)ax_addKVO:(void(^)(NSMutableArray *array))handler;

@end

NS_ASSUME_NONNULL_END
