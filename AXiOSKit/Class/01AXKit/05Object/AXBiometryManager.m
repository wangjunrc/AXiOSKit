//
//  AXBiometryManager.m
//  AXiOSKitDemo
//
//  Created by liuweixing on 2018/6/23.
//  Copyright © 2018年 liuweixing. All rights reserved.
//

#import "AXBiometryManager.h"
#import <LocalAuthentication/LocalAuthentication.h>
#import "AXMacros.h"

@interface AXBiometryManager ()

@property(nonatomic, strong)LAContext *context;

@property (nonatomic, copy)void(^successBlock)(void);

@property (nonatomic, copy)void(^failureBlock)(NSError *error);

@end

@implementation AXBiometryManager


/**
 是否支持touch id
 
 @return 是否
 */
- (BOOL )isSupportTouchID {
    //    if (@available(iOS 11.0, *)) {
    //        NSLog(@"self.context.biometryType %ld",self.context.biometryType);
    //        return self.context.biometryType == LABiometryTypeTouchID;
    //    }else {
    return [self.context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:nil];
    //    }
}


/// 是否支持 FaceID
- (BOOL )isSupportFaceID {
    if (@available(iOS 11.0, *)) {
        return self.context.biometryType == LABiometryTypeFaceID;
    }else {
        return NO;
    }
}

/**
 打开touch id
 
 @param successBlock 成功
 @param failureBlock 3次失败,避免5次失败
 @param inputPasswordBlock 失败后,点击输入密码
 @param cancelBlock 点击取消
 */
- (void)openBiometryWithSuccess:(void(^)(void))success
                        failure:(void(^)(NSError *error))failure {
    
    self.successBlock = success;
    self.failureBlock = failure;
    ///右边按钮默认是密码验证，
    ///下面的方法 policy参数传LAPolicyDeviceOwnerAuthentication时，在两次验证失败后点击会弹出密码验证页面，
    ///传LAPolicyDeviceOwnerAuthenticationWithBiometrics则不会。
    
    [self _openBiometryWithPolicy:LAPolicyDeviceOwnerAuthentication success:success failure:failure];
    
}

#pragma mark - 内部方法（Private）


