//
//  NSString+AXVersion.h
//  AXTools
//
//  Created by Mole Developer on 16/7/13.
//  Copyright © 2016年 mole. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (AXVersion)
/**
 * 请求AppStore,得到app的版本信息
 */
+(void )ax_appStoreVersionAppid:(NSString *)appid success:(void(^)(NSString *appVersion))block;

/**
 * 工程版本号与AppStore版本号对比 0>相同 1,2,3>顺序的版本不同
 */

+(void)ax_versionToServerVersionByAppid:(NSString *)appid success:(void(^)(NSInteger comp))block;


@end
