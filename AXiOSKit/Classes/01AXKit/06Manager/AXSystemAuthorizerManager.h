//
//  AXAuthorizationManager.h
//  AXiOSKit
//
//  Created by axing on 2019/2/14.
//  Copyright © 2019 liu.weixing. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

//权限类型
typedef NS_ENUM(NSInteger, AXSystemAuthorizerType) {
    AXSystemAuthorizerTypeNone,
    /// 相机
    AXSystemAuthorizerTypeCamera,
    /// 相册
    AXSystemAuthorizerTypePhoto,
    /// 麦克风
    AXSystemAuthorizerTypeAudio,
    /// 通知
    AXSystemAuthorizerTypeNotification,
    /// 定位
    AXSystemAuthorizerTypeLocation,
    /// 定位 - 使用时定位
    AXSystemAuthorizerTypeLocationWhenInUseAuthorization,
    /// 定位 - 一直使用
    AXSystemAuthorizerTypeLocationAlwaysAuthorization
};

//权限状态
typedef NS_ENUM(NSInteger, AXSystemAuthorizerStatus) {
    AXSystemAuthorizerStatusNotDetermined,
    AXSystemAuthorizerStatusRestricted,
    AXSystemAuthorizerStatusDenied,
    AXSystemAuthorizerStatusAuthorized,
    AXSystemAuthorizerStatusProvisional,
};


/**
 各种授权 管理类
 */
@interface AXSystemAuthorizerManager : NSObject

/// 授权
+ (instancetype)requestAuthorizedWithType:(AXSystemAuthorizerType)type
                                completion:(void(^)(AXSystemAuthorizerStatus status))completion;

/**
 用户定位授权,
 *一般不需要主动调,个别系统bug,会无法出现授权alert,需要主动调用
 */
-(void)locationAuthorization;


@end

NS_ASSUME_NONNULL_END
