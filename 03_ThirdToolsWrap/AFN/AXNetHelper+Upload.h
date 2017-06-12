//
//  AXNetHelper+Upload.h
//  BigApple
//
//  Created by Mole Developer on 2017/6/9.
//  Copyright © 2017年 MoleDeveloper. All rights reserved.
//

#import "AXNetHelper.h"

/**
 *  用来封装文件数据的模型 上传文件时
 */
@interface AXFormData : NSObject
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

+(instancetype )formDataWithData:(NSData *)data name:(NSString *)name filename:(NSString *)filename mimeType:(NSString *)mimeType;

@end



@interface AXNetHelper (Upload)

/**
 上传多个文件,含有hud
 
 @param url           url
 @param params        参数
 @param formDataArray 文件参数
 @param success       成功回调
 @param progress      进度回调
 @param failure       失败回调
 */
+ (void)POSTUpLoadWithURL:(NSString *)url showHud:(BOOL )showHud parameters:(NSDictionary *)parameters formDataArray:(NSArray<AXFormData *> *)formDataArray progress:(void (^)(NSProgress *aProgress ))progress success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;


/**
 * 上传单个Jpeg图片
 */
+ (void)uploadJpegWithURL:(NSString *)url showHud:(BOOL )showHud parameters:(NSDictionary *)parameters image:(UIImage* )image success:(void(^)(id json))success failure:(void(^)(NSError *error))failure;


@end
