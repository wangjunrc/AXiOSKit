//
//  AXNetManager.m
//  Xile
//
//  Created by liuweixing on 2016/10/19.
//  Copyright © 2016年 liuweixing. All rights reserved.
//
#if __has_include("AFNetworking.h")
#import "AXNetManager.h"
#import "AXMacros.h"

NSString *const AXNetLoadTitle = @"Loading...";
NSString *const AXNetFailureText = @"网络连接错误";

NSString *const NetWorkStatusNotification = @"NetWorkStatusNotification";
NSString *const NetWorkStatusUnknownKey = @"NetWorkStatusUnknownKey";
NSString *const NetWorkStatusNotReachableKey = @"NetWorkStatusNotReachableKey";
NSString *const NetWorkStatusWANKey = @"NetWorkStatusWANKey";
NSString *const NetWorkStatusWiFiKey = @"NetWorkStatusWiFiKey";

/**
 * 上传图片 type
 */
NSString *const jpegMimeType = @"image/jpeg";
NSString *const gifMimeType = @"image/gif";
NSString *const pngMimeType = @"image/png";
NSString *const icoMimeType = @"image/png";
NSString *const imagMimeType = @"IMAGE/PNG/JPEG/GIF/WebP";


@implementation AXNetManager


//static NSURLSessionDataTask *_dataTask;

/**
 创建请求对象
 
 @return 请求对象
 */
+(AFHTTPSessionManager *)shareManager{
    
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
 *  取消当前请求
 */
+ (void)cancelAFN{
    if (_dataTask) {
        [_dataTask cancel];
        _dataTask = nil;
    }
}


/**
 处理AFN 返回结果,进行判断 json xml等类型
 
 @param responseObject 数据
 @return 结果
 */
+(id)handleResponse:(id)responseObject{
    
    id json = nil;
    NSString *responseStr = [[responseObject class]description];
    
    if ([responseStr isEqualToString:@"_NSInlineData"]) {
        
        json  = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
    }else{
        json = responseObject;
    }
    return json;
}

/**
 监听网络转态
 */
+(void)setupNetWorkStatus:(void(^)(AFNetworkReachabilityStatus status))block{
    
    if (block) {
        //1获取网络监控管理者
        AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
        [manager startMonitoring];
        
        //2.设置网络状态发生变化时的代码
        [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            
            block(status);
            [axNotificationCenter postNotificationName:NetWorkStatusNotification object:nil userInfo:@{@"status":@(status)}];
            
        }];
    }
    
}


+ (void )postDownURL:(NSString *)url showStatus:(BOOL )showStatus downPath:(NSString *)downPath progress:(void (^)(float aProgress))progress success:(void(^)(NSString *filePath))success failure:(void(^)(NSInteger statusCode))failure{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    NSURLSessionDownloadTask *task = nil;
    axWeakObj(task);
    
    task = [manager downloadTaskWithRequest:request progress:^(NSProgress *downloadProgress) {
        
        if (progress) {
            progress(downloadProgress.fractionCompleted);
        }
        
    } destination:^NSURL * (NSURL *targetPath, NSURLResponse *response) {
        
        return [self getFileURL:downPath filename:response.suggestedFilename];
        
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError * error) {
        
        NSHTTPURLResponse *httpResp = (NSHTTPURLResponse *)response;
        
        if (httpResp.statusCode==200) {
            if (success) {
                success(filePath.path);
                [taskWeak cancel];
            }
        }else{
            if (failure) {
                failure(httpResp.statusCode);
            }
        }
    }];
    
    
    //    //保持下载进度,,,我也不知道怎么实现的~~
    //    if (progress) {
    //        //设置下载进度回调方法：
    //        [manager setDownloadTaskDidWriteDataBlock:^(NSURLSession *session, NSURLSessionDownloadTask *downloadTask, int64_t bytesWritten, int64_t totalBytesWritten, int64_t totalBytesExpectedToWrite) {
    //
    //            NSHTTPURLResponse *httpResp = (NSHTTPURLResponse *)downloadTask.response;
    //
    //            if (httpResp.statusCode==200) {
    //
    //                float pro = (CGFloat)totalBytesWritten/(CGFloat)totalBytesExpectedToWrite;
    //                progress(pro);
    //                AXLog(@"pro--> %lf", pro);
    //            }else{
    //
    //            }
    //
    //        }];
    //    }
    
    
    //判断网络,是否继续下载
    if (showStatus) {
        [self setupTask:task];
    }else{
        [task resume];
    }
    
    
}




/**
 * 拼接文件路径
 */
