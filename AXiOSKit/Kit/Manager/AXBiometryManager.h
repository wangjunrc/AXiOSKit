//
//  AXBiometryManager.h
//  AXiOSKitDemo
//
//  Created by liuweixing on 2018/6/23.
//  Copyright © 2018年 liuweixing. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 使用时,定义属性,不用单例 方便内存
 @property(nonatomic,strong)AXBiometryManager *touchIDManager;
 */

@interface AXBiometryManager : NSObject


/// 是否支持 TouchID
@property(nonatomic, assign,readonly,getter=isSupportTouchID) BOOL supportTouchID;

/// 是否支持 FaceID
@property(nonatomic, assign,readonly,getter=isSupportFaceID) BOOL supportFaceID;


/**
 打开touch id
 
 @param success 成功
 @param inputPassword 失败后,点击输入密码
 @param cancel 点击取消
 */

/**
  打开touch id

 @param successBlock 成功
 @param failureBlock 3次失败,避免5次失败
 @param inputPasswordBlock 失败后,点击输入密码
 @param cancelBlock 点击取消
 */
- (void)openBiometryWithSuccess:(void(^)(void))success
                       failure:(void(^)(NSError *error))failure;

@end
