//
//  AXNetHelper.m
//  Xile
//
//  Created by Mole Developer on 2016/10/19.
//  Copyright © 2016年 MoleDeveloper. All rights reserved.
//

NSString *const NetLoadTitle = @"Loading...";

NSString *const NetErrorTitle = @"网络连接错误";

NSString *const NetWorkStatusNotification = @"NetWorkStatusNotification";

NSString *const NetWorkStatusUnknownKey = @"NetWorkStatusUnknownKey";
NSString *const NetWorkStatusNotReachableKey = @"NetWorkStatusNotReachableKey";
NSString *const NetWorkStatusWANKey = @"NetWorkStatusWANKey";
NSString *const NetWorkStatusWiFiKey = @"NetWorkStatusWiFiKey";


#import "AXNetHelper.h"

@implementation AXNetHelper

//static NSURLSessionDataTask *_dataTask;
///**
// *  取消当前请求
// */
//+ (void)cancelCurrentRequest{
//    if (_dataTask) {
//        [_dataTask cancel];
//        _dataTask = nil;
//    }
//}

+(AFHTTPSessionManager *)setupAFHTTPSessionManager{

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 20;
    
//    //https请求使用
//    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"https" ofType:@"cer"];
//    NSData * certData =[NSData dataWithContentsOfFile:cerPath];
//    NSSet * certSet = [[NSSet alloc] initWithObjects:certData, nil];
//    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
//    // 是否允许,NO-- 不允许无效的证书
//    [securityPolicy setAllowInvalidCertificates:YES];
//    // 设置证书
//    [securityPolicy setPinnedCertificates:certSet];
//    manager.securityPolicy = securityPolicy;
    return manager;
    
}


/**
 *GET请求
 */
+ (void)GETWithUrl:(NSString *)url parameters:(NSDictionary *)paramas success:(void(^)(id json))success failure:(void(^)(id error))failure{
    
    [[self setupAFHTTPSessionManager] GET:url parameters:paramas progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
            success(json);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {
            failure(error);
        }
    }];
}


/**
 * 发送一个POST请求
 */
+ (void)POSTWithUrl:(NSString *)url parameters:(NSDictionary *)paramas  success:(void(^)(id json))success failure:(void(^)(id error))failure{
    
   
    
     [[self setupAFHTTPSessionManager] POST:url parameters:paramas progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        MyLog(@"POSTUrl--> %@",task.currentRequest.URL.absoluteString);
        if (success) {
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
            success(json);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {
            failure(error);
        }
    }];
}


/**
 * 上传文件
 */
+ (void)POSTUpLoadWithURL:(NSString *)url parameters:(NSDictionary *)parameters data:(NSData* )data name:(NSString *)name  fileName:(NSString*)fileName  mimeType:(NSString *)mimeType progress:( void (^)(NSProgress *progress)) progress success:(void(^)(id json))success failure:(void(^)(id error))failure{
    
    
    [[self setupAFHTTPSessionManager] POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [formData appendPartWithFileData:data name:name fileName:fileName mimeType:mimeType];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        MyLog(@"POSTUrl--> %@",task.currentRequest.URL);
        if (success) {
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
            success(json);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {
            failure(error);
        }
    }];
}


/**
 * 下载文件
 */
+ (void)POSTDownloadWithUrl:(NSString *)url downPath:(NSString *)downPath progress:(void (^)(NSProgress *progress))progress completion:(void(^)(NSString *filePath))completion{
    //    MyLog(@"下载文件保存位置--> %@",downPath);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    NSURLSessionDownloadTask *downloadTask =[manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        
        if (progress) {
            progress(downloadProgress);
        }
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        if(![[NSFileManager defaultManager]fileExistsAtPath:downPath]){
            [[NSFileManager defaultManager]createDirectoryAtPath:downPath withIntermediateDirectories:YES attributes:nil error:nil];
        }
        
        NSString *path = [downPath stringByAppendingPathComponent:response.suggestedFilename];
        
        
        return [NSURL fileURLWithPath:path];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        //        MyLog(@"下载文件结果--> response:%@--filePath:%@",response,filePath);
        if (completion) {
            completion(filePath.path);
        }
    }];
    [downloadTask resume];
    //suspend  暂停
}


/**
 上传文件
 
 @param url           url
 @param params        参数
 @param formDataArray 文件参数
 @param success       成功回调
 @param progress      进度回调
 @param failure       失败回调
 */
