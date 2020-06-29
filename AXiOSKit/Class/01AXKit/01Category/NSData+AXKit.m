//
//  NSData+AXKit.m
//  AXiOSKit
//
//  Created by liuweixing on 16/8/10.
//  Copyright © 2016年 liuweixing All rights reserved.
//

#import "NSData+AXKit.h"
#import <Photos/Photos.h>
@implementation NSData (AXKit)
/**
 * NSData 进行 Base64
 */
- (NSString *)ax_toBase64 {
    return [self base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
}

//二进制转化为十六进制
- (NSString *)ax_dataToHexString {
    NSData *data = self;
    if (data == nil) {
        return nil;
    }

    NSMutableString *hexString = [NSMutableString string];
    const unsigned char *p = [data bytes];
    for (int i = 0; i < [data length]; i++) {
        [hexString appendFormat:@"%02x", *p++];
    }

    return [hexString uppercaseString];
}

/**
 * NSData 转化 NSString
 */
- (NSString *)ax_toString {
    return [[NSString alloc] initWithData:self encoding:NSUTF8StringEncoding];
}

/**
 NSBundle 文件转data

 @param resource 文件名,带后缀
 @return NSData
 */
+ (NSData *)ax_dataWithMainBundleResource:(NSString *)resource {
    NSString *file = [NSBundle.mainBundle pathForResource:resource ofType:nil];
    return [NSData dataWithContentsOfFile:file];
}

/// 保存data 到相册
/// 本地或者网络图片,转成data保存
/// @param completionHandler 回调
- (void)ax_savePhotoLibraryHandler:(nullable void (^)(BOOL success, NSError *__nullable error))completionHandler {
    // 获取当前App的相册授权状态
    PHAuthorizationStatus authorizationStatus = [PHPhotoLibrary authorizationStatus];
    // 判断授权状态
    if (authorizationStatus == PHAuthorizationStatusAuthorized) {
        // 如果已经授权, 保存图片
        [self ax_toPhotoLibraryHandler:completionHandler];
    }
    // 如果没决定, 弹出指示框, 让用户选择
    else if (authorizationStatus == PHAuthorizationStatusNotDetermined) {
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            // 如果用户选择授权, 则保存图片
            if (status == PHAuthorizationStatusAuthorized) {
                [self ax_toPhotoLibraryHandler:completionHandler];
            }
        }];
    } else {
        // 前往设置
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        [[UIApplication sharedApplication] openURL:url];
    }
}

- (void)ax_toPhotoLibraryHandler:(void (^)(BOOL, NSError *_Nullable))completionHandler {
    NSData *data = self;
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        PHAssetResourceCreationOptions *options = [[PHAssetResourceCreationOptions alloc] init];
        [[PHAssetCreationRequest creationRequestForAsset] addResourceWithType:PHAssetResourceTypePhoto data:data options:options];
    } completionHandler:completionHandler];
}

@end