/// 开启指纹扫描
- (void)_openBiometryWithPolicy:(LAPolicy )policy
                        success:(void(^)(void))successBlock
                        failure:(void(^)(NSError *error))failureBlock{
    
    
    self.context.localizedFallbackTitle = @"验证码登录";
    NSString *kind = self.isSupportTouchID ? @"指纹" : self.isSupportFaceID ? @"面容" : @"";
    
    
    __weak typeof(self) weakSelf = self;
    [self.context evaluatePolicy:policy localizedReason:[NSString stringWithFormat:@"请验证已有%@",kind] reply:^(BOOL success, NSError * _Nullable error) {
        __strong typeof(weakSelf) self = weakSelf;
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSString *message = @"";
            
            if (success) {
                
                message = [NSString stringWithFormat: @"通过了%@验证",kind];
                if (successBlock) {
                    successBlock();
                }
                
            } else {
                //失败操作
                LAError code = error.code;
                
                switch (code) {
                    case LAErrorAuthenticationFailed: {
                        // -1
                        message = [NSString stringWithFormat: @"连续三次%@识别错误",kind];
                        [self _openBiometryWithPolicy:LAPolicyDeviceOwnerAuthentication success:successBlock failure:failureBlock];
                    }
                        break;
                        
                    case LAErrorUserCancel: {
                        // -2
                        message = [NSString stringWithFormat: @"用户取消%@验证",kind];
                    }
                        break;
                        
                    case LAErrorUserFallback: {
                        // -3 用户点击了手动输入密码的按钮，所以被取消了
                        message = @"用户选择输入密码";
                        //                        [self _openBiometryWithPolicy:LAPolicyDeviceOwnerAuthentication success:successBlock failure:failureBlock inputPassword:inputPasswordBlock cancel:cancelBlock];
                        
                    }
                        break;
                        
                    case LAErrorSystemCancel: {
                        // -4 TouchID对话框被系统取消，例如按下Home或者电源键
                        message = @"取消授权，如其他应用切入";
                        //                        [self _openBiometryWithPolicy:LAPolicyDeviceOwnerAuthentication success:successBlock failure:failureBlock inputPassword:inputPasswordBlock cancel:cancelBlock];
                    }
                        break;
                        
                    case LAErrorPasscodeNotSet: {
                        // -5
                        message = @"设备系统未设置密码";
                    }
                        break;
                        
                    case LAErrorTouchIDNotAvailable: {
                        // -6
                        message = [NSString stringWithFormat: @"此设备不支持%@",kind];
                    }
                        break;
                        
                    case LAErrorTouchIDNotEnrolled: {
                        // -7
                        message = [NSString stringWithFormat: @"用户未录入%@",kind];
                    }
                        break;
                        
                    case LAErrorTouchIDLockout: {
                        // -8 连续五次指纹识别错误，TouchID功能被锁定，下一次需要输入系统密码
                        message = [NSString stringWithFormat: @"%@被锁，需要用户输入密码解锁",kind];
                        //                        [self _openBiometryWithPolicy:LAPolicyDeviceOwnerAuthentication success:successBlock failure:failureBlock inputPassword:inputPasswordBlock cancel:cancelBlock];
                    }
                        break;
                        
                    case LAErrorAppCancel: {
                        // -9 如突然来了电话，电话应用进入前台，APP被挂起啦
                        message = @"用户不能控制情况下APP被挂起";
                    }
                        break;
                        
                    case LAErrorInvalidContext: {
                        // -10
                        message = [NSString stringWithFormat: @"%@失效",kind];
                    }
                        break;
                        
                    default:
                        break;
                }
                NSLog(@"message = %@",message);
                if (failureBlock) {
                    NSError *error = [NSError errorWithDomain:@"com.ax.kit" code:code userInfo:@{@"message":message}];
                    failureBlock(error);
                }
            }
        });
    }];
    
}

- (LAContext *)context {
    if (!_context) {
        _context = [[LAContext alloc]init];
    }
    return _context;
}


#pragma mark - 说明
/*
 typedef NS_ENUM(NSInteger, LAError)
 {
 LAErrorAuthenticationFailed,     // 验证信息出错，就是说你指纹不对
 LAErrorUserCancel               // 用户取消了验证
 LAErrorUserFallback             // 用户点击了手动输入密码的按钮，所以被取消了
 LAErrorSystemCancel             // 被系统取消，就是说你现在进入别的应用了，不在刚刚那个页面，所以没法验证
 LAErrorPasscodeNotSet           // 用户没有设置TouchID
 LAErrorTouchIDNotAvailable      // 用户设备不支持TouchID
 LAErrorTouchIDNotEnrolled       // 用户没有设置手指指纹
 LAErrorTouchIDLockout           // 用户错误次数太多，现在被锁住了
 LAErrorAppCancel                // 在验证中被其他app中断
 LAErrorInvalidContext           // 请求验证出错
 }
 
 typedef NS_ENUM(NSInteger, LAPolicy)
 {
 LAPolicyDeviceOwnerAuthenticationWithBiometrics NS_ENUM_AVAILABLE(NA, 8_0) __WATCHOS_AVAILABLE(3.0) __TVOS_AVAILABLE(10.0) = kLAPolicyDeviceOwnerAuthenticationWithBiometrics,
 LAPolicyDeviceOwnerAuthentication NS_ENUM_AVAILABLE(10_11, 9_0) = kLAPolicyDeviceOwnerAuthentication
 
 }
 第一个枚举LAPolicyDeviceOwnerAuthenticationWithBiometrics就是说，用的是手指指纹去验证的；NS_ENUM_AVAILABLE(NA, 8_0)iOS8 可用
 第二个枚举LAPolicyDeviceOwnerAuthentication少了WithBiometrics则是使用TouchID或者密码验证,默认是错误两次指纹或者锁定后,弹出输入密码界面;NS_ENUM_AVAILABLE(10_11, 9_0)iOS 9可用
 */


@end
