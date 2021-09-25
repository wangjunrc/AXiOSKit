//
//  NSURL+AXKit.m
//  AXiOSKit
//
//  Created by liuweixing on 16/6/17.
//  Copyright © 2016年 liuweixing All rights reserved.
//

#import "NSURL+AXKit.h"
#import "NSString+AXURL.h"

@implementation NSURL (AXKit)

/// url 解析参数
-(NSDictionary<NSString*,NSString*>  *)ax_URLComponents {
    return self.absoluteString.ax_URLComponents;
}

/// 添加URL参数,返回url 字符串
/// @param params 参数
-(NSURL *)ax_addingURLParams:(NSDictionary<NSString*,NSString*>*)params {
    return [NSURL URLWithString:[self.absoluteString ax_addingURLParams:params]];
}


/// NSBundle 工程文件获得 NSURL
/// @param name 文件名
/// @param ext 拓展
+(instancetype )ax_mainBundleURLName:(NSString *)name
                             extension:(NSString *)ext {
    /// 本地 data
    NSString *path = [NSBundle.mainBundle pathForResource:name ofType:ext];
    return [NSURL fileURLWithPath:path];
}


+(instancetype ) ax_mainBundleURLName:(NSString *)name {
    return [self ax_mainBundleURLName:name extension:nil];
}



@end
