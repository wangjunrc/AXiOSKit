//
//  AFHTTPSessionManager+PutFile.m
//  AXiOSKitExample
//
//  Created by 小星星吃KFC on 2020/7/16.
//  Copyright © 2020 liuweixing. All rights reserved.
//

#import "AFHTTPSessionManager+PutFile.h"

@implementation AFHTTPSessionManager (PutFile)

- (NSURLSessionDataTask *)PUT:(NSString *)URLString
                   parameters:(nullable id)parameters
                      headers:(nullable NSDictionary<NSString *,NSString *> *)headers
    constructingBodyWithBlock:(nullable void (^)(id<AFMultipartFormData> _Nonnull))block
                     progress:(nullable void (^)(NSProgress * _Nonnull))uploadProgress
                      success:(nullable void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success
                      failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure
{
    NSError *serializationError = nil;
    NSMutableURLRequest *request = [self.requestSerializer multipartFormRequestWithMethod:@"PUT" URLString:[[NSURL URLWithString:URLString relativeToURL:self.baseURL] absoluteString] parameters:parameters constructingBodyWithBlock:block error:&serializationError];
    for (NSString *headerField in headers.keyEnumerator) {
        [request setValue:headers[headerField] forHTTPHeaderField:headerField];
    }
    if (serializationError) {
        if (failure) {
            dispatch_async(self.completionQueue ?: dispatch_get_main_queue(), ^{
                failure(nil, serializationError);
            });
        }
        
        return nil;
    }
    
    __block NSURLSessionDataTask *task = [self uploadTaskWithStreamedRequest:request progress:uploadProgress completionHandler:^(NSURLResponse * __unused response, id responseObject, NSError *error) {
        if (error) {
            if (failure) {
                failure(task, error);
            }
        } else {
            if (success) {
                success(task, responseObject);
            }
        }
    }];
    
    [task resume];
    
    return task;
}

@end
