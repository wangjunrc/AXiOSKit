//
//  AXNetManager.h
//  Xile
//
//  Created by liuweixing on 2016/10/19.
//  Copyright © 2016年 liuweixing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AXNetGroup.h"
#if __has_include("AFNetworking.h")
#import <AFNetworking/AFNetworking.h>
#endif

FOUNDATION_EXPORT NSString *const AXNetLoadTitle;
FOUNDATION_EXPORT NSString *const AXNetFailureText;

FOUNDATION_EXPORT NSString *const NetWorkStatusNotification;
FOUNDATION_EXPORT NSString *const NetWorkStatusUnknownKey;
FOUNDATION_EXPORT NSString *const NetWorkStatusNotReachableKey;
FOUNDATION_EXPORT NSString *const NetWorkStatusWANKey;
FOUNDATION_EXPORT NSString *const NetWorkStatusWiFiKey;

/**
 * 上传文件 type
 */
FOUNDATION_EXPORT NSString *const jpegMimeType;
FOUNDATION_EXPORT NSString *const gifMimeType;
FOUNDATION_EXPORT NSString *const pngMimeType;
FOUNDATION_EXPORT NSString *const icoMimeType;
FOUNDATION_EXPORT NSString *const imagMimeType;

/**
 * 请求对象
 */
static NSURLSessionDataTask *_dataTask;

/**
 * 下载保存路径,iOS只有3个位置
 */
@interface AXNetManager : NSObject
#if __has_include("AFNetworking.h")

/**
 创建请求对象

 @return 请求对象
 */
+(AFHTTPSessionManager *)shareManagerWithParameters:(id )parameters;

/**
 处理AFN 返回结果,进行判断 json xml等类型
 
 @param responseObject 数据
 @return 结果
 */
+(id)handleResponse:(id)responseObject;

/**
 *  取消当前请求
 */
+ (void)cancelAFN;

/**
 监听网络转态
 */
+(void)setupNetWorkStatus:(void(^)(AFNetworkReachabilityStatus status))block;

/**
 get请求
 
 @param url url
 @param parameter 参数
 @param success 成功
 @param failure 失败
 */
+ (void)getURL:(NSString *)url
    parameters:(id )parameter
       success:(void(^)(id json))success
       failure:(void(^)(NSError * error))failure;

/**
 post请求
 
 @param url url
 @param parameter 参数
 @param success 成功
 @param failure 失败
 */
+ (void)postURL:(NSString *)url
     parameters:(id )parameter
        success:(void(^)(id json))success
        failure:(void(^)(NSError * error))failure;

/**
 下载文件
 
 @param url url
 @param showStatus 是否控制流量时暂停下载
 @param downPath 保存地址
 @param progress 进度
 @param success 完成
 @param failure 失败 code != 200
 */
+ (void )postDownURL:(NSString *)url
          showStatus:(BOOL )showStatus
            downPath:(NSString *)downPath
            progress:(void (^)(float aProgress))progress
             success:(void(^)(NSString *filePath))success
             failure:(void(^)(NSInteger statusCode))failure;

+ (void)postGroup:(NSArray<AXNetGroup *> *)group
         complete:(void(^)(NSArray<AXNetGroupResult *> *results))complete;

#endif

@end

