//
//  AXNetworkManager.m
//  AXiOSKitExample
//
//  Created by liuweixing on 2019/12/26.
//  Copyright © 2019 liu.weixing. All rights reserved.
//

#import "AXNetworkManager.h"
#import <AFNetworking/AFNetworking.h>

/**
 边框方向
 */
typedef NS_ENUM(NSInteger, AXHTTPMethodType) {
    AXHTTPMethodTypeGet = 0,//顶部
    AXHTTPMethodTypePost,//左边
    AXHTTPMethodTypePut,//底部
    AXHTTPMethodTypeDelete,//右边
};

@interface AXNetworkManager ()

@property (nonatomic, strong)AFHTTPSessionManager *anSessionManager;

@property (nonatomic, copy) NSString *baseURLString;
@property (nonatomic, copy) NSString *path;

@property (nonatomic, copy) NSString *HTTPMethod;

@property(nonatomic,assign)AXHTTPMethodType httpMethodType;

@property(nonatomic,strong)id parameters;

@property(nonatomic,assign,getter=isStarted)BOOL started;

@property (nonatomic, copy) void(^progressBlock)(NSProgress *progress);
@property (nonatomic, copy) void(^successBlock)(id successHandlerJson);
@property (nonatomic, copy) void(^failureBlock)(NSError *error);

@property(nonatomic, strong)NSURLSessionDataTask *afSessionDataTask;

@end

@implementation AXNetworkManager

+ (AXNetworkManager *)manager{
    
    AXNetworkManager *manager = [[AXNetworkManager alloc]init];
    
    return manager;
}

+ (AXNetworkManager * _Nonnull (^)(NSString * _Nonnull))managerWithURL {
    
    __weak typeof(self) weakSelf = self;
    return ^AXNetworkManager *(NSString *managerWithURL) {
        
        __strong __typeof(&*weakSelf)strongSelf = weakSelf;
        if (strongSelf == nil) {
            return nil;
        }
        
        AXNetworkManager *manager = AXNetworkManager.manager;
        manager.baseURLString = managerWithURL;
        return manager;
    };
}


#pragma mark - get 引用对应的block

- (AXNetworkManager * _Nonnull (^)(AxRequestSerializerType))requestSerializer {
    
    __weak typeof(self) weakSelf = self;
    return ^AXNetworkManager *(AxRequestSerializerType serializerType) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        switch (serializerType) {
            case AxRequestSerializerTypePropertyList:
                strongSelf.anSessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
                break;
                
            default:
                strongSelf.anSessionManager.requestSerializer = [AFPropertyListRequestSerializer serializer];
                break;
        }
        return self;
    };
    
}


- (AXNetworkManager * _Nonnull (^)(NSString * _Nonnull))get {
    __weak typeof(self) weakSelf = self;
    return ^AXNetworkManager *(NSString *pathOrFullURLString) {
        __strong __typeof(&*weakSelf)strongSelf = weakSelf;
        if (strongSelf == nil) {
            return nil;
        }
        
        strongSelf.path = pathOrFullURLString;
        strongSelf.httpMethodType =  AXHTTPMethodTypeGet;
        return strongSelf;
    };
}

- (AXNetworkManager * _Nonnull (^)(NSString * _Nonnull))post {
    __weak typeof(self) weakSelf = self;
    return ^AXNetworkManager *(NSString *pathOrFullURLString) {
        __strong __typeof(&*weakSelf)strongSelf = weakSelf;
        if (strongSelf == nil) {
            return nil;
        }
        strongSelf.path = pathOrFullURLString;
        strongSelf.httpMethodType =  AXHTTPMethodTypePost;
        return strongSelf;
    };
}

- (AXNetworkManager * _Nonnull (^)(id _Nonnull))addParameters {
    __weak typeof(self) weakSelf = self;
    return ^AXNetworkManager *(id parameters) {
        __strong __typeof(&*weakSelf)strongSelf = weakSelf;
        if (strongSelf == nil) {
            return nil;
        }
        
        strongSelf.parameters = parameters;
        return strongSelf;
    };
}

