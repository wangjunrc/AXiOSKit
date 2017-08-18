//
//  AXNetHelper+Upload.m
//  BigApple
//
//  Created by Mole Developer on 2017/6/9.
//  Copyright © 2017年 MoleDeveloper. All rights reserved.
//

#import "AXNetHelper+Upload.h"


#pragma mark - NetFormData
@implementation  AXFormData

+ (instancetype)formDataWithData:(NSData *)data name:(NSString *)name filename:(NSString *)filename mimeType:(NSString *)mimeType{
    AXFormData *file =[[self alloc]init];
    file.data = data;
    file.name = name;
    file.filename = filename;
    file.mimeType = mimeType;
    return file;
}

@end

@implementation AXNetHelper (Upload)

#pragma mark - 上传多个文件

/**
 上传多个文件,含有hud
 
 @param url url
 @param showHud hud
 @param parameters 参数
 @param formDataArray 文件内容
 @param progress 进度回调
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)POSTUpLoadWithURL:(NSString *)url showHud:(BOOL )showHud parameters:(NSDictionary *)parameters formDataArray:(NSArray<AXFormData *> *)formDataArray progress:(void (^)(NSProgress *aProgress))progress success:(void (^)(id json))success failure:(void (^)(NSString *errorString))failure{
   
    
    MBProgressHUD *hud = nil;
    if (showHud) {
        hud = [MBProgressHUD showMessage:AXNetLoadTitle];
    }
    
    [[self createSessionManager] POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  formData) {
        
        if (showHud) {
            [hud hideAnimated:YES];
        }
        
        for (AXFormData *file in formDataArray) {
            
            [formData appendPartWithFileData:file.data name:file.name fileName:file.filename mimeType:file.mimeType];
        }
        
    } progress:^(NSProgress * uploadProgress) {
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * task, id  responseObject) {
        
        if (success) {
            success([self handleResponse:responseObject]);
        }
        
    } failure:^(NSURLSessionDataTask * task, NSError * error) {
        
        if (showHud) {
            [hud hideAnimated:YES];
            [MBProgressHUD showError:error.localizedDescription];
        }
        
        if (failure) {
            NSLog(@"%@",error);
            failure(error.localizedDescription);
        }
    }];
}


#pragma mark - 上传单个Jpeg图片
/**
 * 上传单个Jpeg图片
 */
+ (void)uploadJpegWithURL:(NSString *)url showHud:(BOOL )showHud parameters:(NSDictionary *)parameters image:(UIImage* )image success:(void(^)(id json))success failure:(void(^)(NSString *errorString))failure{
    
    NSData *imageData = UIImageJPEGRepresentation(image, 1);
    
    NSString *name = [NSString ax_uuid];
    NSString *fileName =[NSString stringWithFormat:@"%@.jpeg",name];
    
    AXFormData *formData = [AXFormData formDataWithData:imageData name:name filename:fileName mimeType:jpegMimeType];
    
    [self POSTUpLoadWithURL:url showHud:showHud parameters:parameters formDataArray:@[formData] progress:nil success:success failure:failure];
}

/**
 上传多个文件,
 
 @param url url
 @param parameters 参数
 @param formDataArray 文件内容
 @param progress 进度回调
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)POSTUpLoadWithURL:(NSString *)url parameters:(NSDictionary *)parameters formDataArray:(NSArray<AXFormData *> *)formDataArray progress:(void (^)(NSProgress *aProgress ))progress success:(void (^)(id json))success failure:(void (^)(NSString *errorString))failure{
    
    [self POSTUpLoadWithURL:url showHud:NO parameters:parameters formDataArray:formDataArray progress:progress success:success failure:failure];

}


/**
 * 上传单个Jpeg图片
 */
+ (void)uploadJpegWithURL:(NSString *)url parameters:(NSDictionary *)parameters image:(UIImage* )image success:(void(^)(id json))success failure:(void(^)(NSString *errorString))failure{

    [self uploadJpegWithURL:url showHud:NO parameters:parameters image:image success:success failure:failure];
    
}

@end
