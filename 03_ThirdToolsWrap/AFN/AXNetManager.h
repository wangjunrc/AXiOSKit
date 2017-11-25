//
//  AXNetManager.h
//  Xile
//
//  Created by Mole Developer on 2016/10/19.
//  Copyright © 2016年 MoleDeveloper. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

extern NSString *const AXNetLoadTitle;
//extern NSString *const AXNetErrorTitle;
//extern NSString *const AXNetFailureText;

extern NSString *const NetWorkStatusNotification;
extern NSString *const NetWorkStatusUnknownKey;
extern NSString *const NetWorkStatusNotReachableKey;
extern NSString *const NetWorkStatusWANKey;
extern NSString *const NetWorkStatusWiFiKey;

/**
 * 上传文件 type
 */
extern NSString *const jpegMimeType;
extern NSString *const gifMimeType;
extern NSString *const pngMimeType;
extern NSString *const icoMimeType;


/**
 * 请求对象
 */
static NSURLSessionDataTask *_dataTask;

/**
 * 下载保存路径,iOS只有3个位置
 */
@interface AXNetManager : NSObject

/**
 创建请求对象

 @return 请求对象
 */
+(AFHTTPSessionManager *)shareManager;

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

@end