+ (void)POSTUpLoadWithURL:(NSString *)url params:(NSDictionary *)params formDataArray:(NSArray<NetFormData *> *)formDataArray success:(void (^)(id json))success progress:(void (^)(NSProgress * ))progress failure:(void (^)(NSError *error))failure{
    
    [[self setupAFHTTPSessionManager] POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        for (NetFile *file in formDataArray) {
            [formData appendPartWithFileData:file.data name:file.name fileName:file.filename mimeType:file.mimeType];
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {
            id json = nil;
            NSString *responseStr = [NSString stringWithFormat:@"%@",[responseObject class]];
            if ([responseStr isEqualToString:@"_NSInlineData"]) {
                json  = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
            }else{
                json = responseObject;
            }
            success(json);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}


///**
// * 下载文件,含有网络转态
// */
////static NSNumber *_user4G;
//+ (AFHTTPSessionManager *)POSTDownloadWithUrl:(NSString *)url downPath:(NSString *)downPath netState:(void(^)(NetWorkStatus  WorkStatus,NSURLSessionDownloadTask *downloadTask))netState  progress:(void (^)(NSProgress *progress))progress completion:(void(^)(NSString *filePath))completion{
//    
//    AFNetworkReachabilityManager  *reachabilityManager = [AFNetworkReachabilityManager sharedManager];
//    //3.启动监控
//    [reachabilityManager startMonitoring];
//
//    
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
//    
//    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
//        
//        if (progress) {
//            progress(downloadProgress);
//        }
//        
//    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
//        if(![[NSFileManager defaultManager]fileExistsAtPath:downPath]){
//            [[NSFileManager defaultManager]createDirectoryAtPath:downPath withIntermediateDirectories:YES attributes:nil error:nil];
//        }
//        
//        NSString *path = [downPath stringByAppendingPathComponent:response.suggestedFilename];
//        
//        
//        return [NSURL fileURLWithPath:path];
//        
//    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
//        //        MyLog(@"下载文件结果--> response:%@--filePath:%@",response,filePath);
//        if (completion) {
//            completion(filePath.path);
//        }
//    }];
//    
//    [reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
//        switch (status) {
//            case AFNetworkReachabilityStatusUnknown: // 未知网络
//                
//                
//                break;
//                
//            case AFNetworkReachabilityStatusNotReachable: // 没有网络(断网)
//                
//                
//                break;
//                
//            case AFNetworkReachabilityStatusReachableViaWWAN: // 手机自带网络
//                
////                if (_user4G.boolValue==NO) {
////                    [downloadTask suspend];
////                }
//                
//                if (netState) {
//                    netState(NetWorkStatusWAN,downloadTask);
//                }
//                
//                break;
//                
//            case AFNetworkReachabilityStatusReachableViaWiFi:{ // WIFI
//               
//                [downloadTask resume];
//            }
//                break;
//                
//            default:
//                MyLog(@"无网络");
//                break;
//        }
//    }];
//    
//    return manager;
//}

//+ (NSURLSessionDownloadTask *)setupDownloadWithUrl:(NSString *)url downPath:(NSString *)downPath progress:(void (^)(NSProgress *progress))progress completion:(void(^)(NSString *filePath))completion{
//
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
//    
//    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
//        
//        if (progress) {
//            progress(downloadProgress);
//        }
//        
//    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
//        if(![[NSFileManager defaultManager]fileExistsAtPath:downPath]){
//            [[NSFileManager defaultManager]createDirectoryAtPath:downPath withIntermediateDirectories:YES attributes:nil error:nil];
//        }
//        
//        NSString *path = [downPath stringByAppendingPathComponent:response.suggestedFilename];
//        
//        
//        return [NSURL fileURLWithPath:path];
//        
//    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
//        //        MyLog(@"下载文件结果--> response:%@--filePath:%@",response,filePath);
//        if (completion) {
//            completion(filePath.path);
//        }
//    }];
//    
//    return downloadTask;
//}





/**
 监听网络转态
 */
+(void)setupNetWorkStatus:(void(^)(NetWorkStatus status))block{
    if (block) {
        //1获取网络监控管理者
        AFNetworkReachabilityManager  *manager = [AFNetworkReachabilityManager sharedManager];
        
        //2.设置网络状态发生变化时的代码
        [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            switch (status) {
                case AFNetworkReachabilityStatusUnknown: // 未知网络
                    block(NetWorkStatusUnknown);
                    [axNotificationCenter postNotificationName:NetWorkStatusNotification object:nil userInfo:@{@"status":@"Unknown"}];
                    break;
                    
                case AFNetworkReachabilityStatusNotReachable: // 没有网络(断网)
                    block(NetWorkStatusNotReachable);
                     [axNotificationCenter postNotificationName:NetWorkStatusNotification object:nil userInfo:@{@"status":@"NotReachable"}];
                    break;
                    
                case AFNetworkReachabilityStatusReachableViaWWAN: // 手机自带网络
                    block(NetWorkStatusWAN);
                    [axNotificationCenter postNotificationName:NetWorkStatusNotification object:nil userInfo:@{@"status":@"WAN"}];
                    break;
                    
                case AFNetworkReachabilityStatusReachableViaWiFi: // WIFI
                    block(NetWorkStatusWiFi);
                    [axNotificationCenter postNotificationName:NetWorkStatusNotification object:nil userInfo:@{@"status":@"WiFi"}];
                    break;
                    
                default:
                    MyLog(@"无网络");
                    break;
            }
        }];
        //3.启动监控
        [manager startMonitoring];
    }
    
    //监控耗电,需要停止
    //    [manager stopMonitoring];
    //4.判断是什么网络
    //    [manager isReachable]; //是否有网
    //    [manager isReachableViaWiFi]; //是否有WiFi
    //    [manager isReachableViaWWAN]; //是否是蜂窝网络
}

@end




//#pragma mark - @implementation NetOnly
//@implementation NetOnly
//
//static id  _instace;
//
//+(instancetype )shareInstace{
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        NetOnly *manager = [self manager];
//        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//        manager.requestSerializer.timeoutInterval = 20;
//        
//        //https请求使用
//        NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"https" ofType:@"cer"];
//        NSData * certData =[NSData dataWithContentsOfFile:cerPath];
//        NSSet * certSet = [[NSSet alloc] initWithObjects:certData, nil];
//        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
//        // 是否允许,NO-- 不允许无效的证书
//        [securityPolicy setAllowInvalidCertificates:YES];
//        // 设置证书
//        [securityPolicy setPinnedCertificates:certSet];
//        manager.securityPolicy = securityPolicy;
//        _instace = manager;
//    });
//    return _instace;
//}
//
//@end

#pragma mark - @implementation NetFormData
@implementation  NetFile

+ (instancetype)netFileWithData:(NSData *)data name:(NSString *)name filename:(NSString *)filename mimeType:(NSString *)mimeType{
    NetFile *file =[[self alloc]init];
    file.data = data;
    file.name = name;
    file.filename = filename;
    file.mimeType = mimeType;
    return file;
}

@end


