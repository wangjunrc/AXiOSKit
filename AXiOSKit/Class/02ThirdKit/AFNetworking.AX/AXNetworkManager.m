//
//  AXNetworkManager.m
//  AXiOSKitExample
//
//  Created by liuweixing on 2019/12/26.
//  Copyright © 2019 liu.weixing. All rights reserved.
//

#import "AXNetworkManager.h"
#import <AFNetworking/AFNetworking.h>

@interface AXNetworkManager ()

@property(nonatomic, strong) AFHTTPSessionManager *afnManager;
@property(nonatomic, copy) NSString *baseURLString;
@property(nonatomic, copy) NSString *path;
@property(nonatomic, copy) NSString *httpMethod;
@property(nonatomic, strong) id addParameters;
@property(nonatomic, strong) NSDictionary <NSString *, NSString *> *addHeaders;
@property(nonatomic, copy) void (^progressBlock)(NSProgress *progress);
@property(nonatomic, copy) void (^successBlock)(id successHandlerJson);
@property(nonatomic, copy) void (^failureBlock)(NSError *error);
@property(nonatomic, strong) NSURLSessionDataTask *afSessionDataTask;

@end

@implementation AXNetworkManager

+ (AXNetworkManager *)manager {
    AXNetworkManager *manager = [[AXNetworkManager alloc] init];
    
    return manager;
}

+ (AXNetworkManager *_Nonnull (^)(NSString *_Nonnull))managerWithURL {
    __weak typeof(self) weakSelf = self;
    return ^AXNetworkManager *(NSString *managerWithURL) {
        __strong __typeof(&*weakSelf) strongSelf = weakSelf;
        if (strongSelf == nil) {
            return nil;
        }
        
        AXNetworkManager *manager = AXNetworkManager.manager;
        manager.baseURLString = managerWithURL;
        return manager;
    };
}

- (AXNetworkManager *_Nonnull (^)(AxRequestSerializerType))requestSerializer {
    __weak typeof(self) weakSelf = self;
    return ^AXNetworkManager *(AxRequestSerializerType serializerType) {
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        switch (serializerType) {
            case AxRequestSerializerTypePropertyList:
                strongSelf.afnManager.requestSerializer =
                [AFJSONRequestSerializer serializer];
                break;
                
            default:
                strongSelf.afnManager.requestSerializer =
                [AFPropertyListRequestSerializer serializer];
                break;
        }
        return self;
    };
}

- (AXNetworkManager *_Nonnull (^)(NSString *_Nonnull))get {
    __weak typeof(self) weakSelf = self;
    return ^AXNetworkManager *(NSString *pathOrFullURLString) {
        __strong __typeof(&*weakSelf) strongSelf = weakSelf;
        if (strongSelf == nil) {
            return nil;
        }
        
        strongSelf.path = pathOrFullURLString;
        strongSelf.httpMethod = @"GET";
        return strongSelf;
    };
}

- (AXNetworkManager *_Nonnull (^)(NSString *_Nonnull))post {
    __weak typeof(self) weakSelf = self;
    return ^AXNetworkManager *(NSString *pathOrFullURLString) {
        __strong __typeof(&*weakSelf) strongSelf = weakSelf;
        if (strongSelf == nil) {
            return nil;
        }
        strongSelf.path = pathOrFullURLString;
        strongSelf.httpMethod = @"POST";
        return strongSelf;
    };
}
- (AXNetworkManager *_Nonnull (^)(NSString *_Nonnull))delete {
    __weak typeof(self) weakSelf = self;
    return ^AXNetworkManager *(NSString *pathOrFullURLString) {
        __strong __typeof(&*weakSelf) strongSelf = weakSelf;
        if (strongSelf == nil) {
            return nil;
        }
        strongSelf.path = pathOrFullURLString;
        strongSelf.httpMethod = @"DELETE";
        return strongSelf;
    };
}


