//
//  AXHelper.h
//  AXTools
//
//  Created by liuweixing on 2018/11/17.
//  Copyright © 2018 liuweixing. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AXHelper : NSObject


//+ (void)isDebug:(void(^)(void))bebug release:(void(^)(void))release;
//
//+ (void)iPad:(void(^)(void))iPad iPhone:(void(^)(void))iPhone;


/**
 iPhone 模式回调
 */
@property (nonatomic, copy, readonly) AXHelper *(^isIPhone)(void(^)(void));

/**
 iPad 模式回调
 */
@property (nonatomic, copy, readonly) AXHelper *(^isIPad)(void(^)(void));


/**
 Debug 模式回调
 */
@property (nonatomic, copy, readonly) AXHelper *(^axDebug)(void(^)(void));

/**
 Release 模式回调
 */
@property (nonatomic, copy, readonly) AXHelper *(^axRelease)(void(^)(void));


@end

NS_ASSUME_NONNULL_END
