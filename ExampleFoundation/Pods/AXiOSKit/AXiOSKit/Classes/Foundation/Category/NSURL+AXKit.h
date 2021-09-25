//
//  NSURL+AXKit.h
//  AXiOSKit
//
//  Created by liuweixing on 16/6/17.
//  Copyright © 2016年 liuweixing All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURL (AXKit)

/// url 解析参数
@property(nonatomic, strong,readonly)NSDictionary<NSString*,NSString*>   *ax_URLComponents;

/// 添加URL参数,返回url 字符串
/// @param params 参数
-(NSURL *)ax_addingURLParams:(NSDictionary<NSString*,NSString*>*)params;


/// NSBundle 工程文件获得 NSURL
/// @param name 文件名
/// @param ext 拓展
+(instancetype )ax_mainBundleURLName:(NSString *)name
                           extension:(NSString *)ext;

/// NSBundle 工程文件获得 NSURL
/// @param name 文件名,含拓展
+(instancetype )ax_mainBundleURLName:(NSString *)name;

@end
