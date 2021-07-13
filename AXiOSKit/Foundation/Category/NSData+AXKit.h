//
//  NSData+AXKit.h
//  AXiOSKit
//
//  Created by liuweixing on 16/8/10.
//  Copyright © 2016年 liuweixing All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
@interface NSData (AXKit)

/**
 * NSData 进行 Base64
 */
- (NSString *)ax_toBase64;

/**
 * 二进制转化为十六进制
 */
- (NSString *)ax_dataToHexString;

/**
 * NSData 转化 NSString
 */
- (NSString *)ax_toString;

/// NSData 转化 json,或者string
- (id )ax_toJson;

/**
 NSBundle 文件转data
 
 @param resource 文件名,带后缀
 @return NSData
 */
+(NSData *)ax_dataWithMainBundleResource:(NSString *)resource;

/// 保存data 到相册
/// 本地或者网络图片,转成data保存
/// @param completionHandler 回调
- (void)ax_savePhotoLibraryHandler:(nullable void (^)(BOOL success, NSError *__nullable error))completionHandler;


/// data image 类型
@property(nonatomic, copy, readonly)NSString *ax_mimeType;

/// NSBundle 工程文件获得data
/// @param name 文件名
/// @param ext 拓展
+(instancetype )ax_mainBundleDataName:(NSString *)name
                       extension:(NSString *)ext;


/// NSBundle 工程文件获得data
/// @param name 文件名
+(instancetype )ax_mainBundleDataName:(NSString *)name;

@end
NS_ASSUME_NONNULL_END
