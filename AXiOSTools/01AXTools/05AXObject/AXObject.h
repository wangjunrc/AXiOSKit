//
//  AXObject.h
//  BigApple
//
//  Created by liuweixing on 2016/12/5.
//  Copyright © 2016年 liuweixing All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AXObject : NSObject

+ (void)isDebug:(void(^)(void))bebug release:(void(^)(void))release;

+ (void)iPad:(void(^)(void))iPad iPhone:(void(^)(void))iPhone;

/**
 Debug 模式回调
 */
@property (nonatomic, copy, readonly) AXObject *(^axDebug)(void(^)(void));

/**
 Release 模式回调
 */
@property (nonatomic, copy, readonly) AXObject *(^axRelease)(void(^)(void));

@end
