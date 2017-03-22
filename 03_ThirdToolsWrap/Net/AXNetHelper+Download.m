//
//  AXNetHelper+Download.m
//  BigApple
//
//  Created by Mole Developer on 2016/11/22.
//  Copyright © 2016年 MoleDeveloper. All rights reserved.
//

#import "AXNetHelper+Download.h"

@implementation AXNetHelper (Download)
/**
 * 下载文件,含有网络转态
 */
+ (void )POSTDownloadWithUrl:(NSString *)url downPath:(NSString *)downPath netState:(void(^)(NetWorkStatus  WorkStatus,NSURLSessionDownloadTask *downloadTask))netState  progress:(void (^)(NSProgress *progress))progress completion:(void(^)(NSString *filePath))completion saveState:(void(^)( float downloadProgress))saveState{
    
    AFNetworkReachabilityManager  *reachabilityManager = [AFNetworkReachabilityManager sharedManager];
    //3.启动监控
    [reachabilityManager startMonitoring];

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        
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
    
    
    [reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown: // 未知网络
                
                
                break;
                
            case AFNetworkReachabilityStatusNotReachable: // 没有网络(断网)
                
                
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN: // 手机自带网络
                
                //                if (_user4G.boolValue==NO) {
                //                    [downloadTask suspend];
                //                }
                
                if (netState) {
                    netState(NetWorkStatusWAN,downloadTask);
                }
                
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi:{ // WIFI
                
                [downloadTask resume];
            }
                break;
                
            default:
                MyLog(@"无网络");
                break;
        }
    }];
    
    
    if (saveState) {
        //保持下载进度,,,我也不知道怎么实现的~~
        [manager setDownloadTaskDidWriteDataBlock:^(NSURLSession *session, NSURLSessionDownloadTask *downloadTask, int64_t bytesWritten, int64_t totalBytesWritten, int64_t totalBytesExpectedToWrite) {
            
            float downloadProgress = (CGFloat)totalBytesWritten/(CGFloat)totalBytesExpectedToWrite;
            saveState(downloadProgress);
            
        }];
    }
    

}


@end
