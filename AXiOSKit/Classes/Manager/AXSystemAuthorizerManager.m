//
//  AXAuthorizationManager.m
//  AXiOSKit
//
//  Created by axing on 2019/2/14.
//  Copyright © 2019 liu.weixing. All rights reserved.
//

#import "AXSystemAuthorizerManager.h"
#import "UserNotifications/UserNotifications.h"
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>

@interface AXSystemAuthorizerManager ()<CLLocationManagerDelegate>

@property(nonatomic,strong)CLLocationManager *locationManager;

@property(nonatomic,assign,readwrite)AXSystemAuthorizerType type;

@property(nonatomic,assign,readwrite)AXSystemAuthorizerStatus status;

@property(nonatomic, copy) void(^completion)(AXSystemAuthorizerStatus status);

@end
@implementation AXSystemAuthorizerManager


/// 授权
+ (instancetype)requestAuthorizedWithType:(AXSystemAuthorizerType)type
                               completion:(void(^)(AXSystemAuthorizerStatus status))completion
{
    AXSystemAuthorizerManager * obj = [[self alloc]init];
    obj.type = type;
    obj.completion = completion;
    if (obj) {
        
        switch (type) {
            case AXSystemAuthorizerTypeCamera:
            {
                [obj _TypeCameraCompletion:completion];
            }
                break;
            case AXSystemAuthorizerTypePhoto:
            {
                [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                    if (completion) {
                        completion((AXSystemAuthorizerStatus)status);
                    }
                }];
            }
                break;
            case AXSystemAuthorizerTypeAudio:
            {
                [AVCaptureDevice requestAccessForMediaType:AVMediaTypeAudio
                                         completionHandler:^(BOOL granted) {
                    AXSystemAuthorizerStatus status = (granted ? AXSystemAuthorizerStatusAuthorized : AXSystemAuthorizerStatusDenied);
                    if (completion) {
                        completion(status);
                    }
                }];
            }
                break;
                
            case AXSystemAuthorizerTypeNotification:{
                [obj _TypeNotificationCompletion:completion];
            }
                break;
            case AXSystemAuthorizerTypeLocation:
            case AXSystemAuthorizerTypeLocationWhenInUseAuthorization:
            case AXSystemAuthorizerTypeLocationAlwaysAuthorization:
                [obj _TypeLocationWhenInUseAuthorization:completion];
                break;
            default:
                break;
        }
    }
    return obj;
}

-(void)_TypeCameraCompletion:(void(^)(AXSystemAuthorizerStatus status))completion {
    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo
                             completionHandler:^(BOOL granted) {
        AXSystemAuthorizerStatus status = (granted ? AXSystemAuthorizerStatusAuthorized : AXSystemAuthorizerStatusDenied);
        if (completion) {
            completion(status);
        }
    }];
}

-(void)_TypeNotificationCompletion:(void(^)(AXSystemAuthorizerStatus status))completion {
    if (@available(iOS 10.0, *)) {
        
        UNAuthorizationOptions options = UNAuthorizationOptionAlert |UNAuthorizationOptionBadge | UNAuthorizationOptionSound;
        UNUserNotificationCenter *center = UNUserNotificationCenter.currentNotificationCenter;
        /// 授权
        [center requestAuthorizationWithOptions: options completionHandler:^(BOOL granted, NSError *__nullable error){
            /// 查看状态
            [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
                if (completion) {
                    
                    AXSystemAuthorizerStatus status = AXSystemAuthorizerStatusNotDetermined;
                    
                    switch (settings.authorizationStatus) {
                        case UNAuthorizationStatusNotDetermined:
                            status = AXSystemAuthorizerStatusNotDetermined;
                            break;
                        case UNAuthorizationStatusDenied:
                            status = AXSystemAuthorizerStatusDenied;
                            break;
                        case UNAuthorizationStatusAuthorized:
                            status = AXSystemAuthorizerStatusAuthorized;
                            break;
                        case UNAuthorizationStatusProvisional:
                            status = AXSystemAuthorizerStatusProvisional;
                            break;
                        default:
                            break;
                    }
                    completion(status);
                }
                
            }];
            
        }];
        
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
        UIUserNotificationSettings *setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
        AXSystemAuthorizerStatus status  = (UIUserNotificationTypeNone == setting.types) ? AXSystemAuthorizerStatusNotDetermined : AXSystemAuthorizerStatusAuthorized;
        if (completion) {
            completion(status);
        }
#pragma clang diagnostic pop
    }
    
}