- (void (^)(void))start {
    
    __weak typeof(self) weakSelf = self;
    return ^(void) {
        __strong __typeof(&*weakSelf)strongSelf = weakSelf;
        if (strongSelf == nil) {
            return;
        }
        
        if (strongSelf.isStarted) {
            return;
        }
        strongSelf.started = YES;
        
        switch (strongSelf.httpMethodType) {
            case AXHTTPMethodTypeGet:
                [strongSelf __getStart];
                break;
                
            case AXHTTPMethodTypePost:
                [strongSelf __postStart];
                break;
                
            case AXHTTPMethodTypePut:
                [strongSelf __putStart];
                break;
                
            case AXHTTPMethodTypeDelete:
                [strongSelf __deleteStart];
                break;
                
            default:
                break;
        }
    };
}

- (void (^)(void))cancel {
    
    __weak typeof(self) weakSelf = self;
    return ^(void) {
        __strong __typeof(&*weakSelf)strongSelf = weakSelf;
        [strongSelf.afSessionDataTask cancel];
    };
}


- (AXNetworkManager * _Nonnull (^)(void (^ _Nonnull)(NSProgress * _Nonnull)))progressHandler {
    
    __weak typeof(self) weakSelf = self;
    return ^AXNetworkManager *(void (^progressBlock)(NSProgress * _Nonnull)){
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.progressBlock = progressBlock;
        return strongSelf;
    };
}

- (AXNetworkManager * _Nonnull (^)(void (^ _Nonnull)(id _Nonnull)))successHandler {
    
    __weak typeof(self) weakSelf = self;
    return ^AXNetworkManager *(void (^successBlock)(id _Nonnull json)){
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.successBlock = successBlock;
        return self;
    };
}

- (AXNetworkManager * _Nonnull (^)(void (^ _Nonnull)(NSError * _Nonnull)))failureHandler {
    
    __weak typeof(self) weakSelf = self;
    
    return ^AXNetworkManager *(void (^failureBlock)(NSError *_Nonnull error)){
        __strong typeof(weakSelf) self = weakSelf;
        self.failureBlock = failureBlock;
        
        return self;
    };
}


#pragma mark - 引用Handler
-(void)__progress:(NSProgress *_Nullable)progress {
    if (self.progressBlock) {
        self.progressBlock(progress);
    }
}

-(void)__success:(id )responseObject {
    if (self.successBlock) {
        self.successBlock([self handleResponse:responseObject]);
    }
}


-(void)__failure:(NSError *)error {
    
    if (self.failureBlock) {
        self.failureBlock(error);
    }
}

#pragma mark - 调用 get post put delete 方法
-(void)__getStart{
    
    
    self.afSessionDataTask = [self.anSessionManager GET:self.path parameters:self.parameters headers:nil  progress:^(NSProgress * _Nonnull uploadProgress) {
        self.started = NO;
        [self __progress:uploadProgress];
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.started = NO;
        [self __success:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        self.started = NO;
        [self __failure:error];
    }];
}

-(void)__postStart{
    
    self.afSessionDataTask = [self.anSessionManager POST:self.path parameters:self.parameters headers:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        self.started = NO;
        [self __progress:uploadProgress];
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.started = NO;
        [self __success:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        self.started = NO;
        [self __failure:error];
    }];
    
}

-(void)__putStart{
    
    self.afSessionDataTask = [self.anSessionManager PUT:self.path parameters:self.parameters headers:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.started = NO;
        [self __success:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        self.started = NO;
        [self __failure:error];
    }];
}

-(void)__deleteStart{
    
    self.afSessionDataTask = [self.anSessionManager DELETE:self.path parameters:self.parameters headers:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.started = NO;
        [self __success:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        self.started = NO;
        [self __failure:error];
    }];
}


-(id)handleResponse:(id)responseObject{
    
    id json = nil;
    NSString *responseStr = [[responseObject class]description];
    
    if ([responseStr isEqualToString:@"_NSInlineData"]) {
        
        json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
    }else{
        json = responseObject;
    }
    return json;
}

#pragma mark - set and get
- (AFHTTPSessionManager *)anSessionManager {
    
    if (!_anSessionManager) {
        
        if (self.baseURLString.length > 0) {
            _anSessionManager = [[AFHTTPSessionManager alloc]initWithBaseURL:[NSURL URLWithString:self.baseURLString]];
        }else{
            _anSessionManager = [AFHTTPSessionManager manager];
        }
        
        _anSessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    }
    return _anSessionManager;
}
@end
