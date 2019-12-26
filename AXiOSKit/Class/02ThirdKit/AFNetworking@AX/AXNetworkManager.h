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
    AxRequestSerializerTypePropertyList,
};


@interface AXNetworkManager : NSObject

@property (class, nonatomic, readonly, strong)AXNetworkManager *manager;

@property (class, nonatomic, readonly, strong)AXNetworkManager *(^managerWithURL)(NSString *baseURL);;

@property (nonatomic, readonly, copy) AXNetworkManager *(^serializerType)(AxRequestSerializerType serializerType);

@property (nonatomic, readonly, copy) AXNetworkManager *(^post)(NSString *pathOrFullURLString);

@property (nonatomic, readonly, copy) AXNetworkManager *(^get)(NSString *pathOrFullURLString);

@property (nonatomic, readonly, copy) AXNetworkManager *(^addParameters)(id parameters);

@property (nonatomic, readonly, copy) AXNetworkManager *(^progressHandler)(void(^)(NSProgress  *progress));

@property (nonatomic, readonly, copy) AXNetworkManager *(^successHandler)(void(^)(id JSONObject));

@property (nonatomic, readonly, copy) AXNetworkManager *(^failureHandler)(void(^)(NSError *error));

@property (nonatomic, readonly, copy) void(^start)(void);

@end


NS_ASSUME_NONNULL_END
