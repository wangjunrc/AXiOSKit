//
//  AXNetHelper.h
//  Xile
//
//  Created by Mole Developer on 2016/10/19.
//  Copyright © 2016年 MoleDeveloper. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#define HNetLoadTitle @"Loading..."
#define HNetTimeoutTitle  @"网络连接超时"

extern NSString *const NetLoadTitle;

extern NSString *const NetErrorTitle;

extern NSString *const NetWorkStatusNotification;

extern NSString *const NetWorkStatusUnknownKey;
extern NSString *const NetWorkStatusNotReachableKey;
extern NSString *const NetWorkStatusWANKey;
extern NSString *const NetWorkStatusWiFiKey;



typedef NS_ENUM(NSInteger, NetWorkStatus) {
    NetWorkStatusUnknown = -1,
    NetWorkStatusNotReachable  = 0,
    NetWorkStatusWAN = 1,
    NetWorkStatusWiFi = 2,
};

typedef NS_ENUM(NSUInteger,MyDirectory) {
    MyDirectoryDocument = 1, //  对应 NSDocumentDirectory
    MyDirectoryLibrary,      // 对应 NSLibraryDirectory
    MyDirectoryTemporary,   // 对应 NSTemporaryDirectory
};

@class NetFormData;
/**
 * 下载保存路径,iOS只有3个位置
 */
@interface AXNetHelper : NSObject

/**
 * GET请求
 */
+ (void)GETWithUrl:(NSString *)url parameters:(NSDictionary *)paramas success:(void(^)(id json))success failure:(void(^)(id error))failure;

/**
 * post请求
 */
+ (void)POSTWithUrl:(NSString *)url parameters:(NSDictionary *)paramas success:(void(^)(id json))success failure:(void(^)(id error))failure;


/**
 * POST 上传文件
 */
+ (void)POSTUpLoadWithURL:(NSString *)url parameters:(NSDictionary *)parameters data:(NSData* )data name:(NSString *)name  fileName:(NSString*)fileName  mimeType:(NSString *)mimeType progress:( void (^)(NSProgress *progress)) progress success:(void(^)(id json))success failure:(void(^)(id error))failure;

/**
 * POST 下载文件
 */
+ (void)POSTDownloadWithUrl:(NSString *)url downPath:(NSString *)downPath progress:(void (^)(NSProgress *progress))progress completion:(void(^)(NSString *filePath))completion;


/**
 上传文件
 
 @param url           url
 @param params        参数
 @param formDataArray 文件参数
 @param success       成功回调
 @param progress      进度回调
 @param failure       失败回调
 */
+ (void)POSTUpLoadWithURL:(NSString *)url params:(NSDictionary *)params formDataArray:(NSArray<NetFormData *> *)formDataArray success:(void (^)(id json))success progress:(void (^)(NSProgress * ))progress failure:(void (^)(NSError *error))failure;



/**
 监听网络转态
 */
+(void)setupNetWorkStatus:(void(^)(NetWorkStatus status))block;

@end


//#pragma mark - @interface NetOne
///**
// * 单例 确保用一个请求
// */
//@interface NetOnly : AFHTTPSessionManager
//
//+(instancetype )shareInstace;
//
//@end



#pragma mark - @interface NetFormData
/**
 *  用来封装文件数据的模型 上传文件时
 */
@interface NetFile : NSObject
/**
 *  文件数据
 */
@property (nonatomic, strong) NSData *data;

/**
 *  参数名
 */
@property (nonatomic, copy) NSString *name;

/**
 *  文件名
 */
@property (nonatomic, copy) NSString *filename;

/**
 *  文件类型
 */
@property (nonatomic, copy) NSString *mimeType;

+(instancetype )netFileWithData:(NSData *)data name:(NSString *)name filename:(NSString *)filename mimeType:(NSString *)mimeType;
@end
