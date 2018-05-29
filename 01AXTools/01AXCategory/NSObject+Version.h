//
//  NSObject+Version.h
//  AXTools
//
//  Created by liuweixing on 16/3/29.
//  Copyright © 2016年 liuweixing All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Version)

/**
 当前版本号,与本地保存的版本号是否一致
 
 @param different 不一样回调
 @param same 一样回调
 */
-(void)ax_versionDifferent:(void(^)(NSString *appVersion, NSString *saveVersion))different same:(void(^)(NSString *appVersion, NSString *saveVersion))same;

@end