-(void)_TypeLocationWhenInUseAuthorization:(void(^)(AXSystemAuthorizerStatus status))completion {
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    
//    if (self.status == AXSystemAuthorizerTypeLocationWhenInUseAuthorization) {
        if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
            [self.locationManager requestWhenInUseAuthorization];
        }
//    }else if (self.status == AXSystemAuthorizerTypeLocationAlwaysAuthorization){
        if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
            [self.locationManager requestAlwaysAuthorization];
        }
//    }
    
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.distanceFilter = 10;//定位的频率,位置超出多少米定位一次
    [self.locationManager startUpdatingLocation];//启动定位
    
}
/**
 解决部分情况下 不弹出 定位 界面 直接初始化改实例对象
 */
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    
    //    kCLAuthorizationStatusNotDetermined = 0,
    //    kCLAuthorizationStatusRestricted,
    //    kCLAuthorizationStatusDenied,
    //    kCLAuthorizationStatusAuthorizedAlways API_AVAILABLE(macos(10.12), ios(8.0)),
    //    kCLAuthorizationStatusAuthorizedWhenInUse API_AVAILABLE(ios(8.0)) API_U
    AXSystemAuthorizerStatus status0 = AXSystemAuthorizerStatusNotDetermined;
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
            status0 = AXSystemAuthorizerStatusNotDetermined;
            break;
        case kCLAuthorizationStatusRestricted:
            status0 = AXSystemAuthorizerStatusRestricted;
            break;
        case kCLAuthorizationStatusDenied:
            status0 = AXSystemAuthorizerStatusDenied;
            break;
        default:
            status0 = AXSystemAuthorizerStatusAuthorized;
            break;
            
    }
    if (self.completion) {
        self.completion(status0);
    }
}

/**
 用户通知授权
 */
-(void)noticeAuthorization {
    
    if (@available(iOS 10.0,*)) {
        
        UNAuthorizationOptions options = UNAuthorizationOptionAlert |UNAuthorizationOptionBadge | UNAuthorizationOptionSound;
        UNUserNotificationCenter *center = UNUserNotificationCenter.currentNotificationCenter;
        [center requestAuthorizationWithOptions: options completionHandler:^(BOOL granted, NSError *__nullable error){
            if (granted) {
                NSLog(@"通知开通成功");
                dispatch_async(dispatch_get_main_queue(), ^{
                    [[UIApplication sharedApplication] registerForRemoteNotifications];
                });
            } else {
                NSLog(@"通知开通失败");
            }
        }];
    }else{
        
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
        UIUserNotificationType types = UIUserNotificationTypeAlert| UIUserNotificationTypeSound|UIUserNotificationTypeBadge;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        //        /*查看是否授权成功*/
        //        UIUserNotificationSettings *setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
        //        BOOL isEnable = (UIUserNotificationTypeNone == setting.types) ? NO : YES;
#pragma clang diagnostic pop
        
    }
}


/**
 用户定位授权
 */
-(void)locationAuthorization {
    
    CLLocationManager *locationManager = [[CLLocationManager alloc] init];
    self.locationManager = locationManager;
    
    //都调用,才能在设置里面看见选项
    if ([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [locationManager requestWhenInUseAuthorization];
    }
    
    if ([locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [locationManager requestAlwaysAuthorization];
    }
    
}



////非回调形式，不支持通知
//+ (AXSystemAuthorizerStatus)getAuthorizationStatusWithType:(AXSystemAuthorizerType)type
//{
//__block AXSystemAuthorizerStatus status = AXSystemAuthorizerStatusAuthorized;
//    switch (type) {
//        case AXSystemAuthorizerTypeCamera:
//        {
//            status = (AXSystemAuthorizerStatus)[AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
//        }
//            break;
//        case AXSystemAuthorizerTypePhoto:
//        {
//            status = (AXSystemAuthorizerStatus)[PHPhotoLibrary authorizationStatus];
//        }
//            break;
//        case AXSystemAuthorizerTypeAudio:
//        {
//            status = (AXSystemAuthorizerStatus)[AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
//        }
//            break;
//        default:
//        {
//            status = AXSystemAuthorizerStatusAuthorized;
//        }
//            break;
//    }
//    return status;
//}
@end
