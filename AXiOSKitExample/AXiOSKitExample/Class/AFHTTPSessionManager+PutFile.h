//
//  AFHTTPSessionManager+PutFile.h
//  AXiOSKitExample
//
//  Created by 小星星吃KFC on 2020/7/16.
//  Copyright © 2020 liuweixing. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

NS_ASSUME_NONNULL_BEGIN

@interface AFHTTPSessionManager (PutFile)
- (NSURLSessionDataTask *)PUT:(NSString *)URLString
                   parameters:(nullable id)parameters
                      headers:(nullable NSDictionary<NSString *,NSString *> *)headers
    constructingBodyWithBlock:(nullable void (^)(id<AFMultipartFormData> _Nonnull))block
                     progress:(nullable void (^)(NSProgress * _Nonnull))uploadProgress
                      success:(nullable void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success
                      failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure;
@end

NS_ASSUME_NONNULL_END
