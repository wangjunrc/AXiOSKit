//
//  AXNetworkManager.h
//  AXiOSKitExample
//
//  Created by liuweixing on 2019/12/26.
//  Copyright © 2019 liu.weixing. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, AxRequestSerializerType) {
    AxRequestSerializerTypeJSON = 0,
    AxRequestSerializerTypePropertyList,///参数中含有list,一般很少用
};


@interface AXNetworkManager : NSObject

/// 实例,不是单利模式
@property (class, nonatomic, readonly, strong)AXNetworkManager *manager;

/// host
@property (class, nonatomic, readonly, strong)AXNetworkManager *(^managerWithURL)(NSString *baseURL);

/// 请求序列化方式
@property (nonatomic, readonly, copy) AXNetworkManager *(^requestSerializer)(AxRequestSerializerType requestSerializerType);

/// get请求
@property (nonatomic, readonly, copy) AXNetworkManager *(^get)(NSString *pathOrFullURLString);

/// post请求
@property (nonatomic, readonly, copy) AXNetworkManager *(^post)(NSString *pathOrFullURLString);

/// post请求
@property (nonatomic, readonly, copy) AXNetworkManager *(^delete)(NSString *pathOrFullURLString);

/// 添加参数
@property (nonatomic, readonly, copy) AXNetworkManager *(^parameters)(id parameters);

/// 添加请求头
@property (nonatomic, readonly, copy) AXNetworkManager *(^headers)(NSDictionary <NSString *, NSString *> *headers);

/// 请求进度
@property (nonatomic, readonly, copy) AXNetworkManager *(^progress)(void(^)(NSProgress  *progress));

/// 请求成功
@property (nonatomic, readonly, copy) AXNetworkManager *(^success)(void(^)(id responseObject));

/// 请求失败
@property (nonatomic, readonly, copy) AXNetworkManager *(^failure)(void(^)(NSError *error));

/// 开始请求,
@property (nonatomic, readonly, copy) void(^start)(void);

/// 取消请求
@property (nonatomic, readonly, copy) void(^cancel)(void);

@end


NS_ASSUME_NONNULL_END
