//
//  AXNetManager+Upload.h
//  BigApple
//
//  Created by liuweixing on 2017/6/9.
//  Copyright © 2017年 liuweixing. All rights reserved.
//

#import "AXNetManager.h"
#import <UIKit/UIImage.h>
@class UIImage;
/**
 *  用来封装文件数据的模型 上传文件时
 */
@interface AXFormData : NSObject
/**
 *  文件数据
 */
@property (nonatomic, strong, readonly) NSData *data;

@property (nonatomic, strong, readonly) UIImage *image;

/**
 *  参数名
 */
@property (nonatomic, copy, readonly) NSString *name;

/**
 *  文件名
 */
@property (nonatomic, copy, readonly) NSString *filename;

/**
 *  文件类型
 */
@property (nonatomic, copy, readonly) NSString *mimeType;

+ (instancetype)formDataWithImage:(UIImage *)image name:(NSString *)name;

+ (instancetype)formDataWithData:(NSData *)imageData name:(NSString *)name;

@end



@interface AXNetManager (Upload)

#if __has_include("AFNetworking.h")
    
/**
 上传多个文件,含有hud

 @param url url
 @param parameters 参数
 @param formDataArray 文件参数
 @param progress 进度
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)POSTUpLoadWithURL:(NSString *)url parameters:(id )parameters formDataArray:(NSArray<AXFormData *> *)formDataArray progress:(void (^)(NSProgress *aProgress ))progress success:(void (^)(id json))success failure:(void (^)(NSString *errorString))failure;


/**
 * 上传单个Jpeg图片
 */
+ (void)uploadJpegWithURL:(NSString *)url parameters:(id )parameters image:(UIImage* )image name:(NSString *)name success:(void(^)(id json))success failure:(void(^)(NSString *errorString))failure;

#endif
@end
