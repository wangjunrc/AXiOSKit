//
//  AXNetManager+Upload.m
//  BigApple
//
//  Created by liuweixing on 2017/6/9.
//  Copyright © 2017年 liuweixing. All rights reserved.
//

#import "AXNetManager+Upload.h"
#import <AFNetworking/AFNetworking.h>
#import "AXMacros.h"
#import "NSString+AXKit.h"
#import "NSData+AXKit.h"
#import "NSObject+AXLoger.h"
@import UIKit;
#pragma mark - NetFormData
@interface AXFormData ()

@property (nonatomic, strong, readwrite) NSData *data;
@property (nonatomic, strong, readwrite) UIImage *image;
@property (nonatomic, copy, readwrite) NSString *name;
@property (nonatomic, copy, readwrite) NSString *filename;
@property (nonatomic, copy, readwrite) NSString *mimeType;

@end

@implementation  AXFormData

+ (instancetype)formDataWithData:(NSData *)data name:(NSString *)name filename:(NSString *)filename mimeType:(NSString *)mimeType{
    AXFormData *file = [[self alloc]init];
    file.data = data;
    file.name = name;
    file.filename = filename;
    file.mimeType = mimeType;
    return file;
}

+ (instancetype)formDataWithImage:(UIImage *)image name:(NSString *)name {
    return [self formDataWithData:image name:name];
}

+ (instancetype)formDataWithData:(NSData *)imageData name:(NSString *)name {
    
    AXFormData *form = [[self alloc]init];
    NSString *mimeType = imageData.ax_mimeType;
    NSString *suffix = [mimeType componentsSeparatedByString:@"/"].lastObject;
    NSString *fileName = [NSString stringWithFormat:@"%@.%@",NSString.ax_uuid,suffix];
    
    form.data = imageData;
    form.name = name;
    form.filename = fileName;
    form.mimeType = mimeType;
    return form;
}

@end

@implementation AXNetManager (Upload)

#pragma mark - 上传多个文件

/**
 上传多个文件
 
 @param url           url
 @param parameters        参数
 @param formDataArray 文件参数
 @param success       成功回调
 @param progress      进度回调
 @param failure       失败回调
 */
+ (void)POSTUpLoadWithURL:(NSString *)url parameters:(id )parameters formDataArray:(NSArray<AXFormData *> *)formDataArray progress:(void (^)(NSProgress *aProgress))progress success:(void (^)(id json))success failure:(void (^)(NSString *errorString))failure{
    
    AXLog(@"%@ -- %@",url,parameters);
    
    [[self shareManagerWithParameters:parameters] POST:url parameters:parameters headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  formData) {
        
        for (AXFormData *file in formDataArray) {
            
            [formData appendPartWithFileData:file.data name:file.name fileName:file.filename mimeType:file.mimeType];
        }
        NSLog(@"formData = %@",formData);
        
    } progress:^(NSProgress * uploadProgress) {
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * task, id  responseObject) {
        
        if (success) {
            success([self handleResponse:responseObject]);
        }
        
    } failure:^(NSURLSessionDataTask * task, NSError * error) {
        NSLog(@"error = %@",error);
        
        if (failure) {
            failure(error.localizedDescription);
        }
    }];
}


#pragma mark - 上传单个Jpeg图片
/**
 * 上传单个Jpeg图片
 */
+ (void)uploadJpegWithURL:(NSString *)url parameters:(id )parameters image:(UIImage* )image name:(NSString *)name success:(void(^)(id json))success failure:(void(^)(NSString *errorString))failure{
    
    AXFormData *formData = [AXFormData formDataWithImage:image name:name];
    [self POSTUpLoadWithURL:url parameters:parameters formDataArray:@[formData] progress:nil success:success failure:failure];
}

+ (void)POSTUpLoadWithURL:(NSString *)url
               parameters:(id )parameters
               imageArray:(NSArray<UIImage *> *)imageArray
                 progress:(void (^)(NSProgress *aProgress))progress
                  success:(void (^)(id json))success
                  failure:(void (^)(NSString *errorString))failure {
    
    AXLog(@"%@ -- %@",url,parameters);
    
    [[self shareManagerWithParameters:parameters] POST:url parameters:parameters headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  formData) {
        
        for (UIImage *image in imageArray) {
            
            NSData *imageData = UIImageJPEGRepresentation(image, 1);
            NSString *imageFormat = imageData.ax_mimeType;
            NSString *suffix = [imageFormat componentsSeparatedByString:@"/"].lastObject;
            NSString *fileName =[NSString stringWithFormat:@"%@.%@",NSString.ax_uuid,suffix];
            
            [formData appendPartWithFileData:imageData name:fileName fileName:fileName mimeType:imageFormat];
        }
        NSLog(@"formData = %@",formData);
        
    } progress:^(NSProgress * uploadProgress) {
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * task, id  responseObject) {
        
        if (success) {
            success([self handleResponse:responseObject]);
        }
        
    } failure:^(NSURLSessionDataTask * task, NSError * error) {
        NSLog(@"error = %@",error);
        
        if (failure) {
            failure(error.localizedDescription);
        }
    }];
}


@end

