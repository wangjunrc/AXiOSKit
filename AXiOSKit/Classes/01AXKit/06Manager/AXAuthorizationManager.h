//
//  AXAuthorizationManager.h
//  AXiOSKit
//
//  Created by AXing on 2019/2/14.
//  Copyright © 2019 liu.weixing. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


/**
 各种授权 管理类
 */
@interface AXAuthorizationManager : NSObject

/**
 用户通知授权状态
 */
-(void)noticeAuthorizationState:(void(^)(BOOL success))block;

/**
 用户通知授权
 */
-(void)noticeAuthorization;

/**
 用户定位授权,
 *一般不需要主动调,个别系统bug,会无法出现授权alert,需要主动调用
 */
-(void)locationAuthorization;

@end

NS_ASSUME_NONNULL_END
