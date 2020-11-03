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
@property (nonatomic, copy, readonly) AXNetworkManager *(^requestSerializer)(AxRequestSerializerType requestSerializerType);

/// get请求
@property (nonatomic, copy, readonly) AXNetworkManager *(^get)(NSString *pathOrFullURLString);

/// post请求
@property (nonatomic, copy, readonly) AXNetworkManager *(^post)(NSString *pathOrFullURLString);

/// delete请求
@property (nonatomic, copy, readonly) AXNetworkManager *(^delete)(NSString *pathOrFullURLString);

/// 添加参数
@property (nonatomic, copy, readonly) AXNetworkManager *(^parameters)(id parameters);

/// 添加请求头
@property (nonatomic, copy, readonly) AXNetworkManager *(^headers)(NSDictionary <NSString *, NSString *> *headers);

/// 请求进度
@property (nonatomic, copy, readonly) AXNetworkManager *(^progress)(void(^)(NSProgress  *progress));

/// 请求成功
@property (nonatomic, copy, readonly) AXNetworkManager *(^success)(void(^)(id responseObject));

/// 请求失败
@property (nonatomic, copy, readonly) AXNetworkManager *(^failure)(void(^)(NSError *error));

/// 开始请求,
@property (nonatomic, copy, readonly) void(^start)(void);

/// 取消请求
@property (nonatomic, copy, readonly) void(^cancel)(void);

@end


NS_ASSUME_NONNULL_END
