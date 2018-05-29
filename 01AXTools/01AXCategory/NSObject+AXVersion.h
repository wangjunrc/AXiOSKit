//
//  NSObject+AXVersion.h
//  AXTools
//
//  Created by liuweixing on 16/4/6.
//  Copyright © 2016年 liuweixing All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (AXVersion)

/**
 请求AppStore,得到app的版本信息

 @param appid appid description
 @param block 得到app的版本信息
 */
-(void )ax_appStoreVersionAppid:(NSString *)appid success:(void(^)(NSString *appVersion))block;

/**
 工程版本号与AppStore版本号对比

 @param appid appid
 @param block 0>相同 1,2,3>顺序的版本不同
 */
-(void)ax_versionToServerVersionByAppid:(NSString *)appid success:(void(^)(NSInteger comp))block;

/**
 当前版本号,与本地保存的版本号是否一致
 
 @param different 不一样回调
 @param same 一样回调
 */
-(void)ax_versionDifferent:(void(^)(NSString *appVersion, NSString *saveVersion))different same:(void(^)(NSString *appVersion, NSString *saveVersion))same;

@end