+(NSURL *)getFileURL:(NSString *)downPath filename:(NSString *)suggestedFilename{
    
    if(![[NSFileManager defaultManager]fileExistsAtPath:downPath]){
        [[NSFileManager defaultManager]createDirectoryAtPath:downPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    NSString *path = [downPath stringByAppendingPathComponent:suggestedFilename];
    return [NSURL fileURLWithPath:path];
}

/**
 * 监听网络请求,开始下载任务
 */
+(void)setupTask:( NSURLSessionDownloadTask *)task{
    
    [self setupNetWorkStatus:^(AFNetworkReachabilityStatus status) {
        
        switch (status) {
            case AFNetworkReachabilityStatusUnknown: // 未知网络
                break;
                
            case AFNetworkReachabilityStatusNotReachable: // 没有网络(断网)
                [task cancel];
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:{ // 手机自带网络
                UIViewController *currentViewController = AXCurrentViewController();
                [currentViewController ax_showNetDownloadGo:^{
                    [task resume];
                } cancel:^{
                    [task cancel];
                }];
            }
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi:{ // WIFI
                
                [task resume];
            }
                break;
                
            default:
                break;
        }
        
    }];
    
    //    AFNetworkReachabilityManager *reachabilityManager = [AFNetworkReachabilityManager sharedManager];
    //    [reachabilityManager startMonitoring];
    //
    //    [reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
    //        switch (status) {
    //            case AFNetworkReachabilityStatusUnknown: // 未知网络
    //                break;
    //
    //            case AFNetworkReachabilityStatusNotReachable: // 没有网络(断网)
    //                [task cancel];
    //                break;
    //
    //            case AFNetworkReachabilityStatusReachableViaWWAN:{ // 手机自带网络
    //                [AXCurrentViewController ax_showNetDownloadGo:^{
    //                    [task resume];
    //                } cancel:^{
    //                    [task cancel];
    //                }];
    //            }
    //                break;
    //
    //            case AFNetworkReachabilityStatusReachableViaWiFi:{ // WIFI
    //
    //                [task resume];
    //            }
    //                break;
    //
    //            default:
    //                break;
    //        }
    //
    //    }];
    
}


/**
 get请求
 
 @param url url
 @param parameter 参数
 @param success 成功
 @param failure 失败
 */
+ (void)getURL:(NSString *)url parameters:(NSDictionary *)parameter success:(void(^)(id json))success failure:(void(^)(NSInteger state))failure{
    
    [self cancelAFN];
    
    _dataTask = [[self shareManager] GET:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * task, id  responseObject) {
        if (success) {
            
            id obj = [self handleResponse:responseObject];
            
            success(obj);
        }
        
    } failure:^(NSURLSessionDataTask * task, NSError * error) {
        
        if (failure) {
            failure(task.state);
        }
    }];
}

/**
 post请求
 
 @param url url
 @param parameter 参数
 @param success 成功
 @param failure 失败
 */
+ (void)postURL:(NSString *)url parameters:(NSDictionary *)parameter success:(void(^)(id json))success failure:(void(^)(NSInteger state))failure{
    
    [self cancelAFN];
    
    _dataTask = [[self shareManager] POST:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * task, id  responseObject) {
        if (success) {
            
            id json = [self handleResponse:responseObject];
            success(json);
        }
        
    } failure:^(NSURLSessionDataTask * task, NSError * error) {
        if (failure) {
            failure(task.state);
        }
    }];
}


dispatch_group_t _group;

+ (void)postGroup:(NSArray<AXNetGroup *> *)group complete:(void(^)(NSArray<AXNetGroupResult *> *results))complete{
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
    
    
    NSMutableArray *results = [NSMutableArray arrayWithCapacity:group.count];
    
    for (int index=0; index<group.count; index++) {
        [results addObject:[AXNetGroupResult new]];
    }
    
    
    //    dispatch_async(queue, ^{
    
    _group = dispatch_group_create();
    
    for (int index=0; index<group.count; index++) {
        
        dispatch_group_enter(_group);
        dispatch_group_async(_group, queue, ^{
            
            
            AXNetGroup *model  = group[index];
            
            [self postURL:model.url parameters:model.parameter success:^(id json) {
                
                AXNetGroupResult *result = results[index];
                result.success = YES;
                result.json = json;
                
                dispatch_group_leave(_group);
                
            } failure:^(NSInteger state) {
                
                AXNetGroupResult *result = results[index];
                result.success = NO;
                result.state = state;
                
                dispatch_group_leave(_group);
                
            }];
            
        });
    }
    
    //因上面请求中有加入dispatch_group_enter 和 dispatch_group_leave,所以真正等待上面线程执行完才执行这里面的请求
    dispatch_group_notify(_group, dispatch_get_main_queue(), ^{
        if (complete) {
            complete(results);
        }
    });
    //    });
    
    
}

@end
#endif
