//
//  AXHelper.h
//  AXKit
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
///不是单利
@property(nonatomic, strong, class) AXHelper *defaultHelper;

/**
 iPhone 模式回调
 */
@property(nonatomic, copy, readonly) AXHelper *(^isiPhone)(void(^)(void));

/**
 iPad 模式回调
 */
@property(nonatomic, copy, readonly) AXHelper *(^isiPad)(void(^)(void));


/**
 Debug 模式回调
 */
@property(nonatomic, copy, readonly) AXHelper *(^isDebug)(void(^)(void));

/**
 Release 模式回调
 */
@property(nonatomic, copy, readonly) AXHelper *(^isRelease)(void(^)(void));


///**
// iPhone 模式回调
// */
//@property (class,nonatomic) AXHelper *(^isiPhone)(void(^)(void));
//
///**
// iPad 模式回调
// */
//@property (class,nonatomic) AXHelper *(^isiPad)(void(^)(void));
//
//
///**
// Debug 模式回调
// */
//@property (class,nonatomic) AXHelper *(^isDebug)(void(^)(void));
//
///**
// Release 模式回调
// */
//@property (class,nonatomic) AXHelper *(^isRelease)(void(^)(void));

@end

NS_ASSUME_NONNULL_END