- (AXNetworkManager *_Nonnull (^)(id _Nonnull))parameters {
    __weak typeof(self) weakSelf = self;
    return ^AXNetworkManager *(id parameters) {
        __strong __typeof(&*weakSelf) strongSelf = weakSelf;
        if (strongSelf == nil) {
            return nil;
        }
        
        strongSelf.addParameters = parameters;
        return strongSelf;
    };
}

- (AXNetworkManager *_Nonnull (^)(id _Nonnull))headers {
    __weak typeof(self) weakSelf = self;
    return ^AXNetworkManager *(NSDictionary <NSString *, NSString *> *headers) {
        __strong __typeof(&*weakSelf) strongSelf = weakSelf;
        if (strongSelf == nil) {
            return nil;
        }
        strongSelf.addHeaders = headers;
        return strongSelf;
    };
}



- (void (^)(void))cancel {
    __weak typeof(self) weakSelf = self;
    return ^(void) {
        __strong __typeof(&*weakSelf) strongSelf = weakSelf;
        [strongSelf.afSessionDataTask cancel];
    };
}

- (AXNetworkManager *_Nonnull (^)(void (^_Nonnull)(NSProgress *_Nonnull)))
progress {
    __weak typeof(self) weakSelf = self;
    return ^AXNetworkManager *(void (^progressBlock)(NSProgress *_Nonnull)) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.progressBlock = progressBlock;
        return strongSelf;
    };
}

- (AXNetworkManager *_Nonnull (^)(void (^_Nonnull)(id _Nonnull)))success {
    __weak typeof(self) weakSelf = self;
    return ^AXNetworkManager *(void (^successBlock)(id _Nonnull json)) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.successBlock = successBlock;
        return self;
    };
}

- (AXNetworkManager *_Nonnull (^)(void (^_Nonnull)(NSError *_Nonnull)))failure {
    __weak typeof(self) weakSelf = self;
    
    return ^AXNetworkManager *(void (^failureBlock)(NSError *_Nonnull error)) {
        __strong typeof(weakSelf) self = weakSelf;
        self.failureBlock = failureBlock;
        
        return self;
    };
}

- (void (^)(void))start {
    __weak typeof(self) weakSelf = self;
    return ^(void) {
        __strong __typeof(&*weakSelf) self = weakSelf;
        if (self == nil) {
            return;
        }
        
        NSURLSessionDataTask *dataTask = nil;
        AFHTTPSessionManager * manager = nil;
        self.afnManager = manager;
        self.afSessionDataTask = dataTask;
        
        /// 这里不用懒加载
        if (self.baseURLString.length > 0) {
            manager = [[AFHTTPSessionManager alloc]
                       initWithBaseURL:[NSURL URLWithString:self.baseURLString]];
        } else {
            manager = [AFHTTPSessionManager manager];
        }
        //        AFHTTPRequestSerializer：第一种是普通的http的编码格式也就是mid=10&method=userInfo&dateInt=20160818，这种格式的。
        //        AFJSONRequestSerializer：第二种也是json编码格式的，也就是编码成{“mid”:“11”,“method”:“userInfo”,“dateInt”:“20160818”}
        //        AFPropertyListRequestSerializer：第三种没用过，但是看介绍接编码成pislt格式的参数
        
        
        /// 请求参数使用json格式
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        //返回数据的序列化器
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        
        dataTask =  [manager dataTaskWithHTTPMethod:self.httpMethod
                                          URLString:self.path
                                         parameters:self.addParameters
                                            headers:self.addHeaders
                                     uploadProgress:^(NSProgress *_Nonnull uploadProgress) {
            if (self.progressBlock) {
                self.progressBlock(uploadProgress);
            }
        }
                                   downloadProgress:nil
                                            success:^(NSURLSessionDataTask *_Nonnull task,
                                                      id _Nullable responseObject) {
            if (self.successBlock) {
                self.successBlock(responseObject);
            }
        }
                                            failure:^(NSURLSessionDataTask *_Nullable task,
                                                      NSError *_Nonnull error) {
            if (self.failureBlock) {
                self.failureBlock(error);
            }
        }];
        
        [dataTask resume];
    };
}


@end
